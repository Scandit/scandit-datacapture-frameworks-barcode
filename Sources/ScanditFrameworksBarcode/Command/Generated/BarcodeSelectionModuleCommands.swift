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

/// Generated BarcodeSelectionModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeSelectionModule.

/// Unfreezes the camera in barcode selection mode
public class UnfreezeCameraInBarcodeSelectionCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.unfreezeCameraInBarcodeSelection(
            modeId: modeId,
            result: result
        )
    }
}
/// Resets the barcode selection
public class ResetBarcodeSelectionCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.resetBarcodeSelection(
            modeId: modeId,
            result: result
        )
    }
}
/// Selects the aimed barcode
public class SelectAimedBarcodeCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.selectAimedBarcode(
            modeId: modeId,
            result: result
        )
    }
}
/// Unselects specified barcodes
public class UnselectBarcodesCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let barcodesJson: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.barcodesJson = method.argument(key: "barcodesJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodesJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodesJson' is missing",
                details: nil
            )
            return
        }
        module.unselectBarcodes(
            modeId: modeId,
            barcodesJson: barcodesJson,
            result: result
        )
    }
}
/// Sets whether a barcode can be selected
public class SetSelectBarcodeEnabledCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let barcodeJson: String
    private let enabled: Bool
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.barcodeJson = method.argument(key: "barcodeJson") ?? ""
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodeJson' is missing",
                details: nil
            )
            return
        }
        module.setSelectBarcodeEnabled(
            modeId: modeId,
            barcodeJson: barcodeJson,
            enabled: enabled,
            result: result
        )
    }
}
/// Increases the count for specified barcodes
public class IncreaseCountForBarcodesCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let barcodeJson: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.barcodeJson = method.argument(key: "barcodeJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'barcodeJson' is missing",
                details: nil
            )
            return
        }
        module.increaseCountForBarcodes(
            modeId: modeId,
            barcodeJson: barcodeJson,
            result: result
        )
    }
}
/// Sets the enabled state of the barcode selection mode
public class SetBarcodeSelectionModeEnabledStateCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.setBarcodeSelectionModeEnabledState(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Updates the barcode selection mode configuration
public class UpdateBarcodeSelectionModeCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let modeJson: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.modeJson = method.argument(key: "modeJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !modeJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'modeJson' is missing", details: nil)
            return
        }
        module.updateBarcodeSelectionMode(
            modeId: modeId,
            modeJson: modeJson,
            result: result
        )
    }
}
/// Applies new settings to the barcode selection mode
public class ApplyBarcodeSelectionModeSettingsCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let modeSettingsJson: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.modeSettingsJson = method.argument(key: "modeSettingsJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !modeSettingsJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'modeSettingsJson' is missing",
                details: nil
            )
            return
        }
        module.applyBarcodeSelectionModeSettings(
            modeId: modeId,
            modeSettingsJson: modeSettingsJson,
            result: result
        )
    }
}
/// Updates the barcode selection feedback configuration
public class UpdateBarcodeSelectionFeedbackCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let feedbackJson: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
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
        module.updateBarcodeSelectionFeedback(
            modeId: modeId,
            feedbackJson: feedbackJson,
            result: result
        )
    }
}
/// Gets the count for a barcode in the selection session
public class GetCountForBarcodeInBarcodeSelectionSessionCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let selectionIdentifier: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.selectionIdentifier = method.argument(key: "selectionIdentifier") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !selectionIdentifier.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'selectionIdentifier' is missing",
                details: nil
            )
            return
        }
        module.getCountForBarcodeInBarcodeSelectionSession(
            modeId: modeId,
            selectionIdentifier: selectionIdentifier,
            result: result
        )
    }
}
/// Resets the barcode selection session
public class ResetBarcodeSelectionSessionCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.resetBarcodeSelectionSession(
            modeId: modeId,
            result: result
        )
    }
}
/// Finish callback for barcode selection did select event
public class FinishBarcodeSelectionDidSelectCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeSelectionDidSelect(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Finish callback for barcode selection did update session event
public class FinishBarcodeSelectionDidUpdateSessionCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeSelectionDidUpdateSession(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Register persistent event listener for barcode selection events
public class RegisterBarcodeSelectionListenerForEventsCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerModeSpecificCallback(
            modeId,
            eventNames: [
                "BarcodeSelectionListener.didUpdateSelection",
                "BarcodeSelectionListener.didUpdateSession",
            ]
        )
        module.registerBarcodeSelectionListenerForEvents(
            modeId: modeId,
            result: result
        )
    }
}
/// Unregister event listener for barcode selection events
public class UnregisterBarcodeSelectionListenerForEventsCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let modeId: Int
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterModeSpecificCallback(
            modeId,
            eventNames: [
                "BarcodeSelectionListener.didUpdateSelection",
                "BarcodeSelectionListener.didUpdateSession",
            ]
        )
        module.unregisterBarcodeSelectionListenerForEvents(
            modeId: modeId,
            result: result
        )
    }
}
/// Sets the text for aim to select auto hint
public class SetTextForAimToSelectAutoHintCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let text: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.text = method.argument(key: "text") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !text.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'text' is missing", details: nil)
            return
        }
        module.setTextForAimToSelectAutoHint(
            text: text,
            result: result
        )
    }
}
/// Removes the aimed barcode brush provider
public class RemoveAimedBarcodeBrushProviderCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    public init(module: BarcodeSelectionModule) {
        self.module = module
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterCallbackForEvents([
            "BarcodeSelectionAimedBrushProvider.brushForBarcode"
        ])
        module.removeAimedBarcodeBrushProvider(
            result: result
        )
    }
}
/// Sets the aimed barcode brush provider
public class SetAimedBarcodeBrushProviderCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    public init(module: BarcodeSelectionModule) {
        self.module = module
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerCallbackForEvents([
            "BarcodeSelectionAimedBrushProvider.brushForBarcode"
        ])
        module.setAimedBarcodeBrushProvider(
            result: result
        )
    }
}
/// Finish callback for aimed barcode brush
public class FinishBrushForAimedBarcodeCallbackCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let selectionIdentifier: String
    private let brushJson: String?
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.selectionIdentifier = method.argument(key: "selectionIdentifier") ?? ""
        self.brushJson = method.argument(key: "brushJson")
    }

    public func execute(result: FrameworksResult) {
        guard !selectionIdentifier.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'selectionIdentifier' is missing",
                details: nil
            )
            return
        }
        module.finishBrushForAimedBarcodeCallback(
            selectionIdentifier: selectionIdentifier,
            brushJson: brushJson,
            result: result
        )
    }
}
/// Removes the tracked barcode brush provider
public class RemoveTrackedBarcodeBrushProviderCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    public init(module: BarcodeSelectionModule) {
        self.module = module
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterCallbackForEvents([
            "BarcodeSelectionTrackedBrushProvider.brushForBarcode"
        ])
        module.removeTrackedBarcodeBrushProvider(
            result: result
        )
    }
}
/// Sets the tracked barcode brush provider
public class SetTrackedBarcodeBrushProviderCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    public init(module: BarcodeSelectionModule) {
        self.module = module
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerCallbackForEvents([
            "BarcodeSelectionTrackedBrushProvider.brushForBarcode"
        ])
        module.setTrackedBarcodeBrushProvider(
            result: result
        )
    }
}
/// Finish callback for tracked barcode brush
public class FinishBrushForTrackedBarcodeCallbackCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let selectionIdentifier: String
    private let brushJson: String?
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.selectionIdentifier = method.argument(key: "selectionIdentifier") ?? ""
        self.brushJson = method.argument(key: "brushJson")
    }

    public func execute(result: FrameworksResult) {
        guard !selectionIdentifier.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'selectionIdentifier' is missing",
                details: nil
            )
            return
        }
        module.finishBrushForTrackedBarcodeCallback(
            selectionIdentifier: selectionIdentifier,
            brushJson: brushJson,
            result: result
        )
    }
}
/// Updates the barcode selection basic overlay configuration
public class UpdateBarcodeSelectionBasicOverlayCommand: BarcodeSelectionModuleCommand {
    private let module: BarcodeSelectionModule
    private let overlayJson: String
    public init(module: BarcodeSelectionModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.overlayJson = method.argument(key: "overlayJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !overlayJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'overlayJson' is missing",
                details: nil
            )
            return
        }
        module.updateBarcodeSelectionBasicOverlay(
            overlayJson: overlayJson,
            result: result
        )
    }
}
