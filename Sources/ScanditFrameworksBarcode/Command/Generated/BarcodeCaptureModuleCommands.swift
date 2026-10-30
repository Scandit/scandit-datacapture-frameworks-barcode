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

/// Generated BarcodeCaptureModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeCaptureModule.

/// Resets the barcode capture session
public class ResetBarcodeCaptureSessionCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    public init(module: BarcodeCaptureModule) {
        self.module = module
    }

    public func execute(result: FrameworksResult) {
        module.resetBarcodeCaptureSession(
            result: result
        )
    }
}
/// Register persistent event listener for barcode capture events
public class RegisterBarcodeCaptureListenerForEventsCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeId: Int
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerModeSpecificCallback(
            modeId,
            eventNames: [
                "BarcodeCaptureListener.didUpdateSession",
                "BarcodeCaptureListener.didScan",
            ]
        )
        module.registerBarcodeCaptureListenerForEvents(
            modeId: modeId,
            result: result
        )
    }
}
/// Unregister event listener for barcode capture events
public class UnregisterBarcodeCaptureListenerForEventsCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeId: Int
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterModeSpecificCallback(
            modeId,
            eventNames: [
                "BarcodeCaptureListener.didUpdateSession",
                "BarcodeCaptureListener.didScan",
            ]
        )
        module.unregisterBarcodeCaptureListenerForEvents(
            modeId: modeId,
            result: result
        )
    }
}
/// Finish callback for barcode capture did update session event
public class FinishBarcodeCaptureDidUpdateSessionCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeCaptureDidUpdateSession(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Finish callback for barcode capture did scan event
public class FinishBarcodeCaptureDidScanCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeCaptureDidScan(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Sets the enabled state of the barcode capture mode
public class SetBarcodeCaptureModeEnabledStateCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.setBarcodeCaptureModeEnabledState(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Updates the barcode capture mode configuration
public class UpdateBarcodeCaptureModeCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeJson: String
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeJson = method.argument(key: "modeJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !modeJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'modeJson' is missing", details: nil)
            return
        }
        module.updateBarcodeCaptureMode(
            modeJson: modeJson,
            result: result
        )
    }
}
/// Applies new settings to the barcode capture mode
public class ApplyBarcodeCaptureModeSettingsCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeId: Int
    private let modeSettingsJson: String
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.modeSettingsJson = method.argument(key: "modeSettingsJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !modeSettingsJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'modeSettingsJson' is missing",
                details: nil
            )
            return
        }
        module.applyBarcodeCaptureModeSettings(
            modeId: modeId,
            modeSettingsJson: modeSettingsJson,
            result: result
        )
    }
}
/// Updates the barcode capture overlay configuration
public class UpdateBarcodeCaptureOverlayCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let viewId: Int
    private let overlayJson: String
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.overlayJson = method.argument(key: "overlayJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !overlayJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'overlayJson' is missing",
                details: nil
            )
            return
        }
        module.updateBarcodeCaptureOverlay(
            viewId: viewId,
            overlayJson: overlayJson,
            result: result
        )
    }
}
/// Updates the barcode capture feedback configuration
public class UpdateBarcodeCaptureFeedbackCommand: BarcodeCaptureModuleCommand {
    private let module: BarcodeCaptureModule
    private let modeId: Int
    private let feedbackJson: String
    public init(module: BarcodeCaptureModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.feedbackJson = method.argument(key: "feedbackJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !feedbackJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'feedbackJson' is missing",
                details: nil
            )
            return
        }
        module.updateBarcodeCaptureFeedback(
            modeId: modeId,
            feedbackJson: feedbackJson,
            result: result
        )
    }
}
