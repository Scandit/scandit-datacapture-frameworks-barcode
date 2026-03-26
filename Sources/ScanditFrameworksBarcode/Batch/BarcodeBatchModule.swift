/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodeBatchModule: BasicFrameworkModule<FrameworksBarcodeBatchMode> {
    private let barcodeBatchBasicOverlayListener: FrameworksBarcodeBatchBasicOverlayListener
    private let barcodeBatchAdvancedOverlayListener: FrameworksBarcodeBatchAdvancedOverlayListener
    private let barcodeBatchDeserializer: BarcodeBatchDeserializer
    private let emitter: Emitter
    private let didTapViewForTrackedBarcodeEvent = Event(.didTapViewForTrackedBarcode)
    private let captureContext = DefaultFrameworksCaptureContext.shared
    private let captureViewHandler = DataCaptureViewHandler.shared
    private let viewFromJsonResolver: ViewFromJsonResolver

    // Cached session
    private let cachedBatchSession: AtomicValue<FrameworksBarcodeBatchSession?> = AtomicValue(nil)

    public init(emitter: Emitter, viewFromJsonResolver: ViewFromJsonResolver?) {
        self.emitter = emitter
        self.barcodeBatchBasicOverlayListener = FrameworksBarcodeBatchBasicOverlayListener(emitter: emitter)
        self.barcodeBatchAdvancedOverlayListener = FrameworksBarcodeBatchAdvancedOverlayListener(emitter: emitter)
        self.viewFromJsonResolver = viewFromJsonResolver ?? DefaultViewFromJsonResolver()
        self.barcodeBatchDeserializer = BarcodeBatchDeserializer()
    }

    private var advancedOverlayViewPool: AdvancedOverlayViewCache?

    // MARK: - FrameworkModule API

    public override func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public override func didStop() {
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
    }

    open override func getDefaults() -> [String: Any?] {
        BarcodeBatchDefaults.shared.toEncodable()
    }

    // MARK: - Module API exposed to the platform native modules

    public func registerBarcodeBatchListenerForEvents(modeId: Int, result: FrameworksResult) {
        guard let mode = getModeFromCache(modeId) else {
            addPostModeCreationAction(
                modeId,
                action: {
                    self.registerBarcodeBatchListenerForEvents(modeId: modeId, result: result)
                }
            )
            return
        }
        mode.addListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeBatchListenerForEvents(modeId: Int, result: FrameworksResult) {
        if let mode = getModeFromCache(modeId) {
            mode.removeListener()
        }
        result.success()
    }

    public func finishBarcodeBatchDidUpdateSessionCallback(modeId: Int, enabled: Bool, result: FrameworksResult) {
        if let mode = getModeFromCache(modeId) {
            mode.finishDidUpdateSession(enabled: enabled)
        }
        result.success()
    }

    public func resetBarcodeBatchSession(result: FrameworksResult) {
        if let session = self.cachedBatchSession.value {
            session.batchSession?.reset()
        }
        result.success()
    }

    public func registerListenerForBasicOverlayEvents(dataCaptureViewId: Int, result: FrameworksResult) {
        if let dcView = self.captureViewHandler.getView(dataCaptureViewId),
            let overlay: BarcodeBatchBasicOverlay = dcView.findFirstOfType()
        {
            overlay.delegate = barcodeBatchBasicOverlayListener
        }
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterListenerForBasicOverlayEvents(dataCaptureViewId: Int, result: FrameworksResult) {
        if let dcView = self.captureViewHandler.getView(dataCaptureViewId),
            let overlay: BarcodeBatchBasicOverlay = dcView.findFirstOfType()
        {
            overlay.delegate = nil
        }
    }

    public func clearTrackedBarcodeBrushes(dataCaptureViewId: Int, result: FrameworksResult) {
        dispatchMain {
            if let dcView = self.captureViewHandler.getView(dataCaptureViewId),
                let overlay: BarcodeBatchBasicOverlay = dcView.findFirstOfType()
            {
                overlay.clearTrackedBarcodeBrushes()
            }
            result.success()
        }
    }

    public func setBrushForTrackedBarcode(
        dataCaptureViewId: Int,
        brushJson: String?,
        trackedBarcodeIdentifier: Int,
        result: FrameworksResult
    ) {
        let brush = brushJson.flatMap { Brush(jsonString: $0) }
        if let trackedBarcode = trackedBarcode(by: trackedBarcodeIdentifier) {
            dispatchMain {
                if let dcView = self.captureViewHandler.getView(dataCaptureViewId),
                    let overlay: BarcodeBatchBasicOverlay = dcView.findFirstOfType()
                {
                    overlay.setBrush(brush, for: trackedBarcode)
                }
            }
        }
        result.success()
    }

    public func registerListenerForAdvancedOverlayEvents(dataCaptureViewId: Int, result: FrameworksResult) {
        dispatchMain {
            if let dcView = self.captureViewHandler.getView(dataCaptureViewId),
                let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
            {
                overlay.delegate = self.barcodeBatchAdvancedOverlayListener
            }
            self.advancedOverlayViewPool = DefaultAdvancedOverlayViewCache()
            result.successAndKeepCallback(result: nil)
        }
    }

    public func unregisterListenerForAdvancedOverlayEvents(dataCaptureViewId: Int, result: FrameworksResult) {
        dispatchMain {
            if let dcView = self.captureViewHandler.getView(dataCaptureViewId),
                let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
            {
                overlay.delegate = nil
            }
            self.advancedOverlayViewPool?.clear()
            result.success()
        }
    }

    public func clearTrackedBarcodeViews(dataCaptureViewId: Int, result: FrameworksResult) {
        dispatchMain {
            if let dcView = self.captureViewHandler.getView(dataCaptureViewId),
                let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
            {
                overlay.clearTrackedBarcodeViews()
            }
            result.success()
        }
    }

    private func addTapGestureRecognizer(to view: UIView, for trackedBarcode: TrackedBarcode) {
        let tapRecognizer = TapGestureRecognizerWithClosure { [weak self] in
            guard let self = self else { return }
            self.didTapViewForTrackedBarcodeEvent.emit(
                on: self.emitter,
                payload: ["trackedBarcode": trackedBarcode.jsonString]
            )
        }
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapRecognizer)
    }

    public func setViewForTrackedBarcode(
        dataCaptureViewId: Int,
        viewJson: String?,
        trackedBarcodeIdentifier: Int,
        result: FrameworksResult
    ) {
        guard let dcView = self.captureViewHandler.getView(dataCaptureViewId),
            let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
        else {
            result.success()
            return
        }

        guard let barcode = trackedBarcode(by: trackedBarcodeIdentifier) else {
            result.success()
            return
        }
        guard let viewJson = viewJson else {
            advancedOverlayViewPool?.removeView(withIdentifier: String(barcode.identifier))
            dispatchMain {
                overlay.setView(nil, for: barcode)
            }
            result.success()
            return
        }
        dispatchMain { [weak self] in
            guard let self = self else {
                result.success()
                return
            }

            guard let view = self.viewFromJsonResolver.getView(viewJson: viewJson) else {
                result.success()
                return
            }
            self.addTapGestureRecognizer(to: view, for: barcode)
            self.advancedOverlayViewPool?.addToCache(viewIdentifier: String(barcode.identifier), view: view)

            overlay.setView(view, for: barcode)
        }
    }

    public func setViewForTrackedBarcodeFromBytes(
        dataCaptureViewId: Int,
        viewBytes: Data?,
        trackedBarcodeIdentifier: Int,
        result: FrameworksResult
    ) {
        guard let dcView = self.captureViewHandler.getView(dataCaptureViewId),
            let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
        else {
            result.success()
            return
        }

        guard let barcode = trackedBarcode(by: trackedBarcodeIdentifier) else {
            result.success()
            return
        }
        guard let widgedData = viewBytes else {
            advancedOverlayViewPool?.removeView(withIdentifier: String(barcode.identifier))
            dispatchMain {
                overlay.setView(nil, for: barcode)
            }
            return
        }
        dispatchMain { [weak self] in
            guard let self = self else {
                return
            }

            guard
                let view = self.advancedOverlayViewPool?.getOrCreateView(
                    fromBase64EncodedData: widgedData,
                    withIdentifier: String(barcode.identifier)
                )
            else { return }
            self.addTapGestureRecognizer(to: view, for: barcode)

            overlay.setView(view, for: barcode)
        }
    }

    public func updateSizeOfTrackedBarcodeView(
        trackedBarcodeIdentifier: Int,
        width: Int,
        height: Int,
        result: FrameworksResult
    ) {
        guard
            let view = advancedOverlayViewPool?.getView(viewIdentifier: String(trackedBarcodeIdentifier))
                as? TappableView
        else {
            result.reject(
                code: "-1",
                message: "View for tracked barcode \(trackedBarcodeIdentifier) not found.",
                details: nil
            )
            return
        }

        dispatchMain {
            if view.isAnimating {
                return
            }
            view.isAnimating = true

            let targetWidth = CGFloat(width)
            let targetHeight = CGFloat(height)

            let originalCenter = view.center

            // view.sizeFlexibility = .none

            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.3,
                options: [.curveEaseInOut, .allowUserInteraction],
                animations: {
                    let newFrame = CGRect(
                        x: originalCenter.x - targetWidth / 2,
                        y: originalCenter.y - targetHeight / 2,
                        width: targetWidth,
                        height: targetHeight
                    )
                    view.frame = newFrame
                    view.center = originalCenter
                    view.layoutIfNeeded()
                },
                completion: { finished in
                    view.isAnimating = false
                }
            )
        }
    }

    public func setViewForTrackedBarcodeOld(
        view: TappableView?,
        trackedBarcodeId: Int,
        sessionFrameSequenceId: Int?,
        dataCaptureViewId: Int
    ) {
        guard let dcView = self.captureViewHandler.getView(dataCaptureViewId),
            let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
        else {
            return
        }
        guard let barcode = trackedBarcode(by: trackedBarcodeId) else {
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
            overlay.setView(view, for: barcode)
        }
    }

    public func setAnchorForTrackedBarcode(
        dataCaptureViewId: Int,
        anchorJson: String,
        trackedBarcodeIdentifier: Int,
        result: FrameworksResult
    ) {
        guard let dcView = self.captureViewHandler.getView(dataCaptureViewId),
            let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
        else {
            result.success()
            return
        }
        guard let barcode = trackedBarcode(by: trackedBarcodeIdentifier) else {
            result.success()
            return
        }

        var anchor: Anchor = .center
        SDCAnchorFromJSONString(anchorJson, &anchor)

        dispatchMain {
            overlay.setAnchor(anchor, for: barcode)
            result.success()
        }
    }

    public func setOffsetForTrackedBarcode(
        dataCaptureViewId: Int,
        offsetJson: String,
        trackedBarcodeIdentifier: Int,
        result: FrameworksResult

    ) {
        guard let dcView = self.captureViewHandler.getView(dataCaptureViewId),
            let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
        else {
            result.success()
            return
        }

        guard let barcode = trackedBarcode(by: trackedBarcodeIdentifier) else {
            result.success()
            return
        }
        var offset: PointWithUnit = .zero
        SDCPointWithUnitFromJSONString(offsetJson, &offset)
        dispatchMain {
            overlay.setOffset(offset, for: barcode)
            result.success()
        }
    }

    public func trackedBarcode(by id: Int) -> TrackedBarcode? {
        guard let session = self.cachedBatchSession.value else {
            return nil
        }
        return session.trackedBarcodes[id]
    }

    public func setBarcodeBatchModeEnabledState(modeId: Int, enabled: Bool, result: FrameworksResult) {
        getModeFromCache(modeId)?.isEnabled = enabled
        result.success()
    }

    public func isModeEnabled() -> Bool {
        getTopmostMode()?.isEnabled == true
    }

    public func updateBarcodeBatchMode(modeJson: String, result: FrameworksResult) {
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

    public func applyBarcodeBatchModeSettings(modeId: Int, modeSettingsJson: String, result: FrameworksResult) {
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

    public func updateBarcodeBatchBasicOverlay(dataCaptureViewId: Int, overlayJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }

            guard let dcView = self.captureViewHandler.getView(dataCaptureViewId),
                let overlay: BarcodeBatchBasicOverlay = dcView.findFirstOfType()
            else {
                result.success()
                return
            }

            do {
                try self.barcodeBatchDeserializer.update(overlay, fromJSONString: overlayJson)
                result.success()
            } catch {
                result.reject(error: error)
            }
        }
        dispatchMain(block)
    }

    public func updateBarcodeBatchAdvancedOverlay(dataCaptureViewId: Int, overlayJson: String, result: FrameworksResult)
    {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }

            guard let dcView = self.captureViewHandler.getView(dataCaptureViewId),
                let overlay: BarcodeBatchAdvancedOverlay = dcView.findFirstOfType()
            else {
                result.success()
                return
            }

            do {
                try self.barcodeBatchDeserializer.update(overlay, fromJSONString: overlayJson)
                result.success()
            } catch {
                result.reject(error: error)
            }
        }
        dispatchMain(block)
    }

    public override func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        BarcodeBatchModuleCommandFactory.create(module: self, method)
    }
}

extension BarcodeBatchModule: DeserializationLifeCycleObserver {
    public func dataCaptureContext(addMode modeJson: String) throws {
        guard let dcContext = captureContext.context else {
            return
        }

        do {
            let creationParams = try BarcodeBatchModeCreationData.fromJson(modeJson)

            if creationParams.modeType != "barcodeTracking" {
                return
            }

            let batchMode = try FrameworksBarcodeBatchMode.create(
                emitter: emitter,
                captureContext: DefaultFrameworksCaptureContext.shared,
                creationData: creationParams,
                dataCaptureContext: dcContext,
                cachedBatchSession: self.cachedBatchSession
            )

            addModeToCache(modeId: creationParams.modeId, mode: batchMode)
            for action in getPostModeCreationActions(creationParams.modeId) {
                action()
            }
            let parentId = batchMode.parentId ?? -1
            for action in getPostModeCreationActionsByParent(parentId) {
                action()
            }
        } catch {
            print(error)
        }
    }

    public func dataCaptureContext(removeMode modeJson: String) {
        let json = JSONValue(string: modeJson)

        if json.string(forKey: "type") != "barcodeTracking" {
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
        let creationParams = BarcodeBatchOverlayCreationData.fromJson(overlayJson)
        if !creationParams.isBasic && !creationParams.isAdvanced {
            return
        }

        let parentId = view.parentId ?? -1

        var mode: FrameworksBarcodeBatchMode?

        if parentId != -1 {
            mode = getModeFromCacheByParent(parentId) as? FrameworksBarcodeBatchMode
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
                    Log.error("Barcode batch mode is not available for overlay creation")
                    return
                }
                if creationParams.isAdvanced {
                    let overlay = try self.barcodeBatchDeserializer.advancedOverlay(
                        fromJSONString: creationParams.overlayJsonString,
                        withMode: barcodeMode
                    )

                    if creationParams.hasListeners {
                        overlay.delegate = self.barcodeBatchAdvancedOverlayListener
                    }

                    view.addOverlay(overlay)
                } else {
                    let overlay = try self.barcodeBatchDeserializer.basicOverlay(
                        fromJSONString: overlayJson,
                        withMode: barcodeMode
                    )

                    if creationParams.hasListeners {
                        overlay.delegate = self.barcodeBatchBasicOverlayListener
                    }

                    view.addOverlay(overlay)
                }
            } catch {
                Log.error(error)
            }
        }

    }

    public func dataCaptureView(removedOverlay overlay: any DataCaptureOverlay) {
        (overlay as? BarcodeBatchBasicOverlay)?.delegate = nil
        (overlay as? BarcodeBatchAdvancedOverlay)?.delegate = nil
    }
}
