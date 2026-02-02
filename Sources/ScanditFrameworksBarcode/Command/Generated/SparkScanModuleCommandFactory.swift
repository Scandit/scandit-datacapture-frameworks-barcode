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

/// Factory for creating SparkScanModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class SparkScanModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The SparkScanModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: SparkScanModule, _ method: FrameworksMethodCall) -> SparkScanModuleCommand? {
        switch method.method {
        case "updateSparkScanView":
            return UpdateSparkScanViewCommand(module: module, method)
        case "showSparkScanView":
            return ShowSparkScanViewCommand(module: module, method)
        case "bringSparkScanViewToFront":
            return BringSparkScanViewToFrontCommand(module: module, method)
        case "hideSparkScanView":
            return HideSparkScanViewCommand(module: module, method)
        case "disposeSparkScanView":
            return DisposeSparkScanViewCommand(module: module, method)
        case "showSparkScanViewToast":
            return ShowSparkScanViewToastCommand(module: module, method)
        case "stopSparkScanViewScanning":
            return StopSparkScanViewScanningCommand(module: module, method)
        case "onHostPauseSparkScanView":
            return OnHostPauseSparkScanViewCommand(module: module, method)
        case "startSparkScanViewScanning":
            return StartSparkScanViewScanningCommand(module: module, method)
        case "pauseSparkScanViewScanning":
            return PauseSparkScanViewScanningCommand(module: module, method)
        case "prepareSparkScanViewScanning":
            return PrepareSparkScanViewScanningCommand(module: module, method)
        case "registerSparkScanFeedbackDelegateForEvents":
            return RegisterSparkScanFeedbackDelegateForEventsCommand(module: module, method)
        case "unregisterSparkScanFeedbackDelegateForEvents":
            return UnregisterSparkScanFeedbackDelegateForEventsCommand(module: module, method)
        case "submitSparkScanFeedbackForBarcode":
            return SubmitSparkScanFeedbackForBarcodeCommand(module: module, method)
        case "submitSparkScanFeedbackForScannedItem":
            return SubmitSparkScanFeedbackForScannedItemCommand(module: module, method)
        case "registerSparkScanViewListenerEvents":
            return RegisterSparkScanViewListenerEventsCommand(module: module, method)
        case "unregisterSparkScanViewListenerEvents":
            return UnregisterSparkScanViewListenerEventsCommand(module: module, method)
        case "resetSparkScanSession":
            return ResetSparkScanSessionCommand(module: module, method)
        case "updateSparkScanMode":
            return UpdateSparkScanModeCommand(module: module, method)
        case "registerSparkScanListenerForEvents":
            return RegisterSparkScanListenerForEventsCommand(module: module, method)
        case "unregisterSparkScanListenerForEvents":
            return UnregisterSparkScanListenerForEventsCommand(module: module, method)
        case "finishSparkScanDidUpdateSession":
            return FinishSparkScanDidUpdateSessionCommand(module: module, method)
        case "finishSparkScanDidScan":
            return FinishSparkScanDidScanCommand(module: module, method)
        case "setSparkScanModeEnabledState":
            return SetSparkScanModeEnabledStateCommand(module: module, method)
        default:
            return nil
        }
    }
}
