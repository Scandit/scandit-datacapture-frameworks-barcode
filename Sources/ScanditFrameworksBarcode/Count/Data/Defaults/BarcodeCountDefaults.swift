/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeCountDefaults {
    let recommendedCameraSettings: CameraSettingsDefaults
    let barcodeCountView: DefaultsBarcodeCountView

    static let shared = {
        BarcodeCountDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(cameraSettings: BarcodeCount.recommendedCameraSettings),
            barcodeCountView: DefaultsBarcodeCountView(
                barcodeCountToolbarSettingsDefaults: BarcodeCountToolbarSettingsDefaults(),
                barcodeCountMappingFlowSettingsDefaults: BarcodeCountMappingFlowSettingsDefaults()
            )
        )
    }()

    enum Keys {
        static let recommendedCameraSettings = "RecommendedCameraSettings"
        static let barcodeCountView = "BarcodeCountView"
    }

    /// The residual defaults that a framework plugin cannot resolve statically: the
    /// device-probed recommended camera settings and the view block (localized texts, asset
    /// handles, device-probed hardware-trigger flags). Every other BarcodeCount default ships
    /// as a generated static file.
    func toDynamicEncodable() -> [String: Any?] {
        [
            Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            Keys.barcodeCountView: barcodeCountView.toEncodable(),
        ]
    }
}
