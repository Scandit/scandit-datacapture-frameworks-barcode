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

/// Generated BarcodeBatchModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeBatchModule.

/// Resets the barcode batch session
public class ResetBarcodeBatchSessionCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    public init(module: BarcodeBatchModule) {
        self.module = module
    }

    public func execute(result: FrameworksResult) {
        module.resetBarcodeBatchSession(
            result: result
        )
    }
}
/// Register persistent event listener for barcode batch events
public class RegisterBarcodeBatchListenerForEventsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let modeId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerModeSpecificCallback(
            modeId,
            eventNames: [
                "BarcodeBatchListener.didUpdateSession"
            ]
        )
        module.registerBarcodeBatchListenerForEvents(
            modeId: modeId,
            result: result
        )
    }
}
/// Unregister event listener for barcode batch events
public class UnregisterBarcodeBatchListenerForEventsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let modeId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterModeSpecificCallback(
            modeId,
            eventNames: [
                "BarcodeBatchListener.didUpdateSession"
            ]
        )
        module.unregisterBarcodeBatchListenerForEvents(
            modeId: modeId,
            result: result
        )
    }
}
/// Finish callback for barcode batch did update session event
public class FinishBarcodeBatchDidUpdateSessionCallbackCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeBatchDidUpdateSessionCallback(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Sets the enabled state of the barcode batch mode
public class SetBarcodeBatchModeEnabledStateCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let modeId: Int
    private let enabled: Bool
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeId = method.argument(key: "modeId") ?? Int()
        self.enabled = method.argument(key: "enabled") ?? Bool()
    }

    public func execute(result: FrameworksResult) {
        module.setBarcodeBatchModeEnabledState(
            modeId: modeId,
            enabled: enabled,
            result: result
        )
    }
}
/// Updates the barcode batch mode configuration
public class UpdateBarcodeBatchModeCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let modeJson: String
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.modeJson = method.argument(key: "modeJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !modeJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'modeJson' is missing", details: nil)
            return
        }
        module.updateBarcodeBatchMode(
            modeJson: modeJson,
            result: result
        )
    }
}
/// Applies new settings to the barcode batch mode
public class ApplyBarcodeBatchModeSettingsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let modeId: Int
    private let modeSettingsJson: String
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
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
        module.applyBarcodeBatchModeSettings(
            modeId: modeId,
            modeSettingsJson: modeSettingsJson,
            result: result
        )
    }
}
/// Sets the brush for a tracked barcode in basic overlay
public class SetBrushForTrackedBarcodeCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    private let brushJson: String?
    private let trackedBarcodeIdentifier: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
        self.brushJson = method.argument(key: "brushJson")
        self.trackedBarcodeIdentifier = method.argument(key: "trackedBarcodeIdentifier") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.setBrushForTrackedBarcode(
            dataCaptureViewId: dataCaptureViewId,
            brushJson: brushJson,
            trackedBarcodeIdentifier: trackedBarcodeIdentifier,
            result: result
        )
    }
}
/// Clears all tracked barcode brushes in basic overlay
public class ClearTrackedBarcodeBrushesCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.clearTrackedBarcodeBrushes(
            dataCaptureViewId: dataCaptureViewId,
            result: result
        )
    }
}
/// Register persistent event listener for barcode batch basic overlay events
public class RegisterListenerForBasicOverlayEventsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerCallbackForEvents([
            "BarcodeBatchBasicOverlayListener.brushForTrackedBarcode",
            "BarcodeBatchBasicOverlayListener.didTapTrackedBarcode",
        ])
        module.registerListenerForBasicOverlayEvents(
            dataCaptureViewId: dataCaptureViewId,
            result: result
        )
    }
}
/// Unregister event listener for barcode batch basic overlay events
public class UnregisterListenerForBasicOverlayEventsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterCallbackForEvents([
            "BarcodeBatchBasicOverlayListener.brushForTrackedBarcode",
            "BarcodeBatchBasicOverlayListener.didTapTrackedBarcode",
        ])
        module.unregisterListenerForBasicOverlayEvents(
            dataCaptureViewId: dataCaptureViewId,
            result: result
        )
    }
}
/// Updates the barcode batch basic overlay configuration
public class UpdateBarcodeBatchBasicOverlayCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    private let overlayJson: String
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
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
        module.updateBarcodeBatchBasicOverlay(
            dataCaptureViewId: dataCaptureViewId,
            overlayJson: overlayJson,
            result: result
        )
    }
}
/// Sets the view for a tracked barcode in advanced overlay
public class SetViewForTrackedBarcodeCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    private let viewJson: String?
    private let trackedBarcodeIdentifier: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
        self.viewJson = method.argument(key: "viewJson")
        self.trackedBarcodeIdentifier = method.argument(key: "trackedBarcodeIdentifier") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.setViewForTrackedBarcode(
            dataCaptureViewId: dataCaptureViewId,
            viewJson: viewJson,
            trackedBarcodeIdentifier: trackedBarcodeIdentifier,
            result: result
        )
    }
}
/// Sets the view for a tracked barcode in advanced overlay using byte array
public class SetViewForTrackedBarcodeFromBytesCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    private let viewBytes: Data?
    private let trackedBarcodeIdentifier: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
        self.viewBytes = method.argument(key: "viewBytes")
        self.trackedBarcodeIdentifier = method.argument(key: "trackedBarcodeIdentifier") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.setViewForTrackedBarcodeFromBytes(
            dataCaptureViewId: dataCaptureViewId,
            viewBytes: viewBytes,
            trackedBarcodeIdentifier: trackedBarcodeIdentifier,
            result: result
        )
    }
}
/// Updates the size of a tracked barcode view in advanced overlay
public class UpdateSizeOfTrackedBarcodeViewCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let trackedBarcodeIdentifier: Int
    private let width: Int
    private let height: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.trackedBarcodeIdentifier = method.argument(key: "trackedBarcodeIdentifier") ?? Int()
        self.width = method.argument(key: "width") ?? Int()
        self.height = method.argument(key: "height") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.updateSizeOfTrackedBarcodeView(
            trackedBarcodeIdentifier: trackedBarcodeIdentifier,
            width: width,
            height: height,
            result: result
        )
    }
}
/// Sets the anchor for a tracked barcode in advanced overlay
public class SetAnchorForTrackedBarcodeCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    private let anchorJson: String
    private let trackedBarcodeIdentifier: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
        self.anchorJson = method.argument(key: "anchorJson") ?? ""
        self.trackedBarcodeIdentifier = method.argument(key: "trackedBarcodeIdentifier") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        guard !anchorJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'anchorJson' is missing",
                details: nil
            )
            return
        }
        module.setAnchorForTrackedBarcode(
            dataCaptureViewId: dataCaptureViewId,
            anchorJson: anchorJson,
            trackedBarcodeIdentifier: trackedBarcodeIdentifier,
            result: result
        )
    }
}
/// Sets the offset for a tracked barcode in advanced overlay
public class SetOffsetForTrackedBarcodeCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    private let offsetJson: String
    private let trackedBarcodeIdentifier: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
        self.offsetJson = method.argument(key: "offsetJson") ?? ""
        self.trackedBarcodeIdentifier = method.argument(key: "trackedBarcodeIdentifier") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        guard !offsetJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'offsetJson' is missing",
                details: nil
            )
            return
        }
        module.setOffsetForTrackedBarcode(
            dataCaptureViewId: dataCaptureViewId,
            offsetJson: offsetJson,
            trackedBarcodeIdentifier: trackedBarcodeIdentifier,
            result: result
        )
    }
}
/// Clears all tracked barcode views in advanced overlay
public class ClearTrackedBarcodeViewsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.clearTrackedBarcodeViews(
            dataCaptureViewId: dataCaptureViewId,
            result: result
        )
    }
}
/// Register persistent event listener for barcode batch advanced overlay events
public class RegisterListenerForAdvancedOverlayEventsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerCallbackForEvents([
            "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode",
            "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode",
            "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode",
            "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode",
        ])
        module.registerListenerForAdvancedOverlayEvents(
            dataCaptureViewId: dataCaptureViewId,
            result: result
        )
    }
}
/// Unregister event listener for barcode batch advanced overlay events
public class UnregisterListenerForAdvancedOverlayEventsCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterCallbackForEvents([
            "BarcodeBatchAdvancedOverlayListener.didTapViewForTrackedBarcode",
            "BarcodeBatchAdvancedOverlayListener.viewForTrackedBarcode",
            "BarcodeBatchAdvancedOverlayListener.anchorForTrackedBarcode",
            "BarcodeBatchAdvancedOverlayListener.offsetForTrackedBarcode",
        ])
        module.unregisterListenerForAdvancedOverlayEvents(
            dataCaptureViewId: dataCaptureViewId,
            result: result
        )
    }
}
/// Updates the barcode batch advanced overlay configuration
public class UpdateBarcodeBatchAdvancedOverlayCommand: BarcodeBatchModuleCommand {
    private let module: BarcodeBatchModule
    private let dataCaptureViewId: Int
    private let overlayJson: String
    public init(module: BarcodeBatchModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.dataCaptureViewId = method.argument(key: "dataCaptureViewId") ?? Int()
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
        module.updateBarcodeBatchAdvancedOverlay(
            dataCaptureViewId: dataCaptureViewId,
            overlayJson: overlayJson,
            result: result
        )
    }
}
