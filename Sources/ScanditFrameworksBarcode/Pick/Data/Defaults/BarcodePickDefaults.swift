/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodePickDefaults {
    private let recommendedCameraSettings: CameraSettingsDefaults
    private let viewSettingsDefaults: FrameworksBarcodePickViewDefaults
    private let barcodePickViewHighlightStyleDefaults: BarcodePickViewHighlightStyleDefaults
    private let barcodePickSymbologySettingsDefaults: BarcodePickSymbologySettingsDefaults

    enum Keys {
        static let recommendedCameraSettings = "RecommendedCameraSettings"
        static let viewSettings = "ViewSettings"
        static let barcodePickViewHighlightStyle = "BarcodePickViewHighlightStyle"
        static let symbologySettings = "SymbologySettings"
    }

    /// The residual defaults that a framework plugin cannot resolve statically: the
    /// device-probed recommended camera settings, the engine-owned symbology settings, and the
    /// view blocks (highlight style, localized texts, asset handles). Every other BarcodePick
    /// default ships as a generated static file.
    func toDynamicEncodable() -> [String: Any?] {
        [
            Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            Keys.symbologySettings: barcodePickSymbologySettingsDefaults.toEncodable(),
            Keys.barcodePickViewHighlightStyle: barcodePickViewHighlightStyleDefaults.toEncodable(),
            Keys.viewSettings: viewSettingsDefaults.toEncodable(),
        ]
    }

    static let shared: BarcodePickDefaults = {
        BarcodePickDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodePick.recommendedCameraSettings
            ),
            viewSettingsDefaults: FrameworksBarcodePickViewDefaults(),
            barcodePickViewHighlightStyleDefaults: .shared,
            barcodePickSymbologySettingsDefaults: .shared
        )
    }()
}
