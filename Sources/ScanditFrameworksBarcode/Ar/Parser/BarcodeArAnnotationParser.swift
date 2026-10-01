/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture
import ScanditBarcodeCaptureDeserializer
import ScanditCaptureCore
import ScanditFrameworksCore
import UIKit

public enum FrameworksBarcodeArAnnotationEvents: String, CaseIterable {
    case didTapPopover = "BarcodeArPopoverAnnotationListener.didTapPopover"
    case didTapPopoverButton = "BarcodeArPopoverAnnotationListener.didTapPopoverButton"
    case didTapInfoAnnotationFooter = "BarcodeArInfoAnnotationListener.didTapInfoAnnotationFooter"
    case didTapInfoAnnotationHeader = "BarcodeArInfoAnnotationListener.didTapInfoAnnotationHeader"
    case didTapInfoAnnotation = "BarcodeArInfoAnnotationListener.didTapInfoAnnotation"
    case didTapInfoAnnotationLeftIcon = "BarcodeArInfoAnnotationListener.didTapInfoAnnotationLeftIcon"
    case didTapInfoAnnotationRightIcon = "BarcodeArInfoAnnotationListener.didTapInfoAnnotationRightIcon"
}

public class BarcodeArAnnotationParser {
    private let viewId: Int
    private let emitter: Emitter

    // Plain (non-responsive) info annotations share this single delegate.
    private var infoAnnotationDelegate: FrameworksInfoAnnotationDelegate?
    // Responsive info annotations need one delegate per threshold slot, since their emits need
    // to identify which slot's annotation was interacted with (they can share a barcodeId).
    // Keyed by the same string form of the threshold used in the annotationsByThreshold JSON
    // (or "closeUp"/"farAway" for the legacy two-slot JSON shape); delegates are cached and
    // refreshed in place across updates rather than recreated, so a listener registered on a
    // still-live child annotation keeps working.
    private var responsiveInfoAnnotationDelegates: [String: FrameworksInfoAnnotationDelegate] = [:]
    private var popoverAnnotationDelegate: FrameworksPopoverAnnotationDelegate?
    private var cache: BarcodeArAugmentationsCache?

    init(viewId: Int, emitter: Emitter) {
        self.viewId = viewId
        self.emitter = emitter

        infoAnnotationDelegate = FrameworksInfoAnnotationDelegate(
            emitter: emitter,
            viewId: viewId,
            responsiveAnnotationType: nil
        )
    }

    func setDelegates(
        popoverAnnotationDelegate: FrameworksPopoverAnnotationDelegate,
        cache: BarcodeArAugmentationsCache
    ) {
        self.popoverAnnotationDelegate = popoverAnnotationDelegate
        self.cache = cache
    }

    func get(json: JSONValue, barcode: Barcode, emitter: Emitter) -> (UIView & BarcodeArAnnotation)? {
        guard let type = json.optionalString(forKey: "type") else {
            Log.error("Missing type in JSON.")
            return nil
        }

        switch type {
        case "barcodeArInfoAnnotation":
            return getInfoAnnotation(barcode: barcode, json: json)
        case "barcodeArPopoverAnnotation":
            return getPopoverAnnotation(barcode: barcode, json: json)
        case "barcodeArStatusIconAnnotation":
            return getStatusIconAnnotation(barcode: barcode, json: json)
        case "barcodeArResponsiveAnnotation":
            return getResponsiveAnnotation(barcode: barcode, json: json)
        case "barcodeArCustomAnnotation":
            return BarcodeArCustomAnnotation(barcode: barcode, emitter: emitter, json: json, viewId: viewId)
        default:
            Log.error("Not supported annotation type.", error: NSError(domain: "Type \(type)", code: -1))
            return nil
        }
    }

    func updateAnnotation(_ annotation: BarcodeArAnnotation, json: JSONValue) {
        switch annotation {
        case let infoAnnotation as BarcodeArInfoAnnotation:
            guard let barcodeId = json.optionalString(forKey: "barcodeId") else {
                Log.error("Missing barcodeId in JSON.")
                return
            }
            updateInfoAnnotation(infoAnnotation, json, barcodeId)
        case let responsiveAnnotation as BarcodeArResponsiveAnnotation:
            updateResponsiveAnnotation(annotation: responsiveAnnotation, json: json)
        case let statusIconAnnotation as BarcodeArStatusIconAnnotation:
            let iconJson = json.getObjectAsString(forKey: "icon")
            updateStatusIconAnnotation(statusIconAnnotation, iconJson, json)
        case let popoverAnnotation as BarcodeArPopoverAnnotation:
            updatePopoverAnnotation(popoverAnnotation, json, popoverAnnotation.barcode)
        case let customAnnotation as BarcodeArCustomAnnotation:
            var trigger = customAnnotation.annotationTrigger
            SDCBarcodeArAnnotationTriggerFromJSONString(json.string(forKey: "annotationTrigger"), &trigger)
            customAnnotation.annotationTrigger = trigger
        default:
            Log.error("Unsupported annotation type")
        }
    }

    func updateBarcodeArPopoverButton(_ annotation: BarcodeArPopoverAnnotation, json: JSONValue) {
        guard let index = json.optionalInt(forKey: "index") else {
            Log.error("Invalid index received when trying to update the updateBarcodeArPopoverButton.")
            return
        }

        if index < 0 {
            Log.error(
                "Invalid index received when trying to update the updateBarcodeArPopoverButton.",
                error: NSError(domain: "Index \(index)", code: -1)
            )
            return
        }

        if index > annotation.buttons.count - 1 {
            Log.error(
                "Invalid index received when trying to update the updateBarcodeArPopoverButton",
                error: NSError(domain: "Buttons Size \(annotation.buttons.count), Index \(index)", code: -1)
            )
            return
        }

        let button = annotation.buttons[index]
        if let textColorHex = json.optionalString(forKey: "textColor"),
            let textColor = UIColor(sdcHexString: textColorHex)
        {
            button.textColor = textColor
        }
        button.font = json.getFont(forSizeKey: "textSize", andFamilyKey: "fontFamily")
        button.isEnabled = json.bool(forKey: "enabled", default: true)
    }
}

// MARK: - Barcode Ar Info Annotation

private extension BarcodeArAnnotationParser {

    private func getInfoAnnotation(barcode: Barcode, json: JSONValue) -> BarcodeArInfoAnnotation? {
        let annotation = BarcodeArInfoAnnotation(barcode: barcode)

        updateInfoAnnotation(annotation, json, barcode.uniqueId)

        return annotation
    }

    /// The close-up (threshold 1.0) and far-away (lowest threshold) slots are tagged so their
    /// emits can be told apart; every other in-between slot has no type.
    private func responsiveAnnotationType(
        for threshold: CGFloat,
        minThreshold: CGFloat?
    ) -> ResponsiveAnnotationType? {
        if threshold == 1.0 {
            return .closeUp
        }
        if threshold == minThreshold {
            return .farAway
        }
        return nil
    }

    /// Returns the cached delegate for a responsive-annotation threshold slot, creating it on
    /// first use and refreshing its type/threshold on every call (the underlying threshold value
    /// can change across updates, e.g. via the deprecated `threshold` setter).
    private func responsiveDelegate(
        slotKey: String,
        threshold: Double,
        responsiveAnnotationType: ResponsiveAnnotationType?
    ) -> FrameworksInfoAnnotationDelegate {
        if let existing = responsiveInfoAnnotationDelegates[slotKey] {
            existing.responsiveAnnotationType = responsiveAnnotationType
            existing.responsiveAnnotationThreshold = threshold
            return existing
        }
        let delegate = FrameworksInfoAnnotationDelegate(
            emitter: emitter,
            viewId: viewId,
            responsiveAnnotationType: responsiveAnnotationType,
            responsiveAnnotationThreshold: threshold
        )
        responsiveInfoAnnotationDelegates[slotKey] = delegate
        return delegate
    }

    private func updateInfoAnnotation(
        _ annotation: BarcodeArInfoAnnotation,
        _ json: JSONValue,
        _ barcodeId: String,
        _ responsiveDelegate: FrameworksInfoAnnotationDelegate? = nil
    ) {
        annotation.hasTip = json.bool(forKey: "hasTip", default: false)
        annotation.isEntireAnnotationTappable = json.bool(forKey: "isEntireAnnotationTappable", default: false)
        if let anchorJson = json.optionalString(forKey: "anchor") {
            var anchor = BarcodeArInfoAnnotationAnchor.bottom
            SDCBarcodeArInfoAnnotationAnchorFromJSONString(anchorJson, &anchor)
            annotation.anchor = anchor
        }

        if let widthJson = json.optionalString(forKey: "width") {
            var width = BarcodeArInfoAnnotationWidthPreset.small
            SDCBarcodeArInfoAnnotationWidthPresetFromJSONString(widthJson, &width)
            annotation.width = width
        }

        if json.containsKey("header") {
            annotation.header = parseInfoAnnotationHeader(json.object(forKey: "header"))
        }

        if json.containsKey("footer") {
            annotation.footer = parseInfoAnnotationFooter(json.object(forKey: "footer"))
        }

        let bodyComponentsJson = json.array(forKey: "body")
        var bodyComponents: [BarcodeArInfoAnnotationBodyComponent] = []
        for index in 0..<bodyComponentsJson.count() {
            let bodyJson = bodyComponentsJson.atIndex(index)
            if let component = getBarcodeArInfoAnnotationBodyComponent(json: bodyJson) {
                bodyComponents.append(component)
            }
        }
        annotation.body = bodyComponents

        if json.bool(forKey: "hasListener", default: false) {
            // Always reassign, as Android does: on a threshold remap the resolved delegate is a
            // different object carrying the new threshold, and gating on `delegate == nil` would
            // keep the stale one, so taps would be emitted under a threshold the framework no
            // longer knows about and silently dropped.
            annotation.delegate = responsiveDelegate ?? infoAnnotationDelegate
        } else {
            annotation.delegate = nil
        }

        var trigger = BarcodeArAnnotationTrigger.highlightTap
        SDCBarcodeArAnnotationTriggerFromJSONString(json.string(forKey: "annotationTrigger"), &trigger)
        annotation.annotationTrigger = trigger
    }

    private func updateResponsiveAnnotation(annotation: BarcodeArResponsiveAnnotation, json: JSONValue) {
        if json.containsKey("annotationsByThreshold") {
            let thresholdsJson = json.object(forKey: "annotationsByThreshold")
            let existingByThreshold = annotation.annotationsByThreshold
            let minThreshold = existingByThreshold.keys.min()

            // Both sides derive the number from the same string form (Dart's `threshold.toString()`),
            // so exact key equality normally hits without an epsilon comparison. It can still miss:
            // the native annotation's thresholds are fixed at construction, while the deprecated
            // `threshold` setter changes the key the framework sends. In that case we pair the
            // incoming slots with the existing ones by ascending threshold order, so a slot's
            // configuration still reaches its annotation (which is what the pre-N-state
            // `.first`/`.last` path did unconditionally).
            let sortedIncoming = thresholdsJson.keys().compactMap { key -> (key: String, threshold: CGFloat)? in
                guard let threshold = Double(key) else {
                    Log.error("Invalid annotationsByThreshold key received.", error: NSError(domain: key, code: -1))
                    return nil
                }
                return (key: key, threshold: CGFloat(threshold))
            }.sorted { $0.threshold < $1.threshold }
            let keysMatchExisting = sortedIncoming.allSatisfy { existingByThreshold.keys.contains($0.threshold) }
            let sortedExistingKeys = existingByThreshold.keys.sorted()

            if !keysMatchExisting {
                Log.info(
                    "The received annotationsByThreshold keys do not match the ones the annotation was built "
                        + "with; remapping the slots by ascending threshold order. Rebuild the annotation "
                        + "instead of using the deprecated threshold setter, which is removed in 9.0."
                )
            }

            for (index, incoming) in sortedIncoming.enumerated()
            where thresholdsJson.containsObject(withKey: incoming.key) {
                let resolvedThreshold: CGFloat
                if keysMatchExisting {
                    resolvedThreshold = incoming.threshold
                } else if index < sortedExistingKeys.count {
                    resolvedThreshold = sortedExistingKeys[index]
                } else {
                    Log.error(
                        "Received an annotationsByThreshold update with more slots than the annotation was built with."
                    )
                    continue
                }

                guard let childAnnotation = existingByThreshold[resolvedThreshold] ?? nil else { continue }

                let delegate = responsiveDelegate(
                    slotKey: incoming.key,
                    threshold: Double(incoming.threshold),
                    responsiveAnnotationType: responsiveAnnotationType(
                        for: incoming.threshold,
                        minThreshold: minThreshold
                    )
                )
                updateInfoAnnotation(
                    childAnnotation,
                    thresholdsJson.object(forKey: incoming.key),
                    annotation.barcode.uniqueId,
                    delegate
                )
            }
        } else {
            // Legacy fallback, behaviour identical to before the annotationsByThreshold JSON key existed.
            let sortedByThreshold = annotation.annotationsByThreshold.sorted { $0.key < $1.key }
            let farAway = sortedByThreshold.first?.value ?? nil
            let closeUp = sortedByThreshold.last?.value ?? nil

            if let closeUp = closeUp {
                let closeUpJson = json.object(forKey: "closeUpAnnotation")
                let delegate = responsiveDelegate(
                    slotKey: "closeUp",
                    threshold: 1.0,
                    responsiveAnnotationType: .closeUp
                )
                updateInfoAnnotation(closeUp, closeUpJson, annotation.barcode.uniqueId, delegate)
            }
            if let farAway = farAway {
                let farAwayJson = json.object(forKey: "farAwayAnnotation")
                let threshold = Double(json.cgFloat(forKey: "threshold"))
                let delegate = responsiveDelegate(
                    slotKey: "farAway",
                    threshold: threshold,
                    responsiveAnnotationType: .farAway
                )
                updateInfoAnnotation(farAway, farAwayJson, annotation.barcode.uniqueId, delegate)
            }
        }

        var trigger = BarcodeArAnnotationTrigger.highlightTap
        SDCBarcodeArAnnotationTriggerFromJSONString(json.string(forKey: "annotationTrigger"), &trigger)
    }

    private func parseInfoAnnotationHeader(_ json: JSONValue) -> BarcodeArInfoAnnotationHeader {
        let annotationHeader = BarcodeArInfoAnnotationHeader()
        do {

            if json.containsKey("icon") {
                let headerIconJson = json.getObjectAsString(forKey: "icon")
                annotationHeader.icon = try ScanditIcon(fromJSONString: headerIconJson)
            }
            annotationHeader.text = json.optionalString(forKey: "text")
            if let headerBackgroundColorHex = json.optionalString(forKey: "backgroundColor"),
                let headerBackgroundColor = UIColor(sdcHexString: headerBackgroundColorHex)
            {
                annotationHeader.backgroundColor = headerBackgroundColor
            }
            if let headerTextColorHex = json.optionalString(forKey: "textColor"),
                let headerTextColor = UIColor(sdcHexString: headerTextColorHex)
            {
                annotationHeader.textColor = headerTextColor
            }
            annotationHeader.font = json.getFont(forSizeKey: "textSize", andFamilyKey: "fontFamily")
        } catch {
            Log.error("Unable to parse the BarcodeArInfoAnnotation header from the given json.", error: error)
        }
        return annotationHeader
    }

    private func parseInfoAnnotationFooter(_ json: JSONValue) -> BarcodeArInfoAnnotationFooter {
        let annotationFooter = BarcodeArInfoAnnotationFooter()
        do {

            if json.containsKey("icon") {
                let footerIconJson = json.getObjectAsString(forKey: "icon")
                annotationFooter.icon = try ScanditIcon(fromJSONString: footerIconJson)
            }
            annotationFooter.text = json.optionalString(forKey: "text")
            if let footerBackgroundColorHex = json.optionalString(forKey: "backgroundColor"),
                let footerBackgroundColor = UIColor(sdcHexString: footerBackgroundColorHex)
            {
                annotationFooter.backgroundColor = footerBackgroundColor
            }
            if let footerTextColorHex = json.optionalString(forKey: "textColor"),
                let footerTextColor = UIColor(sdcHexString: footerTextColorHex)
            {
                annotationFooter.textColor = footerTextColor
            }
            annotationFooter.font = json.getFont(forSizeKey: "textSize", andFamilyKey: "fontFamily")
        } catch {
            Log.error("Unable to parse the BarcodeArInfoAnnotation footer from the given json.", error: error)
        }
        return annotationFooter
    }

    private func getBarcodeArInfoAnnotationBodyComponent(
        json: JSONValue
    ) -> BarcodeArInfoAnnotationBodyComponent? {
        do {
            let bodyComponent = BarcodeArInfoAnnotationBodyComponent()
            bodyComponent.text = json.optionalString(forKey: "text")
            if let textColorHex = json.optionalString(forKey: "textColor"),
                let textColor = UIColor(sdcHexString: textColorHex)
            {
                bodyComponent.textColor = textColor
            }
            bodyComponent.textAlignment = json.getTextAlignment(forKey: "textAlign")
            bodyComponent.isLeftIconTappable = json.bool(forKey: "isLeftIconTappable", default: false)
            if json.containsKey("leftIcon") {
                let leftIconJson = json.getObjectAsString(forKey: "leftIcon")
                bodyComponent.leftIcon = try ScanditIcon(fromJSONString: leftIconJson)
            }
            bodyComponent.isRightIconTappable = json.bool(forKey: "isRightIconTappable", default: false)
            if json.containsKey("rightIcon") {
                let rightIconJson = json.getObjectAsString(forKey: "rightIcon")
                bodyComponent.rightIcon = try ScanditIcon(fromJSONString: rightIconJson)
            }
            return bodyComponent
        } catch {
            Log.error("Unable to parse the BarcodeArInfoAnnotationBodyElement from the provided json.", error: error)
            return nil
        }
    }
}

// MARK: - Barcode Ar Popover Annotation

private extension BarcodeArAnnotationParser {

    private func getPopoverAnnotation(barcode: Barcode, json: JSONValue) -> BarcodeArPopoverAnnotation? {
        do {
            let annotationButtons = json.array(forKey: "buttons")

            var buttons: [BarcodeArPopoverAnnotationButton] = []

            for index in 0..<annotationButtons.count() {
                let buttonJson = annotationButtons.atIndex(index)

                let iconJson = buttonJson.getObjectAsString(forKey: "icon")
                let text = buttonJson.string(forKey: "text")

                let button = BarcodeArPopoverAnnotationButton(
                    icon: try ScanditIcon(fromJSONString: iconJson),
                    text: text
                )
                updatePopoverButton(json, button)
                buttons.append(button)
            }

            let annotation = BarcodeArPopoverAnnotation(barcode: barcode, buttons: buttons)
            updatePopoverAnnotation(annotation, json, barcode)

            return annotation
        } catch {
            Log.error("Unable to parse the BarcodeArPopoverAnnotation from the provided json.", error: error)
            return nil
        }
    }

    private func updatePopoverAnnotation(
        _ annotation: BarcodeArPopoverAnnotation,
        _ json: JSONValue,
        _ barcode: Barcode
    ) {
        if let anchorJson = json.optionalString(forKey: "anchor") {
            switch anchorJson {
            case "top": annotation.anchor = .top
            case "left": annotation.anchor = .left
            case "right": annotation.anchor = .right
            default: annotation.anchor = .bottom
            }
        }
        annotation.isEntirePopoverTappable = json.bool(forKey: "isEntirePopoverTappable", default: false)
        if json.bool(forKey: "hasListener", default: false) {
            if annotation.delegate == nil {
                annotation.delegate = self.popoverAnnotationDelegate
            }
        } else {
            annotation.delegate = nil
        }
        var trigger = BarcodeArAnnotationTrigger.highlightTap
        SDCBarcodeArAnnotationTriggerFromJSONString(json.string(forKey: "annotationTrigger"), &trigger)
        annotation.annotationTrigger = trigger
    }

    private func updatePopoverButton(_ json: JSONValue, _ button: BarcodeArPopoverAnnotationButton) {
        if let textColorHex = json.optionalString(forKey: "textColor"),
            let textColor = UIColor(sdcHexString: textColorHex)
        {
            button.textColor = textColor
        }

        button.font = json.getFont(forSizeKey: "textSize", andFamilyKey: "fontFamily")
        button.isEnabled = json.bool(forKey: "enabled", default: true)
    }
}

// MARK: - Barcode Ar Status Icon Annotation

private extension BarcodeArAnnotationParser {

    private func getStatusIconAnnotation(barcode: Barcode, json: JSONValue) -> BarcodeArStatusIconAnnotation? {
        if json.containsKey("icon") == false {
            Log.error("Missing icon in status icon annotation JSON.")
            return nil
        }
        let annotation = BarcodeArStatusIconAnnotation(barcode: barcode)
        updateStatusIconAnnotation(annotation, json.getObjectAsString(forKey: "icon"), json)
        return annotation
    }

    private func getResponsiveAnnotation(barcode: Barcode, json: JSONValue) -> BarcodeArResponsiveAnnotation? {
        if json.containsKey("annotationsByThreshold") {
            let thresholdsJson = json.object(forKey: "annotationsByThreshold")
            let keys = thresholdsJson.keys()
            let numericKeys = keys.compactMap { Double($0).map { CGFloat($0) } }
            let minThreshold = numericKeys.min()

            var annotationsByThreshold: [CGFloat: BarcodeArInfoAnnotation?] = [:]
            for key in keys {
                guard let parsedKey = Double(key) else {
                    Log.error("Invalid annotationsByThreshold key received.", error: NSError(domain: key, code: -1))
                    continue
                }
                let threshold = CGFloat(parsedKey)
                if thresholdsJson.containsObject(withKey: key) {
                    let childAnnotation = BarcodeArInfoAnnotation(barcode: barcode)
                    let delegate = responsiveDelegate(
                        slotKey: key,
                        threshold: parsedKey,
                        responsiveAnnotationType: responsiveAnnotationType(for: threshold, minThreshold: minThreshold)
                    )
                    updateInfoAnnotation(
                        childAnnotation,
                        thresholdsJson.object(forKey: key),
                        barcode.uniqueId,
                        delegate
                    )
                    annotationsByThreshold.updateValue(childAnnotation, forKey: threshold)
                } else {
                    annotationsByThreshold.updateValue(nil, forKey: threshold)
                }
            }

            let annotation = BarcodeArResponsiveAnnotation(
                barcode: barcode,
                annotationsByThreshold: annotationsByThreshold
            )
            updateResponsiveAnnotation(annotation: annotation, json: json)
            return annotation
        }

        // Legacy fallback, behaviour identical to before the annotationsByThreshold JSON key existed.
        var closeUpAnnotation: BarcodeArInfoAnnotation?
        var farawayAnnotation: BarcodeArInfoAnnotation?

        if json.containsKey("closeUpAnnotation") {
            let annotation = BarcodeArInfoAnnotation(barcode: barcode)
            let delegate = responsiveDelegate(slotKey: "closeUp", threshold: 1.0, responsiveAnnotationType: .closeUp)
            updateInfoAnnotation(annotation, json.object(forKey: "closeUpAnnotation"), barcode.uniqueId, delegate)
            closeUpAnnotation = annotation
        }

        if json.containsKey("farAwayAnnotation") {
            let threshold = json.cgFloat(forKey: "threshold")
            let annotation = BarcodeArInfoAnnotation(barcode: barcode)
            let delegate = responsiveDelegate(
                slotKey: "farAway",
                threshold: Double(threshold),
                responsiveAnnotationType: .farAway
            )
            updateInfoAnnotation(annotation, json.object(forKey: "farAwayAnnotation"), barcode.uniqueId, delegate)
            farawayAnnotation = annotation
        }

        let threshold = json.cgFloat(forKey: "threshold")
        let annotation = BarcodeArResponsiveAnnotation(
            barcode: barcode,
            annotationsByThreshold: [threshold: farawayAnnotation, 1.0: closeUpAnnotation]
        )
        updateResponsiveAnnotation(annotation: annotation, json: json)
        return annotation
    }

    private func updateStatusIconAnnotation(
        _ annotation: BarcodeArStatusIconAnnotation,
        _ iconJson: String,
        _ json: JSONValue
    ) {
        do {
            annotation.icon = try ScanditIcon(fromJSONString: iconJson)
            annotation.hasTip = json.bool(forKey: "hasTip", default: false)
            annotation.text = json.optionalString(forKey: "text")
            if let textColorHex = json.optionalString(forKey: "textColor"),
                let textColor = UIColor(sdcHexString: textColorHex)
            {
                annotation.textColor = textColor
            }
            if let backgroundColorHex = json.optionalString(forKey: "backgroundColor"),
                let backgroundColor = UIColor(sdcHexString: backgroundColorHex)
            {
                annotation.backgroundColor = backgroundColor
            }

            var trigger = BarcodeArAnnotationTrigger.highlightTap
            SDCBarcodeArAnnotationTriggerFromJSONString(json.string(forKey: "annotationTrigger"), &trigger)
            annotation.annotationTrigger = trigger

            if let anchorJson = json.optionalString(forKey: "anchor") {
                switch anchorJson {
                case "top": annotation.anchor = .top
                case "left": annotation.anchor = .left
                case "right": annotation.anchor = .right
                default: annotation.anchor = .bottom
                }
            }
        } catch {
            Log.error("Unable to parse the BarcodeArStatusIconAnnotation from the provided json.", error: error)
        }
    }
}
