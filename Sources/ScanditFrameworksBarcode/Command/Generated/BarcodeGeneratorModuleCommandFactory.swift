/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

// THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
// Generator: scripts/bridge_generator/generate.py
// Schema: scripts/bridge_generator/schemas/barcode.json

import Foundation
import ScanditFrameworksCore

/// Factory for creating BarcodeGeneratorModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeGeneratorModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeGeneratorModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(
        module: BarcodeGeneratorModule,
        _ method: FrameworksMethodCall
    ) -> BarcodeGeneratorModuleCommand? {
        switch method.method {
        case "createBarcodeGenerator":
            return CreateBarcodeGeneratorCommand(module: module, method)
        case "generateFromBase64EncodedData":
            return GenerateFromBase64EncodedDataCommand(module: module, method)
        case "generateFromString":
            return GenerateFromStringCommand(module: module, method)
        case "generateFromBase64EncodedDataToBytes":
            return GenerateFromBase64EncodedDataToBytesCommand(module: module, method)
        case "generateFromStringToBytes":
            return GenerateFromStringToBytesCommand(module: module, method)
        case "disposeBarcodeGenerator":
            return DisposeBarcodeGeneratorCommand(module: module, method)
        default:
            return nil
        }
    }
}
