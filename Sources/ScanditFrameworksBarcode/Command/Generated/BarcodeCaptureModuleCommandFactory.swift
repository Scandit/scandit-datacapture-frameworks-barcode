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

/// Factory for creating BarcodeCaptureModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeCaptureModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeCaptureModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(
        module: BarcodeCaptureModule,
        _ method: FrameworksMethodCall
    ) -> BarcodeCaptureModuleCommand? {
        switch method.method {
        case "resetBarcodeCaptureSession":
            return ResetBarcodeCaptureSessionCommand(module: module)
        case "registerBarcodeCaptureListenerForEvents":
            return RegisterBarcodeCaptureListenerForEventsCommand(module: module, method)
        case "unregisterBarcodeCaptureListenerForEvents":
            return UnregisterBarcodeCaptureListenerForEventsCommand(module: module, method)
        case "finishBarcodeCaptureDidUpdateSession":
            return FinishBarcodeCaptureDidUpdateSessionCommand(module: module, method)
        case "finishBarcodeCaptureDidScan":
            return FinishBarcodeCaptureDidScanCommand(module: module, method)
        case "setBarcodeCaptureModeEnabledState":
            return SetBarcodeCaptureModeEnabledStateCommand(module: module, method)
        case "updateBarcodeCaptureMode":
            return UpdateBarcodeCaptureModeCommand(module: module, method)
        case "applyBarcodeCaptureModeSettings":
            return ApplyBarcodeCaptureModeSettingsCommand(module: module, method)
        case "updateBarcodeCaptureOverlay":
            return UpdateBarcodeCaptureOverlayCommand(module: module, method)
        case "updateBarcodeCaptureFeedback":
            return UpdateBarcodeCaptureFeedbackCommand(module: module, method)
        default:
            return nil
        }
    }
}
