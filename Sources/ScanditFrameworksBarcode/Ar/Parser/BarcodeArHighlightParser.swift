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

public class BarcodeArHighlightParser {
    var emitter: Emitter

    init(emitter: Emitter) {
        self.emitter = emitter
    }

    func get(json: JSONValue, barcode: Barcode, viewId: Int) -> (UIView & BarcodeArHighlight)? {
        guard let type = json.optionalString(forKey: "type") else {
            Log.error("Invalid JSON type.")
            return nil
        }

        switch type {
        case "barcodeArCircleHighlight":
            return getBarcodeArCircleHighlight(barcode: barcode, json: json)
        case "barcodeArRectangleHighlight":
            return getBarcodeArRectangleHighlight(barcode: barcode, json: json)
        case "barcodeArCustomHighlight":
            return BarcodeArCustomHighlight(barcode: barcode, emitter: emitter, viewId: viewId)
        default:
            Log.error("Not supported highlight type.", error: NSError(domain: "Type \(type)", code: -1))
            return nil
        }
    }

    func updateHighlight(_ highlight: BarcodeArHighlight, json: JSONValue) {
        switch highlight {
        case let circleHighlight as BarcodeArCircleHighlight:
            updateCircleHighlight(circleHighlight, json: json)
        case let rectangleHighlight as BarcodeArRectangleHighlight:
            updateRectangleHighlight(rectangleHighlight, json: json)
        default:
            break
        }
    }

    private func getBarcodeArCircleHighlight(barcode: Barcode, json: JSONValue) -> BarcodeArCircleHighlight? {
        guard let presetString = json.optionalString(forKey: "preset") else {
            Log.error("Invalid data for BarcodeArCircleHighlight.")
            return nil
        }

        var preset = BarcodeArCircleHighlightPreset.dot
        SDCBarcodeArCircleHighlightPresetFromJSONString(presetString, &preset)

        let highlight = BarcodeArCircleHighlight(barcode: barcode, preset: preset)
        updateCircleHighlight(highlight, json: json)
        return highlight
    }

    private func getBarcodeArRectangleHighlight(
        barcode: Barcode,
        json: JSONValue
    ) -> BarcodeArRectangleHighlight? {

        let highlight = BarcodeArRectangleHighlight(barcode: barcode)
        updateRectangleHighlight(highlight, json: json)
        return highlight
    }

    private func updateCircleHighlight(_ highlight: BarcodeArCircleHighlight, json: JSONValue) {
        applyIcon(from: json) { highlight.icon = $0 }
        highlight.size = json.cgFloat(forKey: "size", default: highlight.size)
        applyBrush(from: json) { highlight.brush = $0 }
        highlight.isPulsing = json.bool(forKey: "isPulsing", default: highlight.isPulsing)
    }

    private func updateRectangleHighlight(_ highlight: BarcodeArRectangleHighlight, json: JSONValue) {
        applyIcon(from: json) { highlight.icon = $0 }
        applyBrush(from: json) { highlight.brush = $0 }
    }

    private func applyIcon(from json: JSONValue, to assign: (ScanditIcon?) -> Void) {
        guard json.containsKey("icon"), !json.containsArray(withKey: "icon") else {
            assign(nil)
            return
        }

        do {
            assign(try ScanditIcon(fromJSONString: json.getObjectAsString(forKey: "icon")))
        } catch {
            assign(nil)
            Log.error("Unable to parse the highlight icon from the provided json.", error: error)
        }
    }

    private func applyBrush(from json: JSONValue, to assign: (Brush) -> Void) {
        guard json.containsKey("brush") else { return }

        if let brush = Brush(jsonString: json.getObjectAsString(forKey: "brush")) {
            assign(brush)
        }
    }
}
