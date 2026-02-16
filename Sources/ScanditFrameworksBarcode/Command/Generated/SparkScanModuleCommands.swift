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

/// Generated SparkScanModule command implementations.
/// Each command extracts parameters in its initializer and executes via SparkScanModule.

/// Updates the SparkScan view configuration
public class UpdateSparkScanViewCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let viewJson: String
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.viewJson = method.argument(key: "viewJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !viewJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'viewJson' is missing", details: nil)
            return
        }
        module.updateSparkScanView(
            viewId: viewId,
            viewJson: viewJson,
            result: result
        )
    }
}
/// Shows the SparkScan view
public class ShowSparkScanViewCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.showSparkScanView(
            viewId: viewId,
            result: result
        )
    }
}
/// Brings the SparkScan view to the front
public class BringSparkScanViewToFrontCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.bringSparkScanViewToFront(
            viewId: viewId,
            result: result
        )
    }
}
/// Hides the SparkScan view
public class HideSparkScanViewCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.hideSparkScanView(
            viewId: viewId,
            result: result
        )
    }
}
/// Disposes the SparkScan view
public class DisposeSparkScanViewCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.disposeSparkScanView(
            viewId: viewId,
            result: result
        )
    }
}
/// Shows a toast message in the SparkScan view
public class ShowSparkScanViewToastCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let text: String
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.text = method.argument(key: "text") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !text.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'text' is missing", details: nil)
            return
        }
        module.showSparkScanViewToast(
            viewId: viewId,
            text: text,
            result: result
        )
    }
}
/// Stops scanning in the SparkScan view
public class StopSparkScanViewScanningCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.stopSparkScanViewScanning(
            viewId: viewId,
            result: result
        )
    }
}
/// Handles host pause event for SparkScan view
public class OnHostPauseSparkScanViewCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.onHostPauseSparkScanView(
            viewId: viewId,
            result: result
        )
    }
}
/// Starts scanning in the SparkScan view
public class StartSparkScanViewScanningCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.startSparkScanViewScanning(
            viewId: viewId,
            result: result
        )
    }
}
/// Pauses scanning in the SparkScan view
public class PauseSparkScanViewScanningCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.pauseSparkScanViewScanning(
            viewId: viewId,
            result: result
        )
    }
}
/// Prepares the SparkScan view for scanning
public class PrepareSparkScanViewScanningCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.prepareSparkScanViewScanning(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for SparkScan feedback delegate events
public class RegisterSparkScanFeedbackDelegateForEventsCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "SparkScanFeedbackDelegate.feedbackForBarcode",
                "SparkScanFeedbackDelegate.feedbackForScannedItem",
            ]
        )
        module.registerSparkScanFeedbackDelegateForEvents(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for SparkScan feedback delegate events
public class UnregisterSparkScanFeedbackDelegateForEventsCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "SparkScanFeedbackDelegate.feedbackForBarcode",
                "SparkScanFeedbackDelegate.feedbackForScannedItem",
            ]
        )
        module.unregisterSparkScanFeedbackDelegateForEvents(
            viewId: viewId,
            result: result
        )
    }
}
/// Submits feedback for a scanned barcode
public class SubmitSparkScanFeedbackForBarcodeCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let feedbackJson: String?
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.feedbackJson = method.argument(key: "feedbackJson")
    }

    public func execute(result: FrameworksResult) {
        module.submitSparkScanFeedbackForBarcode(
            viewId: viewId,
            feedbackJson: feedbackJson,
            result: result
        )
    }
}
/// Submits feedback for a scanned item
public class SubmitSparkScanFeedbackForScannedItemCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let feedbackJson: String?
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.feedbackJson = method.argument(key: "feedbackJson")
    }

    public func execute(result: FrameworksResult) {
        module.submitSparkScanFeedbackForScannedItem(
            viewId: viewId,
            feedbackJson: feedbackJson,
            result: result
        )
    }
}
/// Register persistent event listener for SparkScan view events
public class RegisterSparkScanViewListenerEventsCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "SparkScanViewUiListener.barcodeFindButtonTapped",
                "SparkScanViewUiListener.barcodeCountButtonTapped",
                "SparkScanViewUiListener.labelCaptureButtonTapped",
                "SparkScanViewUiListener.didChangeViewState",
            ]
        )
        module.registerSparkScanViewListenerEvents(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for SparkScan view events
public class UnregisterSparkScanViewListenerEventsCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "SparkScanViewUiListener.barcodeFindButtonTapped",
                "SparkScanViewUiListener.barcodeCountButtonTapped",
                "SparkScanViewUiListener.labelCaptureButtonTapped",
                "SparkScanViewUiListener.didChangeViewState",
            ]
        )
        module.unregisterSparkScanViewListenerEvents(
            viewId: viewId,
            result: result
        )
    }
}
/// Resets the SparkScan session
public class ResetSparkScanSessionCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.resetSparkScanSession(
            viewId: viewId,
            result: result
        )
    }
}
/// Updates the SparkScan mode configuration
public class UpdateSparkScanModeCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let modeJson: String
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.modeJson = method.argument(key: "modeJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !modeJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'modeJson' is missing", details: nil)
            return
        }
        module.updateSparkScanMode(
            viewId: viewId,
            modeJson: modeJson,
            result: result
        )
    }
}
/// Register persistent event listener for SparkScan mode events
public class RegisterSparkScanListenerForEventsCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "SparkScanListener.didUpdateSession",
                "SparkScanListener.didScan",
            ]
        )
        module.registerSparkScanListenerForEvents(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for SparkScan mode events
public class UnregisterSparkScanListenerForEventsCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "SparkScanListener.didUpdateSession",
                "SparkScanListener.didScan",
            ]
        )
        module.unregisterSparkScanListenerForEvents(
            viewId: viewId,
            result: result
        )
    }
}
/// Finish callback for SparkScan did update session event
public class FinishSparkScanDidUpdateSessionCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let isEnabled: Bool
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.isEnabled = method.argument(key: "isEnabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.finishSparkScanDidUpdateSession(
            viewId: viewId,
            isEnabled: isEnabled,
            result: result
        )
    }
}
/// Finish callback for SparkScan did scan event
public class FinishSparkScanDidScanCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let isEnabled: Bool
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.isEnabled = method.argument(key: "isEnabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.finishSparkScanDidScan(
            viewId: viewId,
            isEnabled: isEnabled,
            result: result
        )
    }
}
/// Sets the enabled state of the SparkScan mode
public class SetSparkScanModeEnabledStateCommand: SparkScanModuleCommand {
    private let module: SparkScanModule
    private let viewId: Int
    private let isEnabled: Bool
    public init(module: SparkScanModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.isEnabled = method.argument(key: "isEnabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.setSparkScanModeEnabledState(
            viewId: viewId,
            isEnabled: isEnabled,
            result: result
        )
    }
}
