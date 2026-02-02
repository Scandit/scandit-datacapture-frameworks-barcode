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

/// Generated BarcodeCountModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeCountModule.

/// Updates the BarcodeCount view configuration
public class UpdateBarcodeCountViewCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let viewJson: String
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.viewJson = method.argument(key: "viewJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !viewJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'viewJson' is missing", details: nil)
            return
        }
        module.updateBarcodeCountView(
            viewId: viewId,
            viewJson: viewJson,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeCount view events
public class RegisterBarcodeCountViewListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountViewListener.brushForRecognizedBarcode",
                "BarcodeCountViewListener.brushForRecognizedBarcodeNotInList",
                "BarcodeCountViewListener.brushForAcceptedBarcode",
                "BarcodeCountViewListener.brushForRejectedBarcode",
                "BarcodeCountViewListener.didTapRecognizedBarcode",
                "BarcodeCountViewListener.didTapFilteredBarcode",
                "BarcodeCountViewListener.didTapRecognizedBarcodeNotInList",
                "BarcodeCountViewListener.didTapAcceptedBarcode",
                "BarcodeCountViewListener.didTapRejectedBarcode",
                "BarcodeCountViewListener.didCompleteCaptureList",
            ]
        )
        module.registerBarcodeCountViewListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeCount view events
public class UnregisterBarcodeCountViewListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountViewListener.brushForRecognizedBarcode",
                "BarcodeCountViewListener.brushForRecognizedBarcodeNotInList",
                "BarcodeCountViewListener.brushForAcceptedBarcode",
                "BarcodeCountViewListener.brushForRejectedBarcode",
                "BarcodeCountViewListener.didTapRecognizedBarcode",
                "BarcodeCountViewListener.didTapFilteredBarcode",
                "BarcodeCountViewListener.didTapRecognizedBarcodeNotInList",
                "BarcodeCountViewListener.didTapAcceptedBarcode",
                "BarcodeCountViewListener.didTapRejectedBarcode",
                "BarcodeCountViewListener.didCompleteCaptureList",
            ]
        )
        module.unregisterBarcodeCountViewListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeCount view UI events
public class RegisterBarcodeCountViewUiListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountViewUiListener.onListButtonTapped",
                "BarcodeCountViewUiListener.onExitButtonTapped",
                "BarcodeCountViewUiListener.onSingleScanButtonTapped",
            ]
        )
        module.registerBarcodeCountViewUiListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeCount view UI events
public class UnregisterBarcodeCountViewUiListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountViewUiListener.onListButtonTapped",
                "BarcodeCountViewUiListener.onExitButtonTapped",
                "BarcodeCountViewUiListener.onSingleScanButtonTapped",
            ]
        )
        module.unregisterBarcodeCountViewUiListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Clears all barcode highlights in the BarcodeCount view
public class ClearBarcodeCountHighlightsCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.clearBarcodeCountHighlights(
            viewId: viewId,
            result: result
        )
    }
}
/// Finish callback for recognized barcode brush
public class FinishBarcodeCountBrushForRecognizedBarcodeCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let brushJson: String?
    private let trackedBarcodeId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.brushJson = method.argument(key: "brushJson")
        self.trackedBarcodeId = method.argument(key: "trackedBarcodeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeCountBrushForRecognizedBarcode(
            viewId: viewId,
            brushJson: brushJson,
            trackedBarcodeId: trackedBarcodeId,
            result: result
        )
    }
}
/// Finish callback for recognized barcode not in list brush
public class FinishBarcodeCountBrushForRecognizedBarcodeNotInListCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let brushJson: String?
    private let trackedBarcodeId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.brushJson = method.argument(key: "brushJson")
        self.trackedBarcodeId = method.argument(key: "trackedBarcodeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeCountBrushForRecognizedBarcodeNotInList(
            viewId: viewId,
            brushJson: brushJson,
            trackedBarcodeId: trackedBarcodeId,
            result: result
        )
    }
}
/// Finish callback for accepted barcode brush
public class FinishBarcodeCountBrushForAcceptedBarcodeCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let brushJson: String?
    private let trackedBarcodeId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.brushJson = method.argument(key: "brushJson")
        self.trackedBarcodeId = method.argument(key: "trackedBarcodeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeCountBrushForAcceptedBarcode(
            viewId: viewId,
            brushJson: brushJson,
            trackedBarcodeId: trackedBarcodeId,
            result: result
        )
    }
}
/// Finish callback for rejected barcode brush
public class FinishBarcodeCountBrushForRejectedBarcodeCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let brushJson: String?
    private let trackedBarcodeId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.brushJson = method.argument(key: "brushJson")
        self.trackedBarcodeId = method.argument(key: "trackedBarcodeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeCountBrushForRejectedBarcode(
            viewId: viewId,
            brushJson: brushJson,
            trackedBarcodeId: trackedBarcodeId,
            result: result
        )
    }
}
/// Shows the BarcodeCount view
public class ShowBarcodeCountViewCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.showBarcodeCountView(
            viewId: viewId,
            result: result
        )
    }
}
/// Hides the BarcodeCount view
public class HideBarcodeCountViewCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.hideBarcodeCountView(
            viewId: viewId,
            result: result
        )
    }
}
/// Enables hardware trigger for BarcodeCount
public class EnableBarcodeCountHardwareTriggerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let hardwareTriggerKeyCode: Int?
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.hardwareTriggerKeyCode = method.argument(key: "hardwareTriggerKeyCode")
    }

    public func execute(result: FrameworksResult) {
        module.enableBarcodeCountHardwareTrigger(
            viewId: viewId,
            hardwareTriggerKeyCode: hardwareTriggerKeyCode,
            result: result
        )
    }
}
/// Updates the BarcodeCount mode configuration
public class UpdateBarcodeCountModeCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let barcodeCountJson: String
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.barcodeCountJson = method.argument(key: "barcodeCountJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeCountJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodeCountJson' is missing",
                details: nil
            )
            return
        }
        module.updateBarcodeCountMode(
            viewId: viewId,
            barcodeCountJson: barcodeCountJson,
            result: result
        )
    }
}
/// Resets the BarcodeCount mode
public class ResetBarcodeCountCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.resetBarcodeCount(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeCount mode events
public class RegisterBarcodeCountListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountListener.onScan"
            ]
        )
        module.registerBarcodeCountListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeCount mode events
public class RegisterBarcodeCountAsyncListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountListener.onScan"
            ]
        )
        module.registerBarcodeCountAsyncListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeCount mode events
public class UnregisterBarcodeCountListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountListener.onScan"
            ]
        )
        module.unregisterBarcodeCountListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeCount mode events
public class UnregisterBarcodeCountAsyncListenerCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountListener.onScan"
            ]
        )
        module.unregisterBarcodeCountAsyncListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Finish callback for BarcodeCount on scan event
public class FinishBarcodeCountOnScanCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeCountOnScan(
            viewId: viewId,
            result: result
        )
    }
}
/// Starts the BarcodeCount scanning phase
public class StartBarcodeCountScanningPhaseCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.startBarcodeCountScanningPhase(
            viewId: viewId,
            result: result
        )
    }
}
/// Ends the BarcodeCount scanning phase
public class EndBarcodeCountScanningPhaseCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.endBarcodeCountScanningPhase(
            viewId: viewId,
            result: result
        )
    }
}
/// Sets the capture list for BarcodeCount
public class SetBarcodeCountCaptureListCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let captureListJson: String
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.captureListJson = method.argument(key: "captureListJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !captureListJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'captureListJson' is missing",
                details: nil
            )
            return
        }
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeCountCaptureListListener.didUpdateSession"
            ]
        )
        module.setBarcodeCountCaptureList(
            viewId: viewId,
            captureListJson: captureListJson,
            result: result
        )
    }
}
/// Sets the enabled state of the BarcodeCount mode
public class SetBarcodeCountModeEnabledStateCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let isEnabled: Bool
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.isEnabled = method.argument(key: "isEnabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.setBarcodeCountModeEnabledState(
            viewId: viewId,
            isEnabled: isEnabled,
            result: result
        )
    }
}
/// Updates the BarcodeCount feedback configuration
public class UpdateBarcodeCountFeedbackCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let feedbackJson: String
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
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
        module.updateBarcodeCountFeedback(
            viewId: viewId,
            feedbackJson: feedbackJson,
            result: result
        )
    }
}
/// Resets the BarcodeCount session
public class ResetBarcodeCountSessionCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.resetBarcodeCountSession(
            viewId: viewId,
            result: result
        )
    }
}
/// Gets the BarcodeCount spatial map
public class GetBarcodeCountSpatialMapCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.getBarcodeCountSpatialMap(
            viewId: viewId,
            result: result
        )
    }
}
/// Gets the BarcodeCount spatial map with hints for expected grid dimensions
public class GetBarcodeCountSpatialMapWithHintsCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let expectedNumberOfRows: Int
    private let expectedNumberOfColumns: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.expectedNumberOfRows = method.argument(key: "expectedNumberOfRows") ?? Int()
        self.expectedNumberOfColumns = method.argument(key: "expectedNumberOfColumns") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.getBarcodeCountSpatialMapWithHints(
            viewId: viewId,
            expectedNumberOfRows: expectedNumberOfRows,
            expectedNumberOfColumns: expectedNumberOfColumns,
            result: result
        )
    }
}
/// Adds a barcode count status provider
public class AddBarcodeCountStatusProviderCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.addBarcodeCountStatusProvider(
            viewId: viewId,
            result: result
        )
    }
}
/// Submits the barcode count status provider callback
public class SubmitBarcodeCountStatusProviderCallbackCommand: BarcodeCountModuleCommand {
    private let module: BarcodeCountModule
    private let viewId: Int
    private let statusJson: String
    public init(module: BarcodeCountModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.statusJson = method.argument(key: "statusJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !statusJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'statusJson' is missing",
                details: nil
            )
            return
        }
        module.submitBarcodeCountStatusProviderCallback(
            viewId: viewId,
            statusJson: statusJson,
            result: result
        )
    }
}
