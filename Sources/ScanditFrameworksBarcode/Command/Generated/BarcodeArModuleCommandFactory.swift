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

/// Factory for creating BarcodeArModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeArModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeArModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: BarcodeArModule, _ method: FrameworksMethodCall) -> BarcodeArModuleCommand? {
        switch method.method {
        case "registerBarcodeArViewUiListener":
            return RegisterBarcodeArViewUiListenerCommand(module: module, method)
        case "unregisterBarcodeArViewUiListener":
            return UnregisterBarcodeArViewUiListenerCommand(module: module, method)
        case "registerBarcodeArAnnotationProvider":
            return RegisterBarcodeArAnnotationProviderCommand(module: module, method)
        case "unregisterBarcodeArAnnotationProvider":
            return UnregisterBarcodeArAnnotationProviderCommand(module: module, method)
        case "registerBarcodeArHighlightProvider":
            return RegisterBarcodeArHighlightProviderCommand(module: module, method)
        case "unregisterBarcodeArHighlightProvider":
            return UnregisterBarcodeArHighlightProviderCommand(module: module, method)
        case "onCustomHighlightClicked":
            return OnCustomHighlightClickedCommand(module: module, method)
        case "barcodeArViewStart":
            return BarcodeArViewStartCommand(module: module, method)
        case "barcodeArViewStop":
            return BarcodeArViewStopCommand(module: module, method)
        case "barcodeArViewPause":
            return BarcodeArViewPauseCommand(module: module, method)
        case "barcodeArViewReset":
            return BarcodeArViewResetCommand(module: module, method)
        case "updateBarcodeArView":
            return UpdateBarcodeArViewCommand(module: module, method)
        case "finishBarcodeArAnnotationForBarcode":
            return FinishBarcodeArAnnotationForBarcodeCommand(module: module, method)
        case "finishBarcodeArHighlightForBarcode":
            return FinishBarcodeArHighlightForBarcodeCommand(module: module, method)
        case "updateBarcodeArHighlight":
            return UpdateBarcodeArHighlightCommand(module: module, method)
        case "updateBarcodeArAnnotation":
            return UpdateBarcodeArAnnotationCommand(module: module, method)
        case "updateBarcodeArPopoverButtonAtIndex":
            return UpdateBarcodeArPopoverButtonAtIndexCommand(module: module, method)
        case "applyBarcodeArSettings":
            return ApplyBarcodeArSettingsCommand(module: module, method)
        case "updateBarcodeArMode":
            return UpdateBarcodeArModeCommand(module: module, method)
        case "updateBarcodeArFeedback":
            return UpdateBarcodeArFeedbackCommand(module: module, method)
        case "registerBarcodeArListener":
            return RegisterBarcodeArListenerCommand(module: module, method)
        case "unregisterBarcodeArListener":
            return UnregisterBarcodeArListenerCommand(module: module, method)
        case "finishBarcodeArOnDidUpdateSession":
            return FinishBarcodeArOnDidUpdateSessionCommand(module: module, method)
        case "resetBarcodeArSession":
            return ResetBarcodeArSessionCommand(module: module, method)
        default:
            return nil
        }
    }
}
