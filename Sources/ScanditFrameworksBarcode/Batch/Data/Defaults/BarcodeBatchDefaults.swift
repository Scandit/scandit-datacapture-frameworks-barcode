/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeBatchDefaults {
    let recommendedCameraSettings: CameraSettingsDefaults

    public static let shared: BarcodeBatchDefaults = {
        BarcodeBatchDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodeBatch.recommendedCameraSettings
            )
        )
    }()

    enum Keys {
        static let recommendedCameraSettings = "RecommendedCameraSettings"
    }

    /// The residual defaults that a framework plugin cannot resolve statically: the
    /// device-probed recommended camera settings. Every other BarcodeBatch default ships as a
    /// generated static file.
    func toDynamicEncodable() -> [String: Any?] {
        [Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable()]
    }
}
