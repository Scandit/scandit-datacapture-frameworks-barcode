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

/// Factory for creating BarcodeBatchModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodeBatchModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodeBatchModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: BarcodeBatchModule, _ method: FrameworksMethodCall) -> BarcodeBatchModuleCommand?
    {
        switch method.method {
        case "resetBarcodeBatchSession":
            return ResetBarcodeBatchSessionCommand(module: module)
        case "registerBarcodeBatchListenerForEvents":
            return RegisterBarcodeBatchListenerForEventsCommand(module: module, method)
        case "unregisterBarcodeBatchListenerForEvents":
            return UnregisterBarcodeBatchListenerForEventsCommand(module: module, method)
        case "finishBarcodeBatchDidUpdateSessionCallback":
            return FinishBarcodeBatchDidUpdateSessionCallbackCommand(module: module, method)
        case "setBarcodeBatchModeEnabledState":
            return SetBarcodeBatchModeEnabledStateCommand(module: module, method)
        case "updateBarcodeBatchMode":
            return UpdateBarcodeBatchModeCommand(module: module, method)
        case "applyBarcodeBatchModeSettings":
            return ApplyBarcodeBatchModeSettingsCommand(module: module, method)
        case "setBrushForTrackedBarcode":
            return SetBrushForTrackedBarcodeCommand(module: module, method)
        case "clearTrackedBarcodeBrushes":
            return ClearTrackedBarcodeBrushesCommand(module: module, method)
        case "registerListenerForBasicOverlayEvents":
            return RegisterListenerForBasicOverlayEventsCommand(module: module, method)
        case "unregisterListenerForBasicOverlayEvents":
            return UnregisterListenerForBasicOverlayEventsCommand(module: module, method)
        case "updateBarcodeBatchBasicOverlay":
            return UpdateBarcodeBatchBasicOverlayCommand(module: module, method)
        case "setViewForTrackedBarcode":
            return SetViewForTrackedBarcodeCommand(module: module, method)
        case "setViewForTrackedBarcodeFromBytes":
            return SetViewForTrackedBarcodeFromBytesCommand(module: module, method)
        case "updateSizeOfTrackedBarcodeView":
            return UpdateSizeOfTrackedBarcodeViewCommand(module: module, method)
        case "setAnchorForTrackedBarcode":
            return SetAnchorForTrackedBarcodeCommand(module: module, method)
        case "setOffsetForTrackedBarcode":
            return SetOffsetForTrackedBarcodeCommand(module: module, method)
        case "clearTrackedBarcodeViews":
            return ClearTrackedBarcodeViewsCommand(module: module, method)
        case "registerListenerForAdvancedOverlayEvents":
            return RegisterListenerForAdvancedOverlayEventsCommand(module: module, method)
        case "unregisterListenerForAdvancedOverlayEvents":
            return UnregisterListenerForAdvancedOverlayEventsCommand(module: module, method)
        case "updateBarcodeBatchAdvancedOverlay":
            return UpdateBarcodeBatchAdvancedOverlayCommand(module: module, method)
        default:
            return nil
        }
    }
}
