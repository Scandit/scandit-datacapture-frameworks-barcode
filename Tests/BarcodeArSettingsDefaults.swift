/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeArSettingsDefaults: DefaultsEncodable {
    let barcodeArSettings: BarcodeArSettings

    func toEncodable() -> [String: Any?] {
        [
            "expectOnlyUniqueBarcodes": barcodeArSettings.expectsOnlyUniqueBarcodes
        ]
    }
}
