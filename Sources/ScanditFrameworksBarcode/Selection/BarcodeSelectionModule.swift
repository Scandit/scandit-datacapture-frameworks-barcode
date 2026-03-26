/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum BarcodeSelectionError: Error {
    case modeDoesNotExist
    case nilOverlay
}

open class BarcodeSelectionModule: BasicFrameworkModule<FrameworksBarcodeSelectionMode> {
    private let emitter: Emitter
    private var aimedBrushProviderFlag: Bool = false
    private var trackedBrushProviderFlag: Bool = false
    private let aimedBrushProvider: FrameworksBarcodeSelectionAimedBrushProvider
    private let trackedBrushProvider: FrameworksBarcodeSelectionTrackedBrushProvider
    private let barcodeSelectionDeserializer: BarcodeSelectionDeserializer
    private let captureContext = DefaultFrameworksCaptureContext.shared
    private let captureViewHandler = DataCaptureViewHandler.shared

    public init(
        emitter: Emitter,
        aimedBrushProvider: FrameworksBarcodeSelectionAimedBrushProvider,
        trackedBrushProvider: FrameworksBarcodeSelectionTrackedBrushProvider,
        barcodeSelectionDeserializer: BarcodeSelectionDeserializer = BarcodeSelectionDeserializer()
    ) {
        self.emitter = emitter
        self.aimedBrushProvider = aimedBrushProvider
        self.trackedBrushProvider = trackedBrushProvider
        self.barcodeSelectionDeserializer = barcodeSelectionDeserializer
    }

    public override func didStart() {
        Deserializers.Factory.add(barcodeSelectionDeserializer)
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public override func didStop() {
        Deserializers.Factory.remove(barcodeSelectionDeserializer)
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
        removeAimedBarcodeBrushProvider(result: NoopFrameworksResult())
        removeTrackedBarcodeBrushProvider(result: NoopFrameworksResult())
        self.dataCaptureContextAllModeRemoved()
    }

    open override func getDefaults() -> [String: Any?] {
        BarcodeSelectionDefaults.shared.toEncodable()
    }

    // MARK: - Module API

    public func registerBarcodeSelectionListenerForEvents(modeId: Int, result: FrameworksResult) {
        getModeFromCache(modeId)?.addListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeSelectionListenerForEvents(modeId: Int, result: FrameworksResult) {
        getModeFromCache(modeId)?.removeListener()
        result.success()
    }

    public func unfreezeCameraInBarcodeSelection(modeId: Int, result: FrameworksResult) {
        getModeFromCache(modeId)?.unfreezeCamera()
        result.success()
    }

    public func resetBarcodeSelection(modeId: Int, result: FrameworksResult) {
        getModeFromCache(modeId)?.resetSelection()
        result.success()
    }

    public func getCountForBarcodeInBarcodeSelectionSession(
        modeId: Int,
        selectionIdentifier: String,
        result: FrameworksResult
    ) {
        guard let mode = getModeFromCache(modeId) else {
            result.reject(error: BarcodeSelectionError.modeDoesNotExist)
            return
        }
        let count = mode.getSelectedBarcodeCount(selectionIdentifier: selectionIdentifier)
        result.success(result: count)
    }

    public func resetBarcodeSelectionSession(modeId: Int, result: FrameworksResult) {
        getModeFromCache(modeId)?.resetSession(frameSequenceId: nil)
        result.success()
    }

    public func finishBarcodeSelectionDidSelect(modeId: Int, enabled: Bool, result: FrameworksResult) {
        getModeFromCache(modeId)?.finishDidSelect(enabled: enabled)
        result.success()
    }

    public func finishBarcodeSelectionDidUpdateSession(modeId: Int, enabled: Bool, result: FrameworksResult) {
        getModeFromCache(modeId)?.finishDidUpdateSession(enabled: enabled)
        result.success()
    }

    public func increaseCountForBarcodes(modeId: Int, barcodeJson: String, result: FrameworksResult) {
        guard let selection = getModeFromCache(modeId) else {
            result.reject(error: BarcodeSelectionError.modeDoesNotExist)
            return
        }
        selection.increaseCountForBarcodesFromJsonString(barcodesJson: barcodeJson)
        result.success(result: nil)
    }

    public func setAimedBarcodeBrushProvider(result: FrameworksResult) {
        aimedBrushProviderFlag = true
        result.successAndKeepCallback(result: nil)
    }

    public func removeAimedBarcodeBrushProvider(result: FrameworksResult) {
        aimedBrushProviderFlag = false
        aimedBrushProvider.clearCache()
        if let overlay: BarcodeSelectionBasicOverlay = captureViewHandler.findFirstOverlayOfType() {
            overlay.setAimedBarcodeBrushProvider(nil)
        }
        result.success()
    }

    public func finishBrushForAimedBarcodeCallback(
        selectionIdentifier: String?,
        brushJson: String?,
        result: FrameworksResult
    ) {
        aimedBrushProvider.finishCallback(brushJson: brushJson, selectionIdentifier: selectionIdentifier)
        result.success()
    }

    public func finishBrushForTrackedBarcodeCallback(
        selectionIdentifier: String?,
        brushJson: String?,
        result: FrameworksResult
    ) {
        trackedBrushProvider.finishCallback(brushJson: brushJson, selectionIdentifier: selectionIdentifier)
        result.success()
    }

    public func setTextForAimToSelectAutoHint(text: String, result: FrameworksResult) {
        guard let overlay: BarcodeSelectionBasicOverlay = captureViewHandler.findFirstOverlayOfType() else {
            result.reject(error: BarcodeSelectionError.nilOverlay)
            return
        }
        overlay.setTextForAimToSelectAutoHint(text)
        result.success(result: nil)
    }

    public func setTrackedBarcodeBrushProvider(result: FrameworksResult) {
        trackedBrushProviderFlag = true
        result.successAndKeepCallback(result: nil)
    }

    public func removeTrackedBarcodeBrushProvider(result: FrameworksResult) {
        trackedBrushProviderFlag = false
        trackedBrushProvider.clearCache()
        if let overlay: BarcodeSelectionBasicOverlay = captureViewHandler.findFirstOverlayOfType() {
            overlay.setTrackedBarcodeBrushProvider(nil)
        }
        result.success()
    }

    public func selectAimedBarcode(modeId: Int, result: FrameworksResult) {
        getModeFromCache(modeId)?.selectAimedBarcode()
        result.success()
    }

    public func unselectBarcodes(modeId: Int, barcodesJson: String, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            result.reject(error: BarcodeSelectionError.modeDoesNotExist)
            return
        }
        mode.unselectBarcodesFromJsonString(barcodesJson: barcodesJson)
        result.success(result: nil)
    }

    public func setSelectBarcodeEnabled(modeId: Int, barcodeJson: String, enabled: Bool, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            result.reject(error: BarcodeSelectionError.modeDoesNotExist)
            return
        }
        mode.setSelectBarcodeEnabledFromJsonString(barcodesJson: barcodeJson, enabled: enabled)
        result.success(result: nil)
    }

    public func setBarcodeSelectionModeEnabledState(modeId: Int, enabled: Bool, result: FrameworksResult) {
        getModeFromCache(modeId)?.isEnabled = enabled
        result.success()
    }

    public func isTopmostModeEnabled() -> Bool {
        getTopmostMode()?.isEnabled == true
    }

    public func setTopmostModeEnabled(enabled: Bool) {
        getTopmostMode()?.isEnabled = enabled
    }

    public func updateBarcodeSelectionMode(modeId: Int, modeJson: String, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            result.success(result: nil)
            return
        }
        do {
            try mode.updateModeFromJson(modeJson: modeJson)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func applyBarcodeSelectionModeSettings(modeId: Int, modeSettingsJson: String, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            result.success(result: nil)
            return
        }
        do {
            try mode.applySettings(modeSettingsJson: modeSettingsJson)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func updateBarcodeSelectionFeedback(modeId: Int, feedbackJson: String, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            result.success(result: nil)
            return
        }

        do {
            mode.updateFeedback(feedback: try BarcodeSelectionFeedback(fromJSONString: feedbackJson))
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func updateBarcodeSelectionBasicOverlay(overlayJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }
            guard let overlay: BarcodeSelectionBasicOverlay = self.captureViewHandler.findFirstOverlayOfType() else {
                result.success(result: nil)
                return
            }

            do {
                try self.barcodeSelectionDeserializer.update(overlay, fromJSONString: overlayJson)
                result.success(result: nil)
            } catch {
                result.reject(error: error)
            }
        }
        dispatchMain(block)
    }

    public func getLastFrameDataBytes(frameId: String, result: FrameworksResult) {
        LastFrameData.shared.getLastFrameDataBytes(frameId: frameId) {
            result.success(result: $0)
        }
    }

    public override func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        BarcodeSelectionModuleCommandFactory.create(module: self, method)
    }
}

extension BarcodeSelectionModule: DeserializationLifeCycleObserver {
    public func dataCaptureContext(addMode modeJson: String) throws {
        let creationParams = BarcodeSelectionModeCreationData.fromJson(modeJson)
        if creationParams.modeType != "barcodeSelection" {
            return
        }
        guard let dcContext = self.captureContext.context else {
            Log.error("Unable to add the barcode selection mode to the context. DataCaptureContext is nil.")
            return
        }
        do {
            let selectionMode = try FrameworksBarcodeSelectionMode.create(
                emitter: emitter,
                captureContext: captureContext,
                creationData: creationParams,
                dataCaptureContext: dcContext,
                deserializer: barcodeSelectionDeserializer
            )

            addModeToCache(modeId: creationParams.modeId, mode: selectionMode)

            for action in getPostModeCreationActions(creationParams.modeId) {
                action()
            }
            let parentId = selectionMode.parentId ?? -1
            for action in getPostModeCreationActionsByParent(parentId) {
                action()
            }
        } catch {
            Log.error("Unable to add the barcode selection mode to the context.", error: error)
        }
    }

    public func dataCaptureContext(removeMode modeJson: String) {
        let json = JSONValue(string: modeJson)
        if json.string(forKey: "type") != "barcodeSelection" {
            return
        }
        let modeId = json.integer(forKey: "modeId")

        guard let mode = self.removeModeFromCache(modeId) else {
            return
        }
        mode.dispose()
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
        let creationParams = BarcodeSelectionOverlayCreationData.create(overlayJson: overlayJson)

        if creationParams.isValidBasicOverlayType == false {
            return
        }

        let parentId = view.parentId ?? -1

        var mode: FrameworksBarcodeSelectionMode?

        if parentId != -1 {
            mode = getModeFromCacheByParent(parentId) as? FrameworksBarcodeSelectionMode
        } else {
            mode = getModeFromCache(creationParams.modeId)
        }

        guard let frameworksMode = mode else {
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
                let overlay = try self.barcodeSelectionDeserializer.basicOverlay(
                    fromJSONString: overlayJson,
                    withMode: frameworksMode.mode
                )
                self.updateOverlayProps(overlay: overlay, creationParams: creationParams)
                view.addOverlay(overlay)
            } catch {
                Log.error("Error adding the barcode selection basic overlay", error: error)
            }
        }
    }

    private func updateOverlayProps(
        overlay: BarcodeSelectionBasicOverlay,
        creationParams: BarcodeSelectionOverlayCreationData
    ) {
        if creationParams.hasAimedBrushProvider {
            overlay.setAimedBarcodeBrushProvider(aimedBrushProvider)
        } else {
            overlay.setAimedBarcodeBrushProvider(nil)
        }
        if creationParams.hasTrackedBrushProvider {
            overlay.setTrackedBarcodeBrushProvider(trackedBrushProvider)
        } else {
            overlay.setTrackedBarcodeBrushProvider(nil)
        }
        if let textForSelectOrDoubleTapToFreezeHint = creationParams.textForSelectOrDoubleTapToFreezeHint {
            overlay.setTextForSelectOrDoubleTapToFreezeHint(textForSelectOrDoubleTapToFreezeHint)
        }
        if let textForTapToSelectHint = creationParams.textForTapToSelectHint {
            overlay.setTextForTapToSelectHint(textForTapToSelectHint)
        }
        if let textForDoubleTapToUnfreezeHint = creationParams.textForDoubleTapToUnfreezeHint {
            overlay.setTextForDoubleTapToUnfreezeHint(textForDoubleTapToUnfreezeHint)
        }
        if let textForTapAnywhereToSelectHint = creationParams.textForTapAnywhereToSelectHint {
            overlay.setTextForTapAnywhereToSelectHint(textForTapAnywhereToSelectHint)
        }
        if let textForAimToSelectAutoHint = creationParams.textForAimToSelectAutoHint {
            overlay.setTextForAimToSelectAutoHint(textForAimToSelectAutoHint)
        }
    }
}
