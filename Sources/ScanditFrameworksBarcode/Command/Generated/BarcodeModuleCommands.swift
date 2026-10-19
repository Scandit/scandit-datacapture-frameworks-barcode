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

/// Generated BarcodeModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeModule.

/// Creates a Barcode instance from BarcodeInfo
public class CreateFromBarcodeInfoCommand: BarcodeModuleCommand {
    private let module: BarcodeModule
    private let barcodeInfoJson: String
    public init(module: BarcodeModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.barcodeInfoJson = method.argument(key: "barcodeInfoJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeInfoJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodeInfoJson' is missing",
                details: nil
            )
            return
        }
        module.createFromBarcodeInfo(
            barcodeInfoJson: barcodeInfoJson,
            result: result
        )
    }
}
