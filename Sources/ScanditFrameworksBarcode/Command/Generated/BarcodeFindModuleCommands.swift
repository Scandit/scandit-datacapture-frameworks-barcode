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

/// Generated BarcodeFindModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeFindModule.

/// Register persistent event listener for BarcodeFind view UI events
public class RegisterBarcodeFindViewListenerCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeFindViewUiListener.onFinishButtonTapped"
            ]
        )
        module.registerBarcodeFindViewListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeFind view UI events
public class UnregisterBarcodeFindViewListenerCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeFindViewUiListener.onFinishButtonTapped"
            ]
        )
        module.unregisterBarcodeFindViewListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Updates the BarcodeFind view configuration
public class UpdateFindViewCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    private let barcodeFindViewJson: String
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.barcodeFindViewJson = method.argument(key: "barcodeFindViewJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeFindViewJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodeFindViewJson' is missing",
                details: nil
            )
            return
        }
        module.updateFindView(
            viewId: viewId,
            barcodeFindViewJson: barcodeFindViewJson,
            result: result
        )
    }
}
/// Starts searching in the BarcodeFind view
public class BarcodeFindViewStartSearchingCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeFindViewStartSearching(
            viewId: viewId,
            result: result
        )
    }
}
/// Stops searching in the BarcodeFind view
public class BarcodeFindViewStopSearchingCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeFindViewStopSearching(
            viewId: viewId,
            result: result
        )
    }
}
/// Pauses searching in the BarcodeFind view
public class BarcodeFindViewPauseSearchingCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeFindViewPauseSearching(
            viewId: viewId,
            result: result
        )
    }
}
/// Shows the BarcodeFind view
public class ShowFindViewCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.showFindView(
            viewId: viewId,
            result: result
        )
    }
}
/// Hides the BarcodeFind view
public class HideFindViewCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.hideFindView(
            viewId: viewId,
            result: result
        )
    }
}
/// Updates the BarcodeFind mode configuration
public class UpdateFindModeCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    private let barcodeFindJson: String
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.barcodeFindJson = method.argument(key: "barcodeFindJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeFindJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodeFindJson' is missing",
                details: nil
            )
            return
        }
        module.updateFindMode(
            viewId: viewId,
            barcodeFindJson: barcodeFindJson,
            result: result
        )
    }
}
/// Starts the BarcodeFind mode
public class BarcodeFindModeStartCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeFindModeStart(
            viewId: viewId,
            result: result
        )
    }
}
/// Pauses the BarcodeFind mode
public class BarcodeFindModePauseCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeFindModePause(
            viewId: viewId,
            result: result
        )
    }
}
/// Stops the BarcodeFind mode
public class BarcodeFindModeStopCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeFindModeStop(
            viewId: viewId,
            result: result
        )
    }
}
/// Sets the item list for BarcodeFind
public class BarcodeFindSetItemListCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    private let itemsJson: String
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.itemsJson = method.argument(key: "itemsJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !itemsJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'itemsJson' is missing", details: nil)
            return
        }
        module.barcodeFindSetItemList(
            viewId: viewId,
            itemsJson: itemsJson,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeFind mode events
public class RegisterBarcodeFindListenerCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeFindListener.onSearchStarted",
                "BarcodeFindListener.onSearchPaused",
                "BarcodeFindListener.onSearchStopped",
                "BarcodeFindListener.didUpdateSession",
            ]
        )
        module.registerBarcodeFindListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeFind mode events
public class UnregisterBarcodeFindListenerCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeFindListener.onSearchStarted",
                "BarcodeFindListener.onSearchPaused",
                "BarcodeFindListener.onSearchStopped",
                "BarcodeFindListener.didUpdateSession",
            ]
        )
        module.unregisterBarcodeFindListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Sets the enabled state of the BarcodeFind mode
public class SetBarcodeFindModeEnabledStateCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    private let enabled: Bool
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.setBarcodeFindModeEnabledState(
            viewId: viewId,
            enabled: enabled,
            result: result
        )
    }
}
/// Sets the barcode transformer for BarcodeFind
public class SetBarcodeTransformerCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeFindTransformer.transformBarcodeData"
            ]
        )
        module.setBarcodeTransformer(
            viewId: viewId,
            result: result
        )
    }
}
/// Unsets the barcode transformer for BarcodeFind
public class UnsetBarcodeTransformerCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeFindTransformer.transformBarcodeData"
            ]
        )
        module.unsetBarcodeTransformer(
            viewId: viewId,
            result: result
        )
    }
}
/// Submits the barcode transformer result
public class SubmitBarcodeFindTransformerResultCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    private let transformedBarcode: String?
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.transformedBarcode = method.argument(key: "transformedBarcode")
    }

    public func execute(result: FrameworksResult) {
        module.submitBarcodeFindTransformerResult(
            viewId: viewId,
            transformedBarcode: transformedBarcode,
            result: result
        )
    }
}
/// Updates the BarcodeFind feedback configuration
public class UpdateBarcodeFindFeedbackCommand: BarcodeFindModuleCommand {
    private let module: BarcodeFindModule
    private let viewId: Int
    private let feedbackJson: String
    public init(module: BarcodeFindModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
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
        module.updateBarcodeFindFeedback(
            viewId: viewId,
            feedbackJson: feedbackJson,
            result: result
        )
    }
}
