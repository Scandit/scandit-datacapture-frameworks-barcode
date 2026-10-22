/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeSelectionDefaults {
    let recommendedCameraSettings: CameraSettingsDefaults

    public static let shared: BarcodeSelectionDefaults = {
        BarcodeSelectionDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodeSelection.recommendedCameraSettings
            )
        )
    }()

    enum Keys {
        static let recommendedCameraSettings = "RecommendedCameraSettings"
    }

    /// The residual defaults that a framework plugin cannot resolve statically: the
    /// device-probed recommended camera settings. Every other BarcodeSelection default ships
    /// as a generated static file.
    func toDynamicEncodable() -> [String: Any?] {
        [Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable()]
    }
}
