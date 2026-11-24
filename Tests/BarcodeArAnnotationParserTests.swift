/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeArAnnotationParserTests: XCTestCase {

    private let barcode = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "1234"))

    /// Held for the lifetime of the test: `BarcodeArInfoAnnotation.delegate` is a weak property,
    /// and the parser is what owns the per-slot delegates. A parser that goes out of scope takes
    /// every child annotation's delegate with it.
    private var parser: BarcodeArAnnotationParser!

    override func setUp() {
        super.setUp()
        parser = BarcodeArAnnotationParser(viewId: 1, emitter: NoopEmitter())
    }

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - annotationsByThreshold parsing

    func testResponsiveAnnotationWithNThresholds() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.3": \(infoAnnotationJson(headerText: "far")),
                    "0.6": \(infoAnnotationJson(headerText: "mid")),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.3, 0.6, 1.0])
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far")
        XCTAssertEqual(try slot(annotation, 0.6).header?.text, "mid")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")

        // the lowest threshold is the far-away slot, 1.0 the close-up one, in-between slots carry
        // no type - but every slot reports its own threshold
        XCTAssertEqual(try delegate(annotation, 0.3).responsiveAnnotationType, .farAway)
        XCTAssertNil(try delegate(annotation, 0.6).responsiveAnnotationType)
        XCTAssertEqual(try delegate(annotation, 1.0).responsiveAnnotationType, .closeUp)
        XCTAssertEqual(try delegate(annotation, 0.3).responsiveAnnotationThreshold, 0.3)
        XCTAssertEqual(try delegate(annotation, 0.6).responsiveAnnotationThreshold, 0.6)
        XCTAssertEqual(try delegate(annotation, 1.0).responsiveAnnotationThreshold, 1.0)

        // each slot gets its own delegate instance, so an emit can be attributed to one slot
        let farAwayDelegate = try delegate(annotation, 0.3)
        let midDelegate = try delegate(annotation, 0.6)
        XCTAssertFalse(farAwayDelegate === midDelegate)
    }

    func testResponsiveAnnotationKeepsNullSlots() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.5": null,
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        // the threshold slot still exists, with no annotation in it
        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.5, 1.0])
        XCTAssertNil(annotation.annotationsByThreshold[0.5] ?? nil)
        XCTAssertNotNil(annotation.annotationsByThreshold[1.0] ?? nil)
    }

    func testResponsiveAnnotationSkipsInvalidThresholdKey() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "not-a-number": \(infoAnnotationJson(headerText: "bogus")),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        // the unparseable key is dropped, the good one survives
        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [1.0])
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")
    }

    func testResponsiveAnnotationFallsBackToLegacyJson() throws {
        // the pre-N-state JSON shape, with no annotationsByThreshold key
        let json = """
            {
                "type": "barcodeArResponsiveAnnotation",
                "annotationTrigger": "highlightTap",
                "threshold": 0.4,
                "closeUpAnnotation": \(infoAnnotationJson(headerText: "close")),
                "farAwayAnnotation": \(infoAnnotationJson(headerText: "far"))
            }
            """

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        // it maps onto two slots: the threshold one (far away) and 1.0 (close up)
        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.4, 1.0])
        XCTAssertEqual(try slot(annotation, 0.4).header?.text, "far")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")
        XCTAssertEqual(try delegate(annotation, 0.4).responsiveAnnotationType, .farAway)
        XCTAssertEqual(try delegate(annotation, 1.0).responsiveAnnotationType, .closeUp)
    }

    // MARK: - popover isEntirePopoverTappable (SDC-33083)

    func testGetPopoverAnnotationAppliesIsEntirePopoverTappableTrue() throws {
        let annotation = try XCTUnwrap(
            parse(popoverAnnotationJson(isEntirePopoverTappable: true)) as? BarcodeArPopoverAnnotation
        )

        XCTAssertTrue(annotation.isEntirePopoverTappable)
    }

    func testGetPopoverAnnotationAppliesIsEntirePopoverTappableFalse() throws {
        let annotation = try XCTUnwrap(
            parse(popoverAnnotationJson(isEntirePopoverTappable: false)) as? BarcodeArPopoverAnnotation
        )

        XCTAssertFalse(annotation.isEntirePopoverTappable)
    }

    func testUpdatePopoverAnnotationAppliesIsEntirePopoverTappableTrue() throws {
        let annotation = try XCTUnwrap(
            parse(popoverAnnotationJson(isEntirePopoverTappable: false)) as? BarcodeArPopoverAnnotation
        )
        XCTAssertFalse(annotation.isEntirePopoverTappable)

        update(annotation, popoverAnnotationJson(isEntirePopoverTappable: true))

        XCTAssertTrue(annotation.isEntirePopoverTappable)
    }

    func testUpdatePopoverAnnotationAppliesIsEntirePopoverTappableFalse() throws {
        let annotation = try XCTUnwrap(
            parse(popoverAnnotationJson(isEntirePopoverTappable: true)) as? BarcodeArPopoverAnnotation
        )
        XCTAssertTrue(annotation.isEntirePopoverTappable)

        update(annotation, popoverAnnotationJson(isEntirePopoverTappable: false))

        XCTAssertFalse(annotation.isEntirePopoverTappable)
    }

    // MARK: - updates

    func testUpdateResponsiveAnnotationUpdatesMatchingThresholds() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.3": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // each slot's own annotation is updated, no cross-talk
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far updated")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close updated")
    }

    func testUpdateResponsiveAnnotationPairsByOrderWhenThresholdsChanged() throws {
        // an annotation built with thresholds that the update no longer uses - this is what the
        // deprecated `threshold` setter does, since the native thresholds are fixed at
        // construction time
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.7": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // the slots are paired by ascending threshold order, so the configuration still reaches
        // the right annotation instead of being dropped
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far updated")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close updated")
    }

    func testUpdateResponsiveAnnotationIgnoresExtraSlots() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        // three non-matching slots against a two-slot annotation
        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.4": \(infoAnnotationJson(headerText: "far updated")),
                        "0.6": \(infoAnnotationJson(headerText: "mid updated")),
                        "0.8": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // the slots that pair up are updated, the extra one is dropped rather than crashing or
        // overwriting an unrelated slot
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far updated")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "mid updated")
    }

    func testUpdateResponsiveAnnotationReusesDelegatePerSlot() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )
        let delegateBeforeUpdate = try delegate(annotation, 0.3)

        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.3": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // the cached delegate is refreshed in place, so a delegate already set on a still-live
        // child annotation keeps working
        let delegateAfterUpdate = try delegate(annotation, 0.3)
        XCTAssertTrue(delegateAfterUpdate === delegateBeforeUpdate)
    }

    func testUpdateResponsiveAnnotationAttachesTheRemappedDelegate() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        // the deprecated threshold setter makes Dart resend the slot under a new key
        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.7": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // The remapped slot must end up with the delegate carrying the NEW threshold. Keeping the
        // stale delegate would emit taps under 0.3, which the framework no longer has a key for,
        // and the tap would be dropped.
        XCTAssertEqual(try delegate(annotation, 0.3).responsiveAnnotationThreshold, 0.7)
    }

    func testResponsiveAnnotationParsesTheAnnotationTrigger() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """,
                    annotationTrigger: "barcodeScan"
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        XCTAssertEqual(annotation.annotationTrigger, .barcodeScan)
    }

    func testUpdateResponsiveAnnotationUpdatesTheAnnotationTrigger() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.3": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """,
                annotationTrigger: "barcodeScan"
            )
        )

        XCTAssertEqual(annotation.annotationTrigger, .barcodeScan)
    }

    // MARK: - popover and status children

    func testResponsiveAnnotationBuildsPopoverAndStatusChildren() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.3": \(popoverAnnotationJson(isEntirePopoverTappable: true)),
                    "0.6": \(statusIconAnnotationJson(text: "status")),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.3, 0.6, 1.0])
        XCTAssertTrue(try popoverSlot(annotation, 0.3).isEntirePopoverTappable)
        XCTAssertEqual(try statusSlot(annotation, 0.6).text, "status")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")
    }

    func testResponsivePopoverChildDelegateCarriesItsExactThreshold() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.3": \(popoverAnnotationJson(hasListener: true)),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        let delegate = try popoverDelegate(annotation, 0.3)
        XCTAssertEqual(delegate.responsiveAnnotationThreshold, 0.3)
        XCTAssertEqual(delegate.responsiveAnnotationType, .farAway)
    }

    func testUpdateResponsiveAnnotationUpdatesPopoverAndStatusChildren() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(popoverAnnotationJson(isEntirePopoverTappable: false)),
                            "1.0": \(statusIconAnnotationJson(text: "status"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )
        XCTAssertNil(try popoverSlot(annotation, 0.3).delegate)

        // the deprecated threshold setter makes Dart resend the popover slot under a new key
        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.7": \(popoverAnnotationJson(isEntirePopoverTappable: true, hasListener: true)),
                        "1.0": \(statusIconAnnotationJson(text: "status updated"))
                    }
                    """
            )
        )

        XCTAssertTrue(try popoverSlot(annotation, 0.3).isEntirePopoverTappable)
        XCTAssertEqual(try popoverDelegate(annotation, 0.3).responsiveAnnotationThreshold, 0.7)
        XCTAssertEqual(try statusSlot(annotation, 1.0).text, "status updated")
    }

    func testResponsiveAnnotationSkipsNestedResponsiveChild() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.3": \(responsiveAnnotationJson(annotationsByThreshold: "{}")),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.3, 1.0])
        XCTAssertNil(annotation.annotationsByThreshold[0.3] ?? nil)
    }

    func testUpdatePopoverButtonOfResponsiveChildByThreshold() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(popoverAnnotationJson()),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )
        let buttonJson = JSONValue(
            string: """
                {"index": 0, "textColor": "#FF0000", "textSize": 20.0, "fontFamily": "modernMono", "enabled": false}
                """
        )

        parser.updateBarcodeArPopoverButton(annotation, json: buttonJson, responsiveAnnotationThreshold: 0.3)

        XCTAssertFalse(try popoverSlot(annotation, 0.3).buttons[0].isEnabled)
    }

    func testResponsiveAnnotationBuildsCustomChildPerSlot() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.3": \(customAnnotationJson(trigger: "barcodeScan")),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.3, 1.0])
        XCTAssertEqual(try customSlot(annotation, 0.3).annotationTrigger, .barcodeScan)
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")
    }

    func testUpdateResponsiveAnnotationUpdatesCustomChildTrigger() throws {
        func thresholds(_ trigger: String) -> String {
            """
            {
                "0.3": \(customAnnotationJson(trigger: trigger)),
                "1.0": \(infoAnnotationJson(headerText: "close"))
            }
            """
        }
        let annotation = try XCTUnwrap(
            parse(responsiveAnnotationJson(annotationsByThreshold: thresholds("highlightTap")))
                as? BarcodeArResponsiveAnnotation
        )

        update(annotation, responsiveAnnotationJson(annotationsByThreshold: thresholds("barcodeScan")))

        XCTAssertEqual(try customSlot(annotation, 0.3).annotationTrigger, .barcodeScan)
    }

    func testUpdateResponsiveAnnotationWithUnbuildableChildKeepsSlotsAligned() throws {
        // a status icon without an icon cannot be built
        let brokenStatusJson = #"{"type": "barcodeArStatusIconAnnotation", "annotationTrigger": "highlightTap"}"#
        func thresholds(_ mid: String, _ close: String) -> String {
            """
            {
                "0.3": \(brokenStatusJson),
                "0.6": \(infoAnnotationJson(headerText: mid)),
                "1.0": \(infoAnnotationJson(headerText: close))
            }
            """
        }
        let annotation = try XCTUnwrap(
            parse(responsiveAnnotationJson(annotationsByThreshold: thresholds("mid", "close")))
                as? BarcodeArResponsiveAnnotation
        )

        update(annotation, responsiveAnnotationJson(annotationsByThreshold: thresholds("mid2", "close2")))

        // each configuration reaches its own slot; nothing is remapped onto a sibling
        XCTAssertNil(annotation.annotationsByThreshold[0.3] ?? nil)
        XCTAssertEqual(try slot(annotation, 0.6).header?.text, "mid2")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close2")
        XCTAssertEqual(try delegate(annotation, 1.0).responsiveAnnotationThreshold, 1.0)
    }

    func testUpdateResponsiveChildRejectsTypeChange() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.5": \(infoAnnotationJson(headerText: "original")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )
        let infoBefore = try slot(annotation, 0.5)

        // the same slot is updated with a popover payload
        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.5": \(popoverAnnotationJson()),
                        "1.0": \(infoAnnotationJson(headerText: "close"))
                    }
                    """
            )
        )

        // the slot is still the untouched info annotation
        let infoAfter = try slot(annotation, 0.5)
        XCTAssertTrue(infoAfter === infoBefore)
        XCTAssertEqual(infoAfter.header?.text, "original")
    }

    func testUpdatePopoverButtonIgnoresNonPopoverTarget() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.5": \(infoAnnotationJson(headerText: "original")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )
        let buttonJson = JSONValue(
            string: """
                {"index": 0, "textColor": "#FF0000", "textSize": 20.0, "fontFamily": "modernMono", "enabled": false}
                """
        )

        // the target slot is an info annotation, then an unknown threshold: neither may crash
        parser.updateBarcodeArPopoverButton(annotation, json: buttonJson, responsiveAnnotationThreshold: 0.5)
        parser.updateBarcodeArPopoverButton(annotation, json: buttonJson, responsiveAnnotationThreshold: 0.9)

        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.5, 1.0])
        XCTAssertEqual(try slot(annotation, 0.5).header?.text, "original")
    }

    // MARK: - helpers

    private func parse(_ json: String) -> BarcodeArAnnotation? {
        parser.get(json: JSONValue(string: json), barcode: barcode, emitter: NoopEmitter())
    }

    private func update(_ annotation: BarcodeArAnnotation, _ json: String) {
        parser.updateAnnotation(annotation, json: JSONValue(string: json))
    }

    private func slot(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> BarcodeArInfoAnnotation {
        try XCTUnwrap((annotation.annotationsByThreshold[threshold] ?? nil) as Any? as? BarcodeArInfoAnnotation)
    }

    private func customSlot(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> BarcodeArCustomAnnotation {
        try XCTUnwrap((annotation.annotationsByThreshold[threshold] ?? nil) as Any? as? BarcodeArCustomAnnotation)
    }

    private func customAnnotationJson(trigger: String) -> String {
        #"{"type": "barcodeArCustomAnnotation", "annotationTrigger": "\#(trigger)"}"#
    }

    private func delegate(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> FrameworksInfoAnnotationDelegate {
        try XCTUnwrap(slot(annotation, threshold).delegate as? FrameworksInfoAnnotationDelegate)
    }

    private func responsiveAnnotationJson(
        annotationsByThreshold: String,
        annotationTrigger: String = "highlightTap"
    ) -> String {
        """
        {
            "type": "barcodeArResponsiveAnnotation",
            "annotationTrigger": "\(annotationTrigger)",
            "annotationsByThreshold": \(annotationsByThreshold)
        }
        """
    }

    private func statusIconAnnotationJson(text: String) -> String {
        """
        {
            "type": "barcodeArStatusIconAnnotation",
            "annotationTrigger": "highlightTap",
            "hasTip": true,
            "text": "\(text)",
            "icon": {
                "icon": "checkmark",
                "iconColor": "#FF0000",
                "backgroundColor": "#FFFFFF",
                "backgroundStrokeColor": "#000000",
                "backgroundStrokeWidth": 2.0,
                "backgroundShape": "circle"
            }
        }
        """
    }

    private func popoverSlot(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> BarcodeArPopoverAnnotation {
        try XCTUnwrap((annotation.annotationsByThreshold[threshold] ?? nil) as Any? as? BarcodeArPopoverAnnotation)
    }

    private func statusSlot(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> BarcodeArStatusIconAnnotation {
        try XCTUnwrap((annotation.annotationsByThreshold[threshold] ?? nil) as Any? as? BarcodeArStatusIconAnnotation)
    }

    private func popoverDelegate(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> FrameworksPopoverAnnotationDelegate {
        try XCTUnwrap(popoverSlot(annotation, threshold).delegate as? FrameworksPopoverAnnotationDelegate)
    }

    private func popoverAnnotationJson(
        isEntirePopoverTappable: Bool = false,
        hasListener: Bool = false
    ) -> String {
        """
        {
            "type": "barcodeArPopoverAnnotation",
            "annotationTrigger": "highlightTap",
            "isEntirePopoverTappable": \(isEntirePopoverTappable),
            "hasListener": \(hasListener),
            "buttons": [
                {
                    "text": "Button 1",
                    "icon": {
                        "backgroundStrokeWidth": 3.0
                    }
                }
            ]
        }
        """
    }

    private func infoAnnotationJson(headerText: String) -> String {
        """
        {
            "anchor": "bottom",
            "width": "medium",
            "annotationTrigger": "highlightTapAndBarcodeScan",
            "hasListener": true,
            "body": [],
            "header": {
                "text": "\(headerText)",
                "fontFamily": "modernMono",
                "textSize": 14.0
            }
        }
        """
    }
}

private class NoopEmitter: Emitter {
    func emit(name: String, payload: [String: Any?]) {}
    func hasListener(for event: String) -> Bool { false }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { false }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { false }
}
