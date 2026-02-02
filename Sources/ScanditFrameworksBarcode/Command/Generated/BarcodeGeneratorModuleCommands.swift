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

/// Generated BarcodeGeneratorModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeGeneratorModule.

/// Creates a new barcode generator instance
public class CreateBarcodeGeneratorCommand: BarcodeGeneratorModuleCommand {
    private let module: BarcodeGeneratorModule
    private let barcodeGeneratorJson: String
    public init(module: BarcodeGeneratorModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.barcodeGeneratorJson = method.argument(key: "barcodeGeneratorJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeGeneratorJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodeGeneratorJson' is missing",
                details: nil
            )
            return
        }
        module.createBarcodeGenerator(
            barcodeGeneratorJson: barcodeGeneratorJson,
            result: result
        )
    }
}
/// Generates a barcode image from base64 encoded data
public class GenerateFromBase64EncodedDataCommand: BarcodeGeneratorModuleCommand {
    private let module: BarcodeGeneratorModule
    private let generatorId: String
    private let data: String
    private let imageWidth: Int
    public init(module: BarcodeGeneratorModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.generatorId = method.argument(key: "generatorId") ?? ""
        self.data = method.argument(key: "data") ?? ""
        self.imageWidth = method.argument(key: "imageWidth") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        guard !generatorId.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'generatorId' is missing",
                details: nil
            )
            return
        }
        guard !data.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'data' is missing", details: nil)
            return
        }
        module.generateFromBase64EncodedData(
            generatorId: generatorId,
            data: data,
            imageWidth: imageWidth,
            result: result
        )
    }
}
/// Generates a barcode image from a text string
public class GenerateFromStringCommand: BarcodeGeneratorModuleCommand {
    private let module: BarcodeGeneratorModule
    private let generatorId: String
    private let text: String
    private let imageWidth: Int
    public init(module: BarcodeGeneratorModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.generatorId = method.argument(key: "generatorId") ?? ""
        self.text = method.argument(key: "text") ?? ""
        self.imageWidth = method.argument(key: "imageWidth") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        guard !generatorId.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'generatorId' is missing",
                details: nil
            )
            return
        }
        guard !text.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'text' is missing", details: nil)
            return
        }
        module.generateFromString(
            generatorId: generatorId,
            text: text,
            imageWidth: imageWidth,
            result: result
        )
    }
}
/// Generates a barcode image from byte array data and returns raw bytes
public class GenerateFromBase64EncodedDataToBytesCommand: BarcodeGeneratorModuleCommand {
    private let module: BarcodeGeneratorModule
    private let generatorId: String
    private let data: Data
    private let imageWidth: Int
    public init(module: BarcodeGeneratorModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.generatorId = method.argument(key: "generatorId") ?? ""
        self.data = method.argument(key: "data") ?? Data()
        self.imageWidth = method.argument(key: "imageWidth") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        guard !generatorId.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'generatorId' is missing",
                details: nil
            )
            return
        }
        module.generateFromBase64EncodedDataToBytes(
            generatorId: generatorId,
            data: data,
            imageWidth: imageWidth,
            result: result
        )
    }
}
/// Generates a barcode image from a text string and returns raw bytes
public class GenerateFromStringToBytesCommand: BarcodeGeneratorModuleCommand {
    private let module: BarcodeGeneratorModule
    private let generatorId: String
    private let text: String
    private let imageWidth: Int
    public init(module: BarcodeGeneratorModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.generatorId = method.argument(key: "generatorId") ?? ""
        self.text = method.argument(key: "text") ?? ""
        self.imageWidth = method.argument(key: "imageWidth") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        guard !generatorId.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'generatorId' is missing",
                details: nil
            )
            return
        }
        guard !text.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'text' is missing", details: nil)
            return
        }
        module.generateFromStringToBytes(
            generatorId: generatorId,
            text: text,
            imageWidth: imageWidth,
            result: result
        )
    }
}
/// Disposes the barcode generator and releases resources
public class DisposeBarcodeGeneratorCommand: BarcodeGeneratorModuleCommand {
    private let module: BarcodeGeneratorModule
    private let generatorId: String
    public init(module: BarcodeGeneratorModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.generatorId = method.argument(key: "generatorId") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !generatorId.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'generatorId' is missing",
                details: nil
            )
            return
        }
        module.disposeBarcodeGenerator(
            generatorId: generatorId,
            result: result
        )
    }
}
