/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture
import ScanditCaptureCoreDeserializer
import ScanditFrameworksCore

public enum BarcodeModuleError: Error {
    case invalidSymbology
    case invalidQuadrilateral
}

open class BarcodeModule: NSObject, FrameworkModule {
    public func didStart() {}

    public func didStop() {}

    /// Only the defaults that cannot be resolved statically by a framework plugin: the
    /// engine-owned symbology/composite-type descriptions and per-symbology settings, every mode's
    /// recommended camera settings, and the view blocks that carry localized texts, asset handles
    /// or device-probed hardware-trigger flags.
    ///
    /// Values come from the same per-mode producers, just narrowed.
    public func getDynamicDefaults() -> [String: Any?] {
        [
            // Every key of the Barcode block is engine-owned, so it is kept whole.
            "Barcode": BarcodeDefaults.shared.toEncodable(),
            "BarcodeCapture": BarcodeCaptureDefaults.shared.toDynamicEncodable(),
            "BarcodeBatch": BarcodeBatchDefaults.shared.toDynamicEncodable(),
            "BarcodeSelection": BarcodeSelectionDefaults.shared.toDynamicEncodable(),
            "BarcodeCount": BarcodeCountDefaults.shared.toDynamicEncodable(),
            "BarcodeFind": BarcodeFindDefaults.shared.toDynamicEncodable(),
            "BarcodePick": BarcodePickDefaults.shared.toDynamicEncodable(),
            "SparkScan": SparkScanDefaults.shared.toDynamicEncodable(),
            "BarcodeAr": BarcodeArDefaults.shared.toDynamicEncodable(),
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
}
