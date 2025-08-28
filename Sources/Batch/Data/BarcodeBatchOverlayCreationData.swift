/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore

public struct BarcodeBatchOverlayCreationData {
    public let isBasic: Bool
    public let isAdvanced: Bool
    public let overlayJsonString: String
    public let hasListeners: Bool

    private static let advancedOverlayType = "barcodeTrackingAdvanced"
    private static let basicOverlayType = "barcodeTrackingBasic"
    private static let typeKey = "type"
    private static let hasListenerKey = "hasListener"

    public init(
        isBasic: Bool,
        isAdvanced: Bool,
        overlayJsonString: String,
        hasListeners: Bool
    ) {
        self.isBasic = isBasic
        self.isAdvanced = isAdvanced
        self.overlayJsonString = overlayJsonString
        self.hasListeners = hasListeners
    }

    public static func fromJson(_ overlayJsonString: String) -> BarcodeBatchOverlayCreationData {
        let overlayJson = JSONValue(string: overlayJsonString)

        let overlayType = overlayJson.string(forKey: typeKey, default: "")
        let hasListeners = overlayJson.bool(forKey: hasListenerKey, default: false)

        return BarcodeBatchOverlayCreationData(
            isBasic: overlayType == basicOverlayType,
            isAdvanced: overlayType == advancedOverlayType,
            overlayJsonString: overlayJsonString,
            hasListeners: hasListeners
        )
    }
}
