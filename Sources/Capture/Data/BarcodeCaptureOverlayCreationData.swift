/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore

public struct BarcodeCaptureOverlayCreationData {
    public let isBasic: Bool
    public let overlayJsonString: String

    private static let basicOverlayType = "barcodeCapture"
    private static let typeKey = "type"

    public init(
        isBasic: Bool,
        overlayJsonString: String
    ) {
        self.isBasic = isBasic
        self.overlayJsonString = overlayJsonString
    }

    public static func fromJson(_ overlayJsonString: String) -> BarcodeCaptureOverlayCreationData {
        let overlayJson = JSONValue(string: overlayJsonString)
        let overlayType = overlayJson.string(forKey: typeKey, default: "")
        return BarcodeCaptureOverlayCreationData(
            isBasic: overlayType == basicOverlayType,
            overlayJsonString: overlayJsonString
        )
    }
}
