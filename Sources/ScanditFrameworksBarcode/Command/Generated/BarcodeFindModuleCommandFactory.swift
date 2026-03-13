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

/// Factory for creating BarcodeFindModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeFindModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeFindModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: BarcodeFindModule, _ method: FrameworksMethodCall) -> BarcodeFindModuleCommand? {
        switch method.method {
        case "registerBarcodeFindViewListener":
            return RegisterBarcodeFindViewListenerCommand(module: module, method)
        case "unregisterBarcodeFindViewListener":
            return UnregisterBarcodeFindViewListenerCommand(module: module, method)
        case "updateFindView":
            return UpdateFindViewCommand(module: module, method)
        case "barcodeFindViewStartSearching":
            return BarcodeFindViewStartSearchingCommand(module: module, method)
        case "barcodeFindViewStopSearching":
            return BarcodeFindViewStopSearchingCommand(module: module, method)
        case "barcodeFindViewPauseSearching":
            return BarcodeFindViewPauseSearchingCommand(module: module, method)
        case "showFindView":
            return ShowFindViewCommand(module: module, method)
        case "hideFindView":
            return HideFindViewCommand(module: module, method)
        case "updateFindMode":
            return UpdateFindModeCommand(module: module, method)
        case "barcodeFindModeStart":
            return BarcodeFindModeStartCommand(module: module, method)
        case "barcodeFindModePause":
            return BarcodeFindModePauseCommand(module: module, method)
        case "barcodeFindModeStop":
            return BarcodeFindModeStopCommand(module: module, method)
        case "barcodeFindSetItemList":
            return BarcodeFindSetItemListCommand(module: module, method)
        case "registerBarcodeFindListener":
            return RegisterBarcodeFindListenerCommand(module: module, method)
        case "unregisterBarcodeFindListener":
            return UnregisterBarcodeFindListenerCommand(module: module, method)
        case "setBarcodeFindModeEnabledState":
            return SetBarcodeFindModeEnabledStateCommand(module: module, method)
        case "setBarcodeTransformer":
            return SetBarcodeTransformerCommand(module: module, method)
        case "unsetBarcodeTransformer":
            return UnsetBarcodeTransformerCommand(module: module, method)
        case "submitBarcodeFindTransformerResult":
            return SubmitBarcodeFindTransformerResultCommand(module: module, method)
        case "updateBarcodeFindFeedback":
            return UpdateBarcodeFindFeedbackCommand(module: module, method)
        default:
            return nil
        }
    }
}
