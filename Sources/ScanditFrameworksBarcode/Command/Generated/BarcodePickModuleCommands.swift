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

/// Generated BarcodePickModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodePickModule.

/// Starts the BarcodePick view scanning
public class PickViewStartCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pickViewStart(
            viewId: viewId,
            result: result
        )
    }
}
/// Freezes the BarcodePick view scanning
public class PickViewFreezeCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pickViewFreeze(
            viewId: viewId,
            result: result
        )
    }
}
/// Stops the BarcodePick view scanning
public class PickViewStopCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pickViewStop(
            viewId: viewId,
            result: result
        )
    }
}
/// Resets the BarcodePick view
public class PickViewResetCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pickViewReset(
            viewId: viewId,
            result: result
        )
    }
}
/// Pauses the BarcodePick view scanning
public class PickViewPauseCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pickViewPause(
            viewId: viewId,
            result: result
        )
    }
}
/// Resumes the BarcodePick view scanning
public class PickViewResumeCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pickViewResume(
            viewId: viewId,
            result: result
        )
    }
}
/// Finish callback for pick action
public class FinishPickActionCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let itemData: String
    private let actionResult: Bool
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.itemData = method.argument(key: "itemData") ?? ""
        self.actionResult = method.argument(key: "actionResult") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        guard !itemData.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'itemData' is missing", details: nil)
            return
        }
        module.finishPickAction(
            viewId: viewId,
            itemData: itemData,
            actionResult: actionResult,
            result: result
        )
    }
}
/// Updates the BarcodePick view configuration
public class UpdatePickViewCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let json: String
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.json = method.argument(key: "json") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !json.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'json' is missing", details: nil)
            return
        }
        module.updatePickView(
            viewId: viewId,
            json: json,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodePick mode events
public class AddBarcodePickListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickListener.didUpdateSession"
            ]
        )
        module.addBarcodePickListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodePick mode events
public class RemoveBarcodePickListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickListener.didUpdateSession"
            ]
        )
        module.removeBarcodePickListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodePick scanning events
public class AddBarcodePickScanningListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickScanningListener.didCompleteScanningSession",
                "BarcodePickScanningListener.didUpdateScanningSession",
            ]
        )
        module.addBarcodePickScanningListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodePick scanning events
public class RemoveBarcodePickScanningListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickScanningListener.didCompleteScanningSession",
                "BarcodePickScanningListener.didUpdateScanningSession",
            ]
        )
        module.removeBarcodePickScanningListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodePick action events
public class AddPickActionListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickActionListener.didPick",
                "BarcodePickActionListener.didUnpick",
            ]
        )
        module.addPickActionListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodePick action events
public class RemovePickActionListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickActionListener.didPick",
                "BarcodePickActionListener.didUnpick",
            ]
        )
        module.removePickActionListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodePick view lifecycle events
public class AddPickViewListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickViewListener.didStartScanning",
                "BarcodePickViewListener.didFreezeScanning",
                "BarcodePickViewListener.didPauseScanning",
                "BarcodePickViewListener.didStopScanning",
            ]
        )
        module.addPickViewListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodePick view lifecycle events
public class RemovePickViewListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickViewListener.didStartScanning",
                "BarcodePickViewListener.didFreezeScanning",
                "BarcodePickViewListener.didPauseScanning",
                "BarcodePickViewListener.didStopScanning",
            ]
        )
        module.removePickViewListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodePick view UI events
public class RegisterBarcodePickViewUiListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickViewUiListener.didTapFinishButton"
            ]
        )
        module.registerBarcodePickViewUiListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodePick view UI events
public class UnregisterBarcodePickViewUiListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickViewUiListener.didTapFinishButton"
            ]
        )
        module.unregisterBarcodePickViewUiListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for product identifier provider events
public class RegisterOnProductIdentifierForItemsListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickAsyncMapperProductProviderCallback.onProductIdentifierForItems"
            ]
        )
        module.registerOnProductIdentifierForItemsListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for product identifier provider events
public class UnregisterOnProductIdentifierForItemsListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickAsyncMapperProductProviderCallback.onProductIdentifierForItems"
            ]
        )
        module.unregisterOnProductIdentifierForItemsListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for highlight style async provider events
public class RegisterHighlightStyleAsyncProviderListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickViewHighlightStyleAsyncProvider.styleForRequest"
            ]
        )
        module.registerHighlightStyleAsyncProviderListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for highlight style async provider events
public class UnregisterHighlightStyleAsyncProviderListenerCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodePickViewHighlightStyleAsyncProvider.styleForRequest"
            ]
        )
        module.unregisterHighlightStyleAsyncProviderListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Finish callback for product identifier for items
public class FinishOnProductIdentifierForItemsCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let itemsJson: String
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.itemsJson = method.argument(key: "itemsJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !itemsJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'itemsJson' is missing", details: nil)
            return
        }
        module.finishOnProductIdentifierForItems(
            viewId: viewId,
            itemsJson: itemsJson,
            result: result
        )
    }
}
/// Finish callback for barcode pick view highlight style custom view provider view for request
public class FinishBarcodePickViewHighlightStyleCustomViewProviderViewForRequestCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let requestId: Int
    private let response: [String: Any]?
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.requestId = method.argument(key: "requestId") ?? Int()
        self.response = method.argument(key: "response")
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodePickViewHighlightStyleCustomViewProviderViewForRequest(
            viewId: viewId,
            requestId: requestId,
            response: response,
            result: result
        )
    }
}
/// Finish callback for barcode pick view highlight style async provider style for request
public class FinishBarcodePickViewHighlightStyleAsyncProviderStyleForRequestCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let requestId: Int
    private let responseJson: String?
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.requestId = method.argument(key: "requestId") ?? Int()
        self.responseJson = method.argument(key: "responseJson")
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodePickViewHighlightStyleAsyncProviderStyleForRequest(
            viewId: viewId,
            requestId: requestId,
            responseJson: responseJson,
            result: result
        )
    }
}
/// Release the BarcodePick view
public class PickViewReleaseCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pickViewRelease(
            viewId: viewId,
            result: result
        )
    }
}
/// Selects an item with the specified data
public class SelectItemWithDataCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let data: String
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.data = method.argument(key: "data") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !data.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'data' is missing", details: nil)
            return
        }
        module.selectItemWithData(
            viewId: viewId,
            data: data,
            result: result
        )
    }
}
/// Confirms the action for an item with the specified data
public class ConfirmActionForItemWithDataCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let data: String
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.data = method.argument(key: "data") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !data.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'data' is missing", details: nil)
            return
        }
        module.confirmActionForItemWithData(
            viewId: viewId,
            data: data,
            result: result
        )
    }
}
/// Cancels the action for an item with the specified data
public class CancelActionForItemWithDataCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let data: String
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.data = method.argument(key: "data") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !data.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'data' is missing", details: nil)
            return
        }
        module.cancelActionForItemWithData(
            viewId: viewId,
            data: data,
            result: result
        )
    }
}
/// Updates the product list for the BarcodePick view
public class UpdateProductListCommand: BarcodePickModuleCommand {
    private let module: BarcodePickModule
    private let viewId: Int
    private let productsJson: String
    public init(module: BarcodePickModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.productsJson = method.argument(key: "productsJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !productsJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'productsJson' is missing",
                details: nil
            )
            return
        }
        module.updateProductList(
            viewId: viewId,
            productsJson: productsJson,
            result: result
        )
    }
}
