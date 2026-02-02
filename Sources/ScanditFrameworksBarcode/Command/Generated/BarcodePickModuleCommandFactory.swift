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

/// Factory for creating BarcodePickModule commands from method calls.
/// Maps method names to their corresponding command implementations.
public class BarcodePickModuleCommandFactory {
    /// Creates a command from a FrameworksMethodCall.
    ///
    /// - Parameter module: The BarcodePickModule instance to bind to the command
    /// - Parameter method: The method call containing method name and arguments
    /// - Returns: The corresponding command, or nil if method is not recognized
    public static func create(module: BarcodePickModule, _ method: FrameworksMethodCall) -> BarcodePickModuleCommand? {
        switch method.method {
        case "pickViewStart":
            return PickViewStartCommand(module: module, method)
        case "pickViewFreeze":
            return PickViewFreezeCommand(module: module, method)
        case "pickViewStop":
            return PickViewStopCommand(module: module, method)
        case "pickViewReset":
            return PickViewResetCommand(module: module, method)
        case "pickViewPause":
            return PickViewPauseCommand(module: module, method)
        case "pickViewResume":
            return PickViewResumeCommand(module: module, method)
        case "finishPickAction":
            return FinishPickActionCommand(module: module, method)
        case "updatePickView":
            return UpdatePickViewCommand(module: module, method)
        case "addBarcodePickListener":
            return AddBarcodePickListenerCommand(module: module, method)
        case "removeBarcodePickListener":
            return RemoveBarcodePickListenerCommand(module: module, method)
        case "addBarcodePickScanningListener":
            return AddBarcodePickScanningListenerCommand(module: module, method)
        case "removeBarcodePickScanningListener":
            return RemoveBarcodePickScanningListenerCommand(module: module, method)
        case "addPickActionListener":
            return AddPickActionListenerCommand(module: module, method)
        case "removePickActionListener":
            return RemovePickActionListenerCommand(module: module, method)
        case "addPickViewListener":
            return AddPickViewListenerCommand(module: module, method)
        case "removePickViewListener":
            return RemovePickViewListenerCommand(module: module, method)
        case "registerBarcodePickViewUiListener":
            return RegisterBarcodePickViewUiListenerCommand(module: module, method)
        case "unregisterBarcodePickViewUiListener":
            return UnregisterBarcodePickViewUiListenerCommand(module: module, method)
        case "registerOnProductIdentifierForItemsListener":
            return RegisterOnProductIdentifierForItemsListenerCommand(module: module, method)
        case "unregisterOnProductIdentifierForItemsListener":
            return UnregisterOnProductIdentifierForItemsListenerCommand(module: module, method)
        case "registerHighlightStyleAsyncProviderListener":
            return RegisterHighlightStyleAsyncProviderListenerCommand(module: module, method)
        case "unregisterHighlightStyleAsyncProviderListener":
            return UnregisterHighlightStyleAsyncProviderListenerCommand(module: module, method)
        case "finishOnProductIdentifierForItems":
            return FinishOnProductIdentifierForItemsCommand(module: module, method)
        case "finishBarcodePickViewHighlightStyleCustomViewProviderViewForRequest":
            return FinishBarcodePickViewHighlightStyleCustomViewProviderViewForRequestCommand(module: module, method)
        case "finishBarcodePickViewHighlightStyleAsyncProviderStyleForRequest":
            return FinishBarcodePickViewHighlightStyleAsyncProviderStyleForRequestCommand(module: module, method)
        case "pickViewRelease":
            return PickViewReleaseCommand(module: module, method)
        case "selectItemWithData":
            return SelectItemWithDataCommand(module: module, method)
        case "confirmActionForItemWithData":
            return ConfirmActionForItemWithDataCommand(module: module, method)
        case "cancelActionForItemWithData":
            return CancelActionForItemWithDataCommand(module: module, method)
        case "updateProductList":
            return UpdateProductListCommand(module: module, method)
        default:
            return nil
        }
    }
}
