/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeCaptureDefaults {
    private let recommendedCameraSettings: CameraSettingsDefaults

    static let shared: BarcodeCaptureDefaults = {
        BarcodeCaptureDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodeCapture.recommendedCameraSettings
            )
        )
    }()

    enum Keys {
        static let recommendedCameraSettings = "RecommendedCameraSettings"
    }

    /// The residual defaults that a framework plugin cannot resolve statically: the
    /// device-probed recommended camera settings. Every other BarcodeCapture default ships as
    /// a generated static file.
    func toDynamicEncodable() -> [String: Any?] {
        [Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable()]
    }
}
