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

/// Generated BarcodeArModule command implementations.
/// Each command extracts parameters in its initializer and executes via BarcodeArModule.

/// Register persistent event listener for BarcodeAr view UI events
public class RegisterBarcodeArViewUiListenerCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArViewUiListener.didTapHighlightForBarcode"
            ]
        )
        module.registerBarcodeArViewUiListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeAr view UI events
public class UnregisterBarcodeArViewUiListenerCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArViewUiListener.didTapHighlightForBarcode"
            ]
        )
        module.unregisterBarcodeArViewUiListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeAr annotation provider events
public class RegisterBarcodeArAnnotationProviderCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArAnnotationProvider.annotationForBarcode",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationRightIcon",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationLeftIcon",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotation",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationHeader",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationFooter",
                "BarcodeArPopoverAnnotationListener.didTapPopover",
                "BarcodeArPopoverAnnotationListener.didTapPopoverButton",
            ]
        )
        module.registerBarcodeArAnnotationProvider(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeAr annotation provider events
public class UnregisterBarcodeArAnnotationProviderCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArAnnotationProvider.annotationForBarcode",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationRightIcon",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationLeftIcon",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotation",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationHeader",
                "BarcodeArInfoAnnotationListener.didTapInfoAnnotationFooter",
                "BarcodeArPopoverAnnotationListener.didTapPopover",
                "BarcodeArPopoverAnnotationListener.didTapPopoverButton",
            ]
        )
        module.unregisterBarcodeArAnnotationProvider(
            viewId: viewId,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeAr highlight provider events
public class RegisterBarcodeArHighlightProviderCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArHighlightProvider.highlightForBarcode"
            ]
        )
        module.registerBarcodeArHighlightProvider(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeAr highlight provider events
public class UnregisterBarcodeArHighlightProviderCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArHighlightProvider.highlightForBarcode"
            ]
        )
        module.unregisterBarcodeArHighlightProvider(
            viewId: viewId,
            result: result
        )
    }
}
/// Handles custom highlight click event
public class OnCustomHighlightClickedCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let barcodeId: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.barcodeId = method.argument(key: "barcodeId") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !barcodeId.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'barcodeId' is missing", details: nil)
            return
        }
        module.onCustomHighlightClicked(
            viewId: viewId,
            barcodeId: barcodeId,
            result: result
        )
    }
}
/// Starts the BarcodeAr view
public class BarcodeArViewStartCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeArViewStart(
            viewId: viewId,
            result: result
        )
    }
}
/// Stops the BarcodeAr view
public class BarcodeArViewStopCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeArViewStop(
            viewId: viewId,
            result: result
        )
    }
}
/// Pauses the BarcodeAr view
public class BarcodeArViewPauseCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeArViewPause(
            viewId: viewId,
            result: result
        )
    }
}
/// Resets the BarcodeAr view
public class BarcodeArViewResetCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.barcodeArViewReset(
            viewId: viewId,
            result: result
        )
    }
}
/// Updates the BarcodeAr view configuration
public class UpdateBarcodeArViewCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let viewJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.viewJson = method.argument(key: "viewJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !viewJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'viewJson' is missing", details: nil)
            return
        }
        module.updateBarcodeArView(
            viewId: viewId,
            viewJson: viewJson,
            result: result
        )
    }
}
/// Finish callback for BarcodeAr annotation for barcode
public class FinishBarcodeArAnnotationForBarcodeCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let annotationJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.annotationJson = method.argument(key: "annotationJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !annotationJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'annotationJson' is missing",
                details: nil
            )
            return
        }
        module.finishBarcodeArAnnotationForBarcode(
            viewId: viewId,
            annotationJson: annotationJson,
            result: result
        )
    }
}
/// Finish callback for BarcodeAr highlight for barcode
public class FinishBarcodeArHighlightForBarcodeCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let highlightJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.highlightJson = method.argument(key: "highlightJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !highlightJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'highlightJson' is missing",
                details: nil
            )
            return
        }
        module.finishBarcodeArHighlightForBarcode(
            viewId: viewId,
            highlightJson: highlightJson,
            result: result
        )
    }
}
/// Updates the BarcodeAr highlight
public class UpdateBarcodeArHighlightCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let highlightJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.highlightJson = method.argument(key: "highlightJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !highlightJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'highlightJson' is missing",
                details: nil
            )
            return
        }
        module.updateBarcodeArHighlight(
            viewId: viewId,
            highlightJson: highlightJson,
            result: result
        )
    }
}
/// Updates the BarcodeAr annotation
public class UpdateBarcodeArAnnotationCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let annotationJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.annotationJson = method.argument(key: "annotationJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !annotationJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'annotationJson' is missing",
                details: nil
            )
            return
        }
        module.updateBarcodeArAnnotation(
            viewId: viewId,
            annotationJson: annotationJson,
            result: result
        )
    }
}
/// Updates the BarcodeAr popover button at specific index
public class UpdateBarcodeArPopoverButtonAtIndexCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let updateJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.updateJson = method.argument(key: "updateJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !updateJson.isEmpty else {
            result.reject(
                code: "MISSING_PARAMETER",
                message: "Required parameter 'updateJson' is missing",
                details: nil
            )
            return
        }
        module.updateBarcodeArPopoverButtonAtIndex(
            viewId: viewId,
            updateJson: updateJson,
            result: result
        )
    }
}
/// Applies BarcodeAr settings
public class ApplyBarcodeArSettingsCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let settings: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.settings = method.argument(key: "settings") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !settings.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'settings' is missing", details: nil)
            return
        }
        module.applyBarcodeArSettings(
            viewId: viewId,
            settings: settings,
            result: result
        )
    }
}
/// Updates the BarcodeAr mode configuration
public class UpdateBarcodeArModeCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let modeJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
        self.modeJson = method.argument(key: "modeJson") ?? ""
    }

    public func execute(result: FrameworksResult) {
        guard !modeJson.isEmpty else {
            result.reject(code: "MISSING_PARAMETER", message: "Required parameter 'modeJson' is missing", details: nil)
            return
        }
        module.updateBarcodeArMode(
            viewId: viewId,
            modeJson: modeJson,
            result: result
        )
    }
}
/// Updates the BarcodeAr feedback configuration
public class UpdateBarcodeArFeedbackCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    private let feedbackJson: String
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
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
        module.updateBarcodeArFeedback(
            viewId: viewId,
            feedbackJson: feedbackJson,
            result: result
        )
    }
}
/// Register persistent event listener for BarcodeAr mode events
public class RegisterBarcodeArListenerCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.registerViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArListener.didUpdateSession"
            ]
        )
        module.registerBarcodeArListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Unregister event listener for BarcodeAr mode events
public class UnregisterBarcodeArListenerCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        // Register/unregister event callbacks
        result.unregisterViewSpecificCallback(
            viewId,
            eventNames: [
                "BarcodeArListener.didUpdateSession"
            ]
        )
        module.unregisterBarcodeArListener(
            viewId: viewId,
            result: result
        )
    }
}
/// Finish callback for BarcodeAr did update session event
public class FinishBarcodeArOnDidUpdateSessionCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.finishBarcodeArOnDidUpdateSession(
            viewId: viewId,
            result: result
        )
    }
}
/// Resets the BarcodeAr session
public class ResetBarcodeArSessionCommand: BarcodeArModuleCommand {
    private let module: BarcodeArModule
    private let viewId: Int
    public init(module: BarcodeArModule, _ method: FrameworksMethodCall) {
        self.module = module
        self.viewId = method.argument(key: "viewId") ?? Int()
    }

    public func execute(result: FrameworksResult) {
        module.resetBarcodeArSession(
            viewId: viewId,
            result: result
        )
    }
}
