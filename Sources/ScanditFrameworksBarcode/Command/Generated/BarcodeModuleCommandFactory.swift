/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

// THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
// Generator: scripts/bridge_generator/generate.py
// Schema: scripts/bridge_generator/schemas/barcode.json

import Foundation
import ScanditFrameworksCore

/// Factory for creating BarcodeModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: BarcodeModule, _ method: FrameworksMethodCall) -> BarcodeModuleCommand? {
        switch method.method {
        case "createFromBarcodeInfo":
            return CreateFromBarcodeInfoCommand(module: module, method)
        default:
            return nil
        }
    }
}
