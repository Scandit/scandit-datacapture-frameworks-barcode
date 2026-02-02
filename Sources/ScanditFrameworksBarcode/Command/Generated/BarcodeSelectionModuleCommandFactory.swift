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

/// Factory for creating BarcodeSelectionModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeSelectionModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeSelectionModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(
        module: BarcodeSelectionModule,
        _ method: FrameworksMethodCall
    ) -> BarcodeSelectionModuleCommand? {
        switch method.method {
        case "unfreezeCameraInBarcodeSelection":
            return UnfreezeCameraInBarcodeSelectionCommand(module: module, method)
        case "resetBarcodeSelection":
            return ResetBarcodeSelectionCommand(module: module, method)
        case "selectAimedBarcode":
            return SelectAimedBarcodeCommand(module: module, method)
        case "unselectBarcodes":
            return UnselectBarcodesCommand(module: module, method)
        case "setSelectBarcodeEnabled":
            return SetSelectBarcodeEnabledCommand(module: module, method)
        case "increaseCountForBarcodes":
            return IncreaseCountForBarcodesCommand(module: module, method)
        case "setBarcodeSelectionModeEnabledState":
            return SetBarcodeSelectionModeEnabledStateCommand(module: module, method)
        case "updateBarcodeSelectionMode":
            return UpdateBarcodeSelectionModeCommand(module: module, method)
        case "applyBarcodeSelectionModeSettings":
            return ApplyBarcodeSelectionModeSettingsCommand(module: module, method)
        case "updateBarcodeSelectionFeedback":
            return UpdateBarcodeSelectionFeedbackCommand(module: module, method)
        case "getCountForBarcodeInBarcodeSelectionSession":
            return GetCountForBarcodeInBarcodeSelectionSessionCommand(module: module, method)
        case "resetBarcodeSelectionSession":
            return ResetBarcodeSelectionSessionCommand(module: module, method)
        case "finishBarcodeSelectionDidSelect":
            return FinishBarcodeSelectionDidSelectCommand(module: module, method)
        case "finishBarcodeSelectionDidUpdateSession":
            return FinishBarcodeSelectionDidUpdateSessionCommand(module: module, method)
        case "registerBarcodeSelectionListenerForEvents":
            return RegisterBarcodeSelectionListenerForEventsCommand(module: module, method)
        case "unregisterBarcodeSelectionListenerForEvents":
            return UnregisterBarcodeSelectionListenerForEventsCommand(module: module, method)
        case "setTextForAimToSelectAutoHint":
            return SetTextForAimToSelectAutoHintCommand(module: module, method)
        case "removeAimedBarcodeBrushProvider":
            return RemoveAimedBarcodeBrushProviderCommand(module: module)
        case "setAimedBarcodeBrushProvider":
            return SetAimedBarcodeBrushProviderCommand(module: module)
        case "finishBrushForAimedBarcodeCallback":
            return FinishBrushForAimedBarcodeCallbackCommand(module: module, method)
        case "removeTrackedBarcodeBrushProvider":
            return RemoveTrackedBarcodeBrushProviderCommand(module: module)
        case "setTrackedBarcodeBrushProvider":
            return SetTrackedBarcodeBrushProviderCommand(module: module)
        case "finishBrushForTrackedBarcodeCallback":
            return FinishBrushForTrackedBarcodeCallbackCommand(module: module, method)
        case "updateBarcodeSelectionBasicOverlay":
            return UpdateBarcodeSelectionBasicOverlayCommand(module: module, method)
        default:
            return nil
        }
    }
}
