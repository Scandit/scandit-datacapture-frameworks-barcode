/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct SparkScanDefaults {
    let viewDefaults: DefaultsSparkScanView

    public static let shared = {
        SparkScanDefaults(
            viewDefaults: DefaultsSparkScanView(viewSettings: SparkScanViewSettings())
        )
    }()

    enum Keys {
        static let sparkScanView = "SparkScanView"
    }

    /// The residual defaults that a framework plugin cannot resolve statically: the
    /// SparkScanView block (localized texts, asset handles). Every other SparkScan default
    /// ships as a generated static file.
    func toDynamicEncodable() -> [String: Any?] {
        [Keys.sparkScanView: viewDefaults.toEncodable()]
    }
}
