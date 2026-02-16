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

/// Factory for creating BarcodeCountModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeCountModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeCountModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: BarcodeCountModule, _ method: FrameworksMethodCall) -> BarcodeCountModuleCommand?
    {
        switch method.method {
        case "updateBarcodeCountView":
            return UpdateBarcodeCountViewCommand(module: module, method)
        case "registerBarcodeCountViewListener":
            return RegisterBarcodeCountViewListenerCommand(module: module, method)
        case "unregisterBarcodeCountViewListener":
            return UnregisterBarcodeCountViewListenerCommand(module: module, method)
        case "registerBarcodeCountViewUiListener":
            return RegisterBarcodeCountViewUiListenerCommand(module: module, method)
        case "unregisterBarcodeCountViewUiListener":
            return UnregisterBarcodeCountViewUiListenerCommand(module: module, method)
        case "clearBarcodeCountHighlights":
            return ClearBarcodeCountHighlightsCommand(module: module, method)
        case "finishBarcodeCountBrushForRecognizedBarcode":
            return FinishBarcodeCountBrushForRecognizedBarcodeCommand(module: module, method)
        case "finishBarcodeCountBrushForRecognizedBarcodeNotInList":
            return FinishBarcodeCountBrushForRecognizedBarcodeNotInListCommand(module: module, method)
        case "finishBarcodeCountBrushForAcceptedBarcode":
            return FinishBarcodeCountBrushForAcceptedBarcodeCommand(module: module, method)
        case "finishBarcodeCountBrushForRejectedBarcode":
            return FinishBarcodeCountBrushForRejectedBarcodeCommand(module: module, method)
        case "showBarcodeCountView":
            return ShowBarcodeCountViewCommand(module: module, method)
        case "hideBarcodeCountView":
            return HideBarcodeCountViewCommand(module: module, method)
        case "enableBarcodeCountHardwareTrigger":
            return EnableBarcodeCountHardwareTriggerCommand(module: module, method)
        case "updateBarcodeCountMode":
            return UpdateBarcodeCountModeCommand(module: module, method)
        case "resetBarcodeCount":
            return ResetBarcodeCountCommand(module: module, method)
        case "registerBarcodeCountListener":
            return RegisterBarcodeCountListenerCommand(module: module, method)
        case "registerBarcodeCountAsyncListener":
            return RegisterBarcodeCountAsyncListenerCommand(module: module, method)
        case "unregisterBarcodeCountListener":
            return UnregisterBarcodeCountListenerCommand(module: module, method)
        case "unregisterBarcodeCountAsyncListener":
            return UnregisterBarcodeCountAsyncListenerCommand(module: module, method)
        case "finishBarcodeCountOnScan":
            return FinishBarcodeCountOnScanCommand(module: module, method)
        case "startBarcodeCountScanningPhase":
            return StartBarcodeCountScanningPhaseCommand(module: module, method)
        case "endBarcodeCountScanningPhase":
            return EndBarcodeCountScanningPhaseCommand(module: module, method)
        case "setBarcodeCountCaptureList":
            return SetBarcodeCountCaptureListCommand(module: module, method)
        case "setBarcodeCountModeEnabledState":
            return SetBarcodeCountModeEnabledStateCommand(module: module, method)
        case "updateBarcodeCountFeedback":
            return UpdateBarcodeCountFeedbackCommand(module: module, method)
        case "resetBarcodeCountSession":
            return ResetBarcodeCountSessionCommand(module: module, method)
        case "getBarcodeCountSpatialMap":
            return GetBarcodeCountSpatialMapCommand(module: module, method)
        case "getBarcodeCountSpatialMapWithHints":
            return GetBarcodeCountSpatialMapWithHintsCommand(module: module, method)
        case "addBarcodeCountStatusProvider":
            return AddBarcodeCountStatusProviderCommand(module: module, method)
        case "submitBarcodeCountStatusProviderCallback":
            return SubmitBarcodeCountStatusProviderCallbackCommand(module: module, method)
        default:
            return nil
        }
    }
}
