/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodeBatchModule: NSObject, FrameworkModule {
    private let barcodeBatchListener: FrameworksBarcodeBatchListener
    private let barcodeBatchBasicOverlayListener: FrameworksBarcodeBatchBasicOverlayListener
    private let barcodeBatchAdvancedOverlayListener: FrameworksBarcodeBatchAdvancedOverlayListener
    private let barcodeBatchDeserializer: BarcodeBatchDeserializer
    private let emitter: Emitter
    private let didTapViewForTrackedBarcodeEvent = Event(.didTapViewForTrackedBarcode)
    private let captureContext = DefaultFrameworksCaptureContext.shared
    private let captureViewHandler = DataCaptureViewHandler.shared

    public init(barcodeBatchListener: FrameworksBarcodeBatchListener,
                barcodeBatchBasicOverlayListener: FrameworksBarcodeBatchBasicOverlayListener,
                barcodeBatchAdvancedOverlayListener: FrameworksBarcodeBatchAdvancedOverlayListener,
                emitter: Emitter,
                barcodeBatchDeserializer: BarcodeBatchDeserializer = BarcodeBatchDeserializer()) {
        self.barcodeBatchListener = barcodeBatchListener
        self.barcodeBatchBasicOverlayListener = barcodeBatchBasicOverlayListener
        self.barcodeBatchAdvancedOverlayListener = barcodeBatchAdvancedOverlayListener
        self.barcodeBatchDeserializer = barcodeBatchDeserializer
        self.emitter = emitter
    }

    private var barcodeBatch: BarcodeBatch? {
        willSet {
            barcodeBatch?.removeListener(barcodeBatchListener)
        }
        didSet {
            barcodeBatch?.addListener(barcodeBatchListener)
        }
    }
    
    private var advancedOverlay: BarcodeBatchAdvancedOverlay? = nil
    
    private var basicOverlay: BarcodeBatchBasicOverlay? = nil

    private var advancedOverlayViewPool: AdvancedOverlayViewPool?

    private var modeEnabled = true

    // MARK: - FrameworkModule API

    public func didStart() {
        Deserializers.Factory.add(barcodeBatchDeserializer)
        self.barcodeBatchDeserializer.delegate = self
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        Deserializers.Factory.remove(barcodeBatchDeserializer)
        self.barcodeBatchDeserializer.delegate = nil
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
    }

    // MARK: - Module API exposed to the platform native modules

    public let defaults: DefaultsEncodable = BarcodeBatchDefaults.shared

    public func addBarcodeBatchListener() {
        barcodeBatchListener.enable()
    }

    public func removeBarcodeBatchListener() {
        barcodeBatchListener.disable()
    }

    public func addAsyncBarcodeBatchListener() {
        barcodeBatchListener.enableAsync()
    }

    public func removeAsyncBarcodeBatchListener() {
        barcodeBatchListener.disableAsync()
    }

    public func finishDidUpdateSession(enabled: Bool) {
        barcodeBatchListener.finishDidUpdateSession(enabled: enabled)
    }

    public func resetSession(frameSequenceId: Int?) {
        barcodeBatchListener.resetSession(with: frameSequenceId)
    }

    public func addBasicOverlayListener() {
        barcodeBatchBasicOverlayListener.enable()
    }

    public func removeBasicOverlayListener() {
        barcodeBatchBasicOverlayListener.disable()
    }

    public func clearBasicOverlayTrackedBarcodeBrushes() {
        dispatchMain {
            self.basicOverlay?.clearTrackedBarcodeBrushes()
        }
    }

    public func setBasicOverlayBrush(with brushJson: String) {
        let jsonValue = JSONValue(string: brushJson)
        let data = BrushAndTrackedBarcode(jsonValue: jsonValue)
        
        if let trackedBarcode = barcodeBatchListener.getTrackedBarcodeFromLastSession(barcodeId: data.trackedBarcodeId,
                                                                                     sessionId: data.sessionFrameSequenceId) {
            dispatchMain {
                self.basicOverlay?.setBrush(data.brush, for: trackedBarcode)
            }
        }
    }

    public func addAdvancedOverlayListener() {
        dispatchMain {
            self.barcodeBatchAdvancedOverlayListener.enable()
            self.advancedOverlayViewPool = AdvancedOverlayViewPool(
                emitter: self.barcodeBatchListener.emitter,
                didTapViewForTrackedBarcodeEvent: self.didTapViewForTrackedBarcodeEvent
            )
        }
    }

    public func removeAdvancedOverlayListener() {
        dispatchMain {
            self.barcodeBatchAdvancedOverlayListener.disable()
            self.advancedOverlayViewPool?.clear()
        }
    }

    public func clearAdvancedOverlayTrackedBarcodeViews() {
        dispatchMain {
            self.advancedOverlay?.clearTrackedBarcodeViews()
        }
    }

    public func setWidgetForTrackedBarcode(with viewParams: [String: Any?]) {
        let data = AdvancedOverlayViewData(dictionary: viewParams)
        guard let barcode = barcodeBatchListener.getTrackedBarcodeFromLastSession(barcodeId: data.trackedBarcodeId,
                                                                                     sessionId: data.sessionFrameSequenceId) else { return }
        guard let widgedData = data.widgetData else {
            advancedOverlayViewPool?.removeView(for: barcode)
            dispatchMain {
                self.advancedOverlay?.setView(nil, for: barcode)
            }
            return
        }
        guard let view = advancedOverlayViewPool?.getOrCreateView(barcode: barcode, widgetData: widgedData) else { return }
        dispatchMain {
            self.advancedOverlay?.setView(view, for: barcode)
        }
    }

    public func setViewForTrackedBarcode(view: TappableView?,
                                         trackedBarcodeId: Int,
                                         sessionFrameSequenceId: Int?) {
        guard let barcode = barcodeBatchListener.getTrackedBarcodeFromLastSession(barcodeId: trackedBarcodeId,
                                                                                     sessionId: sessionFrameSequenceId) else {
            return
        }
        view?.didTap = { [weak self] in
            guard let self = self else { return }
            self.didTapViewForTrackedBarcodeEvent.emit(
                on: self.emitter,
                payload: ["trackedBarcode": barcode.jsonString]
            )
        }
        dispatchMain {
            self.advancedOverlay?.setView(view, for: barcode)
        }
    }

    public func setAnchorForTrackedBarcode(anchorParams: [String: Any?]) {
        let data = AdvancedOverlayAnchorData(dictionary: anchorParams)
        guard let barcode = barcodeBatchListener.getTrackedBarcodeFromLastSession(barcodeId: data.trackedBarcodeId,
                                                                                     sessionId: data.sessionFrameSequenceId) else {
            return
        }
        
        dispatchMain {
            self.advancedOverlay?.setAnchor(data.anchor, for: barcode)
        }
    }

    public func setOffsetForTrackedBarcode(offsetParams: [String: Any?]) {
        let data = AdvancedOverlayOffsetData(dictionary: offsetParams)
        guard let barcode = barcodeBatchListener.getTrackedBarcodeFromLastSession(barcodeId: data.trackedBarcodeId,
                                                                                     sessionId: data.sessionFrameSequenceId) else {
            return
        }
        dispatchMain {
            self.advancedOverlay?.setOffset(data.offset, for: barcode)
        }
    }

    public func trackedBarcode(by id: Int) -> TrackedBarcode? {
        barcodeBatchListener.getTrackedBarcodeFromLastSession(barcodeId: id, sessionId: nil)
    }

    public func setModeEnabled(enabled: Bool) {
        modeEnabled = enabled
        barcodeBatch?.isEnabled = enabled
    }

    public func isModeEnabled() -> Bool {
        return barcodeBatch?.isEnabled == true
    }

    public func updateModeFromJson(modeJson: String, result: FrameworksResult) {
        guard let mode = barcodeBatch else {
            result.success(result: nil)
            return
        }
        do {
            try barcodeBatchDeserializer.updateMode(mode, fromJSONString: modeJson)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func applyModeSettings(modeSettingsJson: String, result: FrameworksResult) {
        guard let mode = barcodeBatch else {
            result.success(result: nil)
            return
        }
        do {
            let settings = try barcodeBatchDeserializer.settings(fromJSONString: modeSettingsJson)
            mode.apply(settings)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func updateBasicOverlay(overlayJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }
            
            guard let overlay: BarcodeBatchBasicOverlay = self.basicOverlay else {
                result.success(result: nil)
                return
            }
            
            do {
                try self.barcodeBatchDeserializer.update(overlay, fromJSONString: overlayJson)
                result.success(result: nil)
            } catch {
                result.reject(error: error)
            }
        }
        dispatchMain(block)
    }

    public func updateAdvancedOverlay(overlayJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }
            guard let overlay: BarcodeBatchAdvancedOverlay = self.advancedOverlay else {
                result.success(result: nil)
                return
            }
            
            do {
                try self.barcodeBatchDeserializer.update(overlay, fromJSONString: overlayJson)
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

    func onModeRemovedFromContext() {
        barcodeBatch = nil
        self.advancedOverlayViewPool?.clear()
        
        if let overlay: BarcodeBatchBasicOverlay = basicOverlay {
            captureViewHandler.removeOverlayFromTopmostView(overlay)
        }
        basicOverlay = nil
        
        if let overlay: BarcodeBatchAdvancedOverlay = advancedOverlay {
            captureViewHandler.removeOverlayFromTopmostView(overlay)
        }
        advancedOverlay = nil
    }
}

extension BarcodeBatchModule: BarcodeBatchDeserializerDelegate {
    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didStartDeserializingMode mode: BarcodeBatch,
                                            from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didFinishDeserializingMode mode: BarcodeBatch,
                                            from jsonValue: JSONValue) {
        mode.isEnabled = modeEnabled
        barcodeBatch = mode
    }

    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didStartDeserializingSettings settings: BarcodeBatchSettings,
                                            from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didFinishDeserializingSettings settings: BarcodeBatchSettings,
                                            from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didStartDeserializingBasicOverlay overlay: BarcodeBatchBasicOverlay,
                                            from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didFinishDeserializingBasicOverlay overlay: BarcodeBatchBasicOverlay,
                                            from jsonValue: JSONValue) {
        
        // keep reference so it's not garbage collected
        basicOverlay = overlay
        overlay.delegate = barcodeBatchBasicOverlayListener
    }

    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didStartDeserializingAdvancedOverlay overlay: BarcodeBatchAdvancedOverlay,
                                            from jsonValue: JSONValue) {
        // not used in frameworks
    }

    public func barcodeBatchDeserializer(_ deserializer: BarcodeBatchDeserializer,
                                            didFinishDeserializingAdvancedOverlay overlay: BarcodeBatchAdvancedOverlay,
                                            from jsonValue: JSONValue) {
        // keep reference so it's not garbage collected
        advancedOverlay = overlay
        overlay.delegate = barcodeBatchAdvancedOverlayListener
    }
}

extension BarcodeBatchModule: DeserializationLifeCycleObserver {
    public func dataCaptureContext(addMode modeJson: String) throws {
        if JSONValue(string: modeJson).string(forKey: "type") != "barcodeTracking" {
            return
        }
        
        guard let dcContext = captureContext.context else {
            return
        }

        let mode = try barcodeBatchDeserializer.mode(fromJSONString: modeJson, with: dcContext)
        captureContext.addMode(mode: mode)
    }

    public func dataCaptureContext(removeMode modeJson: String) {
        if JSONValue(string: modeJson).string(forKey: "type") != "barcodeTracking" {
            return
        }

        guard let mode = self.barcodeBatch else {
            return
        }
        captureContext.removeMode(mode: mode)
        self.onModeRemovedFromContext()
    }

    public func dataCaptureContextAllModeRemoved() {
        self.onModeRemovedFromContext()
    }

    public func didDisposeDataCaptureContext() {
        self.onModeRemovedFromContext()
    }

    public func dataCaptureView(addOverlay overlayJson: String, to view: DataCaptureView) throws {
        let overlayType = JSONValue(string: overlayJson).string(forKey: "type")
        if overlayType != "barcodeTrackingBasic" && overlayType != "barcodeTrackingAdvanced" {
            return
        }

        guard let mode = self.barcodeBatch else {
            return
        }

        try dispatchMainSync {
            let overlay: DataCaptureOverlay = (overlayType == "barcodeTrackingBasic") ?
            try barcodeBatchDeserializer.basicOverlay(fromJSONString: overlayJson, withMode: mode) :
            try barcodeBatchDeserializer.advancedOverlay(fromJSONString: overlayJson, withMode: mode)

            captureViewHandler.addOverlayToView(view: view, overlay: overlay)
        }
    }
}
