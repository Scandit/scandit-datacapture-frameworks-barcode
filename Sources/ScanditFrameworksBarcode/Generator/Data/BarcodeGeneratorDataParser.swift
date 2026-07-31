/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture

struct BarcodeGeneratorDataParser {
    let id: String
    let type: String
    let backgroundColor: UIColor?
    let foregroundColor: UIColor?
    let errorCorrectionLevel: QRCodeErrorCorrectionLevel?
    let versionNumber: Int?
    let minimumErrorCorrectionPercent: Int?
    let layers: Int?
    let pdf417ErrorCorrectionLevel: Int?
    let compact: Bool?
    let compactionMode: PDF417CompactionMode?
    let dimensions: PDF417Dimensions?

    init(jsonString: String) {
        let jsonValue = JSONValue(string: jsonString)

        self.id = jsonValue.string(forKey: "id")
        self.type = jsonValue.string(forKey: "type")

        let backgroundColorHex = jsonValue.optionalString(forKey: "backgroundColor")
        self.backgroundColor = backgroundColorHex.flatMap { hexString in
            UIColor(sdcHexString: hexString)
        }
        let foregroundColorHex = jsonValue.optionalString(forKey: "foregroundColor")
        self.foregroundColor = foregroundColorHex.flatMap { hexString in
            UIColor(sdcHexString: hexString)
        }

        let errorCorrectionLevel: QRCodeErrorCorrectionLevel?

        if let levelString = jsonValue.optionalString(forKey: "errorCorrectionLevel") {
            switch levelString {
            case "low":
                errorCorrectionLevel = .low
            case "medium":
                errorCorrectionLevel = .medium
            case "quartile":
                errorCorrectionLevel = .quartile
            case "high":
                errorCorrectionLevel = .high
            default:
                errorCorrectionLevel = nil
            }
        } else {
            errorCorrectionLevel = nil
        }
        self.errorCorrectionLevel = errorCorrectionLevel
        self.versionNumber = jsonValue.optionalInt(forKey: "versionNumber")
        self.minimumErrorCorrectionPercent = jsonValue.optionalInt(forKey: "minimumErrorCorrectionPercent")
        self.layers = jsonValue.optionalInt(forKey: "layers")

        // PDF417 error correction is an integer (0–8); only parse when type is pdf417Generator
        // to avoid throwing when QR sends the same key as a string.
        if self.type == "pdf417Generator" && jsonValue.containsKey("errorCorrectionLevel") {
            self.pdf417ErrorCorrectionLevel = jsonValue.integer(forKey: "errorCorrectionLevel")
        } else {
            self.pdf417ErrorCorrectionLevel = nil
        }

        self.compact =
            jsonValue.containsKey("compact")
            ? jsonValue.bool(forKey: "compact")
            : nil

        if let modeString = jsonValue.optionalString(forKey: "compactionMode") {
            switch modeString {
            case "auto":
                self.compactionMode = .auto
            case "text":
                self.compactionMode = .text
            case "byte":
                self.compactionMode = .byte
            case "numeric":
                self.compactionMode = .numeric
            default:
                self.compactionMode = nil
            }
        } else {
            self.compactionMode = nil
        }

        if jsonValue.containsObject(withKey: "dimensions") {
            let dimValue = jsonValue.object(forKey: "dimensions")
            let dims = PDF417Dimensions()
            if dimValue.containsKey("minCols") {
                dims.minCols = NSNumber(value: dimValue.integer(forKey: "minCols"))
            }
            if dimValue.containsKey("maxCols") {
                dims.maxCols = NSNumber(value: dimValue.integer(forKey: "maxCols"))
            }
            if dimValue.containsKey("minRows") {
                dims.minRows = NSNumber(value: dimValue.integer(forKey: "minRows"))
            }
            if dimValue.containsKey("maxRows") {
                dims.maxRows = NSNumber(value: dimValue.integer(forKey: "maxRows"))
            }
            self.dimensions = dims
        } else {
            self.dimensions = nil
        }
    }
}
