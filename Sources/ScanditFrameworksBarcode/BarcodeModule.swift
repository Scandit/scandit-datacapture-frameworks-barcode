/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum BarcodeModuleError: Error {
    case invalidSymbology
    case invalidQuadrilateral
}

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
        BarcodeModuleCommandFactory.create(module: self, method)
    }

    func createFromBarcodeInfo(barcodeInfoJson: String, result: FrameworksResult) {
        let json = JSONValue(string: barcodeInfoJson)
        let symbologyString = json.string(forKey: "symbology")
        guard let symbology = SymbologyDescription(identifier: symbologyString)?.symbology else {
            result.reject(error: BarcodeModuleError.invalidSymbology)
            return
        }
        let data = json.string(forKey: "data")
        let locationString = json.object(forKey: "location")
        var location = Quadrilateral()
        guard SDCQuadrilateralFromJSONString(locationString.jsonString(), &location) else {
            result.reject(error: BarcodeModuleError.invalidQuadrilateral)
            return
        }
        let info = BarcodeInfo(symbology: symbology, data: data, location: location)

        let barcode = Barcode(barcodeInfo: info)

        result.success(result: barcode.jsonString)
    }

    private func resolveModuleDefaults(_ moduleName: String) -> [String: Any?] {
        guard let module = DefaultServiceLocator.shared.resolve(clazzName: moduleName) else {
            return [:]
        }
        return module.getDefaults()
    }
}
