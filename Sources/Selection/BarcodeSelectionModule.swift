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

open class BarcodeSelectionModule: NSObject, FrameworkModule {
    private let barcodeSelectionListener: FrameworksBarcodeSelectionListener
    private var aimedBrushProviderFlag: Bool = false
    private var trackedBrushProviderFlag: Bool = false
    private let aimedBrushProvider: FrameworksBarcodeSelectionAimedBrushProvider
    private let trackedBrushProvider: FrameworksBarcodeSelectionTrackedBrushProvider
    private let barcodeSelectionDeserializer: BarcodeSelectionDeserializer
    private let captureContext = DefaultFrameworksCaptureContext.shared
    private let captureViewHandler = DataCaptureViewHandler.shared
    
    private var modeEnabled = true

    private var barcodeSelection: BarcodeSelection? {
        willSet {
            barcodeSelection?.removeListener(barcodeSelectionListener)
        }
        didSet {
            barcodeSelection?.addListener(barcodeSelectionListener)
        }
    }

    public init(barcodeSelectionListener: FrameworksBarcodeSelectionListener,
                aimedBrushProvider: FrameworksBarcodeSelectionAimedBrushProvider,
                trackedBrushProvider: FrameworksBarcodeSelectionTrackedBrushProvider,
                barcodeSelectionDeserializer: BarcodeSelectionDeserializer = BarcodeSelectionDeserializer()) {
        self.barcodeSelectionListener = barcodeSelectionListener
        self.aimedBrushProvider = aimedBrushProvider
        self.trackedBrushProvider = trackedBrushProvider
        self.barcodeSelectionDeserializer = barcodeSelectionDeserializer
    }

    public func didStart() {
        Deserializers.Factory.add(barcodeSelectionDeserializer)
        self.barcodeSelectionDeserializer.delegate = self
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        Deserializers.Factory.remove(barcodeSelectionDeserializer)
        self.barcodeSelectionDeserializer.delegate = nil
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
        removeAimedBarcodeBrushProvider()
        removeTrackedBarcodeBrushProvider()
    }

    // MARK: - Module API

    public let defaults: DefaultsEncodable = BarcodeSelectionDefaults.shared

    public func addListener() {
        barcodeSelectionListener.enable()
    }

    public func removeListener() {
        barcodeSelectionListener.disable()
    }
    
    public func addAsyncListener() {
        barcodeSelectionListener.enableAsync()
    }

    public func removeAsyncListener() {
        barcodeSelectionListener.disableAsync()
    }

    public func unfreezeCamera() {
        barcodeSelection?.unfreezeCamera()
    }

    public func resetSelection() {
        barcodeSelection?.reset()
    }

    public func submitBarcodeCountForIdentifier(selectionIdentifier: String, result: FrameworksResult) {
        let count = barcodeSelectionListener.getBarcodeCount(selectionIdentifier: selectionIdentifier)
        result.success(result: count)
    }

    public func resetLatestSession(frameSequenceId: Int?) {
        barcodeSelectionListener.resetSession(frameSequenceId: frameSequenceId)
    }

    public func finishDidSelect(enabled: Bool) {
        barcodeSelectionListener.finishDidSelect(enabled: enabled)
    }

    public func finishDidUpdate(enabled: Bool) {
        barcodeSelectionListener.finishDidUpdate(enabled: enabled)
    }

    public func increaseCountForBarcodes(barcodesJson: String, result: FrameworksResult) {
        guard let selection = barcodeSelection else {
            result.reject(error: BarcodeSelectionError.modeDoesNotExist)
            return
        }
        selection.increaseCountForBarcodes(fromJsonString: barcodesJson)
        result.success(result: nil)
    }

    public func setAimedBrushProvider(result: FrameworksResult) {
        aimedBrushProviderFlag = true
        result.success(result: nil)
    }

    public func removeAimedBarcodeBrushProvider() {
        aimedBrushProviderFlag = false
        aimedBrushProvider.clearCache()
        if let overlay: BarcodeSelectionBasicOverlay = captureViewHandler.findFirstOverlayOfType() {
            overlay.setAimedBarcodeBrushProvider(nil)
        }
    }

    public func finishBrushForAimedBarcode(brushJson: String?, selectionIdentifier: String?) {
        aimedBrushProvider.finishCallback(brushJson: brushJson, selectionIdentifier: selectionIdentifier)
    }

    public func finishBrushForTrackedBarcode(brushJson: String?, selectionIdentifier: String?) {
        trackedBrushProvider.finishCallback(brushJson: brushJson, selectionIdentifier: selectionIdentifier)
    }

    public func setTextForAimToSelectAutoHint(text:String, result: FrameworksResult) {
        guard let overlay: BarcodeSelectionBasicOverlay = captureViewHandler.findFirstOverlayOfType()  else {
            result.reject(error: BarcodeSelectionError.nilOverlay)
            return
        }
        overlay.setTextForAimToSelectAutoHint(text)
        result.success(result: nil)
    }
    
    public func setTrackedBrushProvider(result: FrameworksResult) {
        trackedBrushProviderFlag = true
        result.success(result: nil)
    }

    public func removeTrackedBarcodeBrushProvider() {
        trackedBrushProviderFlag = false
        trackedBrushProvider.clearCache()
        if let overlay: BarcodeSelectionBasicOverlay = captureViewHandler.findFirstOverlayOfType() {
            overlay.setTrackedBarcodeBrushProvider(nil)
        }
    }

    public func selectAimedBarcode() {
        barcodeSelection?.selectAimedBarcode()
    }

    public func unselectBarcodes(barcodesJson: String, result: FrameworksResult) {
        guard let mode = barcodeSelection else {
            result.reject(error: BarcodeSelectionError.modeDoesNotExist)
            return
        }
        mode.unselectBarcodes(fromJsonString: barcodesJson)
        result.success(result: nil)
    }

    public func setSelectBarcodeEnabled(barcodesJson: String, enabled: Bool, result: FrameworksResult) {
        guard let mode = barcodeSelection else {
            result.reject(error: BarcodeSelectionError.modeDoesNotExist)
            return
        }
        mode.setSelectBarcodeFromJsonString(barcodesJson, enabled: enabled)
        result.success(result: nil)
    }
    
    public func setModeEnabled(enabled: Bool) {
        modeEnabled = enabled
        barcodeSelection?.isEnabled = enabled
    }
    
    public func isModeEnabled() -> Bool {
        return barcodeSelection?.isEnabled == true
    }
    
    public func updateModeFromJson(modeJson: String, result: FrameworksResult) {
        guard let mode = barcodeSelection else {
            result.success(result: nil)
            return
        }
        do {
            try barcodeSelectionDeserializer.updateMode(mode, fromJSONString: modeJson)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func applyModeSettings(modeSettingsJson: String, result: FrameworksResult) {
        guard let mode = barcodeSelection else {
            result.success(result: nil)
            return
        }
        do {
            let settings = try barcodeSelectionDeserializer.settings(fromJSONString: modeSettingsJson)
            mode.apply(settings)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }
    
    public func updateFeedback(feedbackJson: String, result: FrameworksResult) {
        do {
            barcodeSelection?.feedback = try BarcodeSelectionFeedback(fromJSONString: feedbackJson)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }
    
    private func onModeRemovedFromContext() {
        barcodeSelection = nil
        
        if let overlay: BarcodeSelectionBasicOverlay = captureViewHandler.findFirstOverlayOfType() {
            captureViewHandler.topmostDataCaptureView?.removeOverlay(overlay)
        }
    }
    
    public func updateBasicOverlay(overlayJson: String, result: FrameworksResult) {
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
}

extension BarcodeSelectionModule: BarcodeSelectionDeserializerDelegate {
    public func barcodeSelectionDeserializer(_ deserializer: BarcodeSelectionDeserializer,
                                             didStartDeserializingMode mode: BarcodeSelection,
                                             from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeSelectionDeserializer(_ deserializer: BarcodeSelectionDeserializer,
                                             didFinishDeserializingMode mode: BarcodeSelection,
                                             from jsonValue: JSONValue) {
        mode.isEnabled = modeEnabled
        barcodeSelection = mode
    }

    public func barcodeSelectionDeserializer(_ deserializer: BarcodeSelectionDeserializer,
                                             didStartDeserializingSettings settings: BarcodeSelectionSettings,
                                             from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeSelectionDeserializer(_ deserializer: BarcodeSelectionDeserializer,
                                             didFinishDeserializingSettings settings: BarcodeSelectionSettings,
                                             from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeSelectionDeserializer(_ deserializer: BarcodeSelectionDeserializer,
                                             didStartDeserializingBasicOverlay overlay: BarcodeSelectionBasicOverlay,
                                             from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeSelectionDeserializer(_ deserializer: BarcodeSelectionDeserializer,
                                             didFinishDeserializingBasicOverlay overlay: BarcodeSelectionBasicOverlay,
                                             from jsonValue: JSONValue) {

        if trackedBrushProviderFlag {
            overlay.setTrackedBarcodeBrushProvider(trackedBrushProvider)
        }
        
        if aimedBrushProviderFlag {
            overlay.setAimedBarcodeBrushProvider(aimedBrushProvider)
        }
        
        if jsonValue.containsKey("textForSelectOrDoubleTapToFreezeHint") {
            overlay.setTextForSelectOrDoubleTapToFreezeHint(jsonValue.string(forKey: "textForSelectOrDoubleTapToFreezeHint", default: ""))
        }
        
        if jsonValue.containsKey("textForTapToSelectHint") {
            overlay.setTextForTapToSelectHint(jsonValue.string(forKey: "textForTapToSelectHint", default: ""))
        }
        
        if jsonValue.containsKey("textForDoubleTapToUnfreezeHint") {
            overlay.setTextForDoubleTapToUnfreezeHint(jsonValue.string(forKey: "textForDoubleTapToUnfreezeHint", default: ""))
        }
        
        if jsonValue.containsKey("textForTapAnywhereToSelectHint") {
            overlay.setTextForTapAnywhereToSelectHint(jsonValue.string(forKey: "textForTapAnywhereToSelectHint", default: ""))
        }
        
        if jsonValue.containsKey("textForAimToSelectAutoHint") {
            overlay.setTextForAimToSelectAutoHint(jsonValue.string(forKey: "textForAimToSelectAutoHint", default: ""))
        }
    }
}


extension BarcodeSelectionModule: DeserializationLifeCycleObserver {    
    public func dataCaptureContext(addMode modeJson: String) throws {
        if  JSONValue(string: modeJson).string(forKey: "type") != "barcodeSelection" {
            return
        }

        guard let dcContext = self.captureContext.context else {
            return
        }

        let mode = try barcodeSelectionDeserializer.mode(fromJSONString: modeJson, with: dcContext)
        captureContext.addMode(mode: mode)
    }
    
    public func dataCaptureContext(removeMode modeJson: String) {
        if  JSONValue(string: modeJson).string(forKey: "type") != "barcodeSelection" {
            return
        }
        
        guard let mode = self.barcodeSelection else {
            return
        }
        captureContext.removeMode(mode: mode)
        self.barcodeSelection = nil
    }
    
    public func dataCaptureContextAllModeRemoved() {
        self.onModeRemovedFromContext()
    }
    
    public func didDisposeDataCaptureContext() {
        self.onModeRemovedFromContext()
    }
    
    public func dataCaptureView(addOverlay overlayJson: String, to view: FrameworksDataCaptureView) throws {
        if  JSONValue(string: overlayJson).string(forKey: "type") != "barcodeSelectionBasic" {
            return
        }
        
        guard let mode = self.barcodeSelection else {
            return
        }
        
        try dispatchMainSync {
            let overlay = try barcodeSelectionDeserializer.basicOverlay(fromJSONString: overlayJson, withMode: mode)
            view.addOverlay(overlay)
        }
    }
}

