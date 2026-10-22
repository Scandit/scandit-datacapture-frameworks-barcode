/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditBarcodeCaptureDeserializer
import ScanditFrameworksCore

open class BarcodeCaptureModule: BasicFrameworkModule<FrameworksBarcodeCaptureMode> {

    private static let areListenerGroup = "adaptiveRecognitionService"

    private enum FunctionNames {
        static let finishDidScan = "finishDidScan"
        static let finishDidUpdateSession = "finishDidUpdateSession"
        static let addBarcodeCaptureListener = "addBarcodeCaptureListener"
        static let removeBarcodeCaptureListener = "removeBarcodeCaptureListener"
        static let resetBarcodeCaptureSession = "resetBarcodeCaptureSession"
        static let getLastFrameData = "getLastFrameData"
        static let getBarcodeCaptureDefaults = "getBarcodeCaptureDefaults"
        static let setModeEnabledState = "setModeEnabledState"
        static let updateBarcodeCaptureMode = "updateBarcodeCaptureMode"
        static let applyBarcodeCaptureModeSettings = "applyBarcodeCaptureModeSettings"
        static let updateBarcodeCaptureOverlay = "updateBarcodeCaptureOverlay"
        static let updateFeedback = "updateFeedback"
    }

    private let barcodeCaptureDeserializer: BarcodeCaptureDeserializer
    private let emitter: Emitter
    private let captureContext = DefaultFrameworksCaptureContext.shared
    private let captureViewHandler = DataCaptureViewHandler.shared

    private let cachedCaptureSession: AtomicValue<FrameworksBarcodeCaptureSession?> = AtomicValue(nil)

    public init(emitter: Emitter) {
        self.emitter = emitter
        self.barcodeCaptureDeserializer = BarcodeCaptureDeserializer()
    }

    // MARK: - FrameworkModule API

    private lazy var listenerAttachments: [ListenerAttachment] = [
        ModuleListenerAttachment.forMode(
            [
                "BarcodeCaptureListener.didUpdateSession",
                "BarcodeCaptureListener.didScan",
            ],
            attach: { [weak self] in
                self?.registerBarcodeCaptureListenerForEvents(modeId: $0, result: NoopFrameworksResult())
            },
            detach: { [weak self] in
                self?.unregisterBarcodeCaptureListenerForEvents(modeId: $0, result: NoopFrameworksResult())
            }
        ),
        ModuleListenerAttachment.forMode(
            Set(FrameworksBarcodeCaptureAdaptiveRecognitionEvent.allCases.map { $0.rawValue }),
            attach: { [weak self] in
                self?.registerBarcodeCaptureAdaptiveRecognitionServiceListener(
                    modeId: $0,
                    result: NoopFrameworksResult()
                )
            },
            detach: { [weak self] in
                self?.unregisterBarcodeCaptureAdaptiveRecognitionServiceListener(
                    modeId: $0,
                    result: NoopFrameworksResult()
                )
            }
        ),
    ]

    public override func didStart() {
        listenerAttachments.forEach { ListenerRegistry.shared.register(attachment: $0) }
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public override func didStop() {
        listenerAttachments.forEach { ListenerRegistry.shared.unregister(attachment: $0) }
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
    }

    // MARK: - Module API exposed to the platform native modules

    public func registerBarcodeCaptureListenerForEvents(modeId: Int, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            addPostModeCreationAction(
                modeId,
                action: {
                    self.registerBarcodeCaptureListenerForEvents(modeId: modeId, result: result)
                }
            )
            return
        }
        mode.addListener()
        rememberListenerRegistration(modeId: modeId) { [weak self] in
            self?.registerBarcodeCaptureListenerForEvents(modeId: modeId, result: NoopFrameworksResult())
        }
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeCaptureListenerForEvents(modeId: Int, result: FrameworksResult) {
        forgetListenerRegistration(modeId: modeId)
        if let mode = getModeFromCache(modeId) {
            mode.removeListener()
        }
        result.success()
    }

    public func registerBarcodeCaptureAdaptiveRecognitionServiceListener(modeId: Int, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            addPostModeCreationAction(
                modeId,
                action: {
                    self.registerBarcodeCaptureAdaptiveRecognitionServiceListener(modeId: modeId, result: result)
                }
            )
            return
        }
        mode.addAdaptiveRecognitionServiceListener()
        rememberListenerRegistration(modeId: modeId, group: BarcodeCaptureModule.areListenerGroup) { [weak self] in
            self?.registerBarcodeCaptureAdaptiveRecognitionServiceListener(
                modeId: modeId,
                result: NoopFrameworksResult()
            )
        }
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeCaptureAdaptiveRecognitionServiceListener(modeId: Int, result: FrameworksResult) {
        forgetListenerRegistration(modeId: modeId, group: BarcodeCaptureModule.areListenerGroup)
        if let mode = getModeFromCache(modeId) {
            mode.removeAdaptiveRecognitionServiceListener()
        }
        result.success()
    }

    public func finishBarcodeCaptureDidScan(modeId: Int, enabled: Bool, result: FrameworksResult) {
        if let mode = getModeFromCache(modeId) {
            mode.finishDidScan(enabled: enabled)
        }
        result.success()
    }

    public func finishBarcodeCaptureDidUpdateSession(modeId: Int, enabled: Bool, result: FrameworksResult) {
        if let mode = getModeFromCache(modeId) {
            mode.finishDidUpdateSession(enabled: enabled)
        }
        result.success()
    }

    public func resetBarcodeCaptureSession(result: FrameworksResult) {
        if let session = self.cachedCaptureSession.value {
            session.captureSession?.reset()
        }
        result.success()
    }

    public func getBarcodeCaptureLicenseInfo(modeId: Int, result: FrameworksResult) {
        result.success(result: getModeFromCache(modeId)?.licenseInfoJsonString)
    }

    public func setBarcodeCaptureModeEnabledState(modeId: Int, enabled: Bool, result: FrameworksResult) {
        getModeFromCache(modeId)?.isEnabled = enabled
        result.success()
    }

    public func isModeEnabled() -> Bool {
        getTopmostMode()?.isEnabled == true
    }

    public func updateBarcodeCaptureMode(modeJson: String, result: FrameworksResult) {
        let modeId = JSONValue(string: modeJson).integer(forKey: "modeId", default: -1)

        if modeId == -1 {
            result.reject(error: ScanditFrameworksCoreError.nilArgument)
            return
        }

        guard let mode = getModeFromCache(modeId) else {
            result.success()
            return
        }

        do {
            try mode.updateModeFromJson(modeJson: modeJson)
            result.success()
        } catch {
            result.reject(error: error)
        }
    }

    public func applyBarcodeCaptureModeSettings(modeId: Int, modeSettingsJson: String, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            result.success()
            return
        }
        do {
            try mode.applySettings(modeSettingsJson: modeSettingsJson)
            result.success()
        } catch {
            result.reject(error: error)
        }
    }

    public func updateBarcodeCaptureOverlay(viewId: Int, overlayJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }

            guard let dcView = self.captureViewHandler.getView(viewId),
                let overlay: BarcodeCaptureOverlay = dcView.findFirstOfType()
            else {
                result.success()
                return
            }

            do {
                try self.barcodeCaptureDeserializer.update(overlay, fromJSONString: overlayJson)
                result.success()
            } catch {
                result.reject(error: error)
            }
        }
        dispatchMain(block)
    }

    public func updateBarcodeCaptureFeedback(modeId: Int, feedbackJson: String, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            result.success()
            return
        }
        do {
            try mode.updateFeedback(feedbackJson: feedbackJson)
            result.success()
        } catch {
            result.reject(error: error)
        }
    }

    public func getLastFrameDataBytes(frameId: String, result: FrameworksResult) {
        LastFrameData.shared.getLastFrameDataBytes(frameId: frameId) {
            result.success(result: $0)
        }
    }

    public override func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        BarcodeCaptureModuleCommandFactory.create(module: self, method)
    }
}

extension BarcodeCaptureModule: DeserializationLifeCycleObserver {
    public func dataCaptureContext(addMode modeJson: String) throws {
        guard let dcContext = captureContext.context else {
            return
        }

        do {
            let creationParams = try BarcodeCaptureModeCreationData.fromJson(modeJson)

            if creationParams.modeType != "barcodeCapture" {
                return
            }

            let captureMode = try FrameworksBarcodeCaptureMode.create(
                emitter: emitter,
                captureContext: DefaultFrameworksCaptureContext.shared,
                creationData: creationParams,
                dataCaptureContext: dcContext,
                cachedCaptureSession: self.cachedCaptureSession
            )

            addModeToCache(modeId: creationParams.modeId, mode: captureMode)
            for action in getPostModeCreationActions(creationParams.modeId) {
                action()
            }
            let parentId = captureMode.parentId ?? -1
            for action in getPostModeCreationActionsByParent(parentId) {
                action()
            }
        } catch {
            print(error)
        }
    }

    public func dataCaptureContext(removeMode modeJson: String) {
        let json = JSONValue(string: modeJson)

        if json.string(forKey: "type") != "barcodeCapture" {
            return
        }

        let modeId = json.integer(forKey: "modeId", default: -1)

        guard let mode = getModeFromCache(modeId) else {
            return
        }
        mode.dispose()
        _ = removeModeFromCache(modeId)
        clearPostModeCreationActions(modeId)
    }

    public func dataCaptureContextAllModeRemoved() {
        for mode in getAllModesInCache() {
            mode.dispose()
        }
        removeAllModesFromCache()
        clearPostModeCreationActions(nil)
    }

    public func didDisposeDataCaptureContext() {
        self.dataCaptureContextAllModeRemoved()
    }

    public func dataCaptureView(addOverlay overlayJson: String, to view: FrameworksDataCaptureView) throws {
        let creationParams = BarcodeCaptureOverlayCreationData.fromJson(overlayJson)
        if !creationParams.isBasic {
            return
        }

        let parentId = view.parentId ?? -1

        var mode: FrameworksBarcodeCaptureMode?

        if parentId != -1 {
            mode = getModeFromCacheByParent(parentId) as? FrameworksBarcodeCaptureMode
        } else {
            mode = getModeFromCache(creationParams.modeId)
        }

        if mode == nil {
            if parentId != -1 {
                addPostModeCreationActionByParent(parentId) {
                    try? self.dataCaptureView(addOverlay: overlayJson, to: view)
                }
            } else {
                addPostModeCreationAction(creationParams.modeId) {
                    try? self.dataCaptureView(addOverlay: overlayJson, to: view)
                }
            }
            return
        }

        dispatchMain { [weak self] in
            guard let self = self else {
                return
            }

            do {
                guard let barcodeMode = mode?.mode else {
                    Log.error("Barcode capture mode is not available for overlay creation")
                    return
                }
                let overlay = try self.barcodeCaptureDeserializer.overlay(
                    fromJSONString: overlayJson,
                    withMode: barcodeMode
                )
                view.addOverlay(overlay)

            } catch {
                Log.error(error)
            }
        }
    }
}
