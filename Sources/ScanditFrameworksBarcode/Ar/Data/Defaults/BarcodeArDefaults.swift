/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeArDefaults {
    let recommendedCameraSettings: CameraSettingsDefaults
    let viewDefaults: DefaultsBarcodeArView

    static let shared = {
        BarcodeArDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(cameraSettings: BarcodeAr.recommendedCameraSettings),
            viewDefaults: DefaultsBarcodeArView()
        )
    }()

    enum Keys {
        static let recommendedCameraSettings = "RecommendedCameraSettings"
        static let barcodeArView = "BarcodeArView"
    }

    /// The residual defaults that a framework plugin cannot resolve statically: the
    /// device-probed recommended camera settings and the view block (localized texts, asset
    /// handles). Every other BarcodeAr default ships as a generated static file.
    func toDynamicEncodable() -> [String: Any?] {
        [
            Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            Keys.barcodeArView: viewDefaults.toEncodable(),
        ]
    }
}
