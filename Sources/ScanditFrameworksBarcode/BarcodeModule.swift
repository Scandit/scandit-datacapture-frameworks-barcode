/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditFrameworksCore

open class BarcodeModule: NSObject, FrameworkModule {
    public func didStart() {}

    public func didStop() {}

    public func getDefaults() -> [String: Any?] {
        [
            "Barcode": BarcodeDefaults.shared.toEncodable(),
            "BarcodeCapture": resolveModuleDefaults(String(describing: BarcodeCaptureModule.self)),
            "BarcodeBatch": resolveModuleDefaults(String(describing: BarcodeBatchModule.self)),
            "BarcodeSelection": resolveModuleDefaults(String(describing: BarcodeSelectionModule.self)),
            "BarcodeCount": resolveModuleDefaults(String(describing: BarcodeCountModule.self)),
            "BarcodeFind": resolveModuleDefaults(String(describing: BarcodeFindModule.self)),
            "BarcodePick": resolveModuleDefaults(String(describing: BarcodePickModule.self)),
            "SparkScan": resolveModuleDefaults(String(describing: SparkScanModule.self)),
            "BarcodeAr": resolveModuleDefaults(String(describing: BarcodeArModule.self)),
        ]
    }

    public func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        nil
    }

    private func resolveModuleDefaults(_ moduleName: String) -> [String: Any?] {
        guard let module = DefaultServiceLocator.shared.resolve(clazzName: moduleName) else {
            return [:]
        }
        return module.getDefaults()
    }
}
