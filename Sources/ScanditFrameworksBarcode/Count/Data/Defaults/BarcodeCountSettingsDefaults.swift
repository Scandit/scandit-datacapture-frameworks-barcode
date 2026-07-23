/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeCountSettingsDefaults: DefaultsEncodable {
    let barcodeCountSettings: BarcodeCountSettings

    func toEncodable() -> [String: Any?] {
        [
            "barcodeFilterSettings": BarcodeFilterSettingsDefaults(
                barcodeFilterSettings: barcodeCountSettings.filterSettings
            ).toEncodable(),
            "expectOnlyUniqueBarcodes": barcodeCountSettings.expectsOnlyUniqueBarcodes,
            "mappingEnabled": barcodeCountSettings.mappingEnabled,
            "disableModeWhenCaptureListCompleted": barcodeCountSettings.disableModeWhenCaptureListCompleted,
            "clusteringMode": barcodeCountSettings.clusteringMode.toJSON(),
            "scanPreviewEnabled": barcodeCountSettings.scanPreviewEnabled,
        ]
    }
}

private extension ClusteringMode {
    func toJSON() -> String {
        switch self {
        case .disabled:
            return "disabled"
        case .manual:
            return "manual"
        case .auto:
            return "auto"
        case .autoWithManualCorrection:
            return "autoWithManualCorrection"
        @unknown default:
            return "disabled"
        }
    }
}
