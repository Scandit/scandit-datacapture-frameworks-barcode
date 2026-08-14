/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditBarcodeCaptureDeserializer
import ScanditFrameworksCore

open class BarcodeArModule: BaseFrameworkModule, DeserializationLifeCycleObserver {
    private let emitter: Emitter
    private let deserializer: BarcodeArDeserializer
    private let viewDeserialzier: BarcodeArViewDeserializer
    private let augmentationsCache: BarcodeArAugmentationsCache
    private let captureContext = DefaultFrameworksCaptureContext.shared

    private let viewCache = FrameworksViewsCache<FrameworksBarcodeArView>()

    // barcodeArViewStart/barcodeArViewStop can arrive before addViewFromJson has
    // finished creating the native view for a given viewId (e.g. a rapid enable
    // racing view creation, or a re-mount that fires start before the
    // createNativeView RPC resolves). Mirrors Android's
    // addPostSpecificViewCreationAction (BarcodeArModule.kt): such calls are
    // parked via BaseFrameworkModule's post-view-creation action store and
    // replayed once the view exists, instead of being silently dropped
    // (SDC-32484).

    public init(emitter: Emitter) {
        self.emitter = emitter
        self.deserializer = BarcodeArDeserializer()
        self.viewDeserialzier = BarcodeArViewDeserializer()
        self.augmentationsCache = BarcodeArAugmentationsCache()
    }

    override public func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    override public func didStop() {
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
        cleanup()
        // Drops any not-yet-replayed parked start/stop (SDC-32484) so a stale
        // closure never fires against a torn-down module.
        clearAllPostViewCreationActions()
    }

    public func didDisposeDataCaptureContext() {
        cleanup()
    }

    private func cleanup() {
        augmentationsCache.clear()
        viewCache.disposeAll()
    }

    override public func getDefaults() -> [String: Any?] {
        BarcodeArDefaults.shared.toEncodable()
    }

    // Exposes the cached view to the RN host container so it can re-assert
    // `start()` when the view re-enters a window (SDC-32484).
    public func getView(viewId: Int) -> FrameworksBarcodeArView? {
        viewCache.getView(viewId: viewId)
    }

    public func registerBarcodeArFilter(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeArFilter()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeArFilter(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeArFilter()
        result.success()
    }

    public func finishBarcodeArFilterBarcodes(viewId: Int, filteredBarcodesJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.finishFilterBarcodes(filteredBarcodesJson: filteredBarcodesJson)
        result.success()
    }

    public func registerBarcodeArViewUiListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeArViewUiListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeArViewUiListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeArViewUiListener()
        result.success()
    }

    public func registerBarcodeArHighlightProvider(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeArHighlightProvider()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeArHighlightProvider(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeArHighlightProvider()
        result.success()
    }

    public func onCustomHighlightClicked(viewId: Int, barcodeId: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.onCustomHighlightClicked(barcodeId: barcodeId)
        result.success()
    }

    public func registerBarcodeArAnnotationProvider(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeArAnnotationProvider()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeArAnnotationProvider(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeArAnnotationProvider()
        result.success()
    }

    public func updateBarcodeArFeedback(viewId: Int, feedbackJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        do {
            try viewInstance.updateFeedback(feedbackJson: feedbackJson)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func resetBarcodeArSession(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.resetSession()
        result.success()
    }

    public func applyBarcodeArSettings(viewId: Int, settings: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        do {
            try viewInstance.applySettings(settingsJson: settings)
            result.success()
        } catch {
            result.reject(error: error)
        }
    }

    public func updateBarcodeArMode(viewId: Int, modeJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.updateMode(modeJson: modeJson)
        result.success()
    }

    public func registerBarcodeArListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            // Registration can race view creation (a listener added before the
            // widget mounts). Park the listener attachment and replay it once
            // addViewFromJson creates this viewId — same parking as
            // barcodeArViewStart/Stop above and Android's BarcodeArModule.kt.
            // Resolve the result NOW and park only the action: a parked
            // `result` would leak the bridge callback if the view is never
            // created (see barcodeArViewStart's rationale).
            addPostSpecificViewCreationAction(viewId: viewId) { [weak self] in
                self?.viewCache.getView(viewId: viewId)?.addBarcodeArListener()
            }
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeArListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeArListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeArListener()
        result.success()
    }

    public func finishBarcodeArOnDidUpdateSession(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.finishDidUpdateSession(enabled: true)
        result.success()
    }

    public func getLastFrameDataBytes(frameId: String, result: FrameworksResult) {
        LastFrameData.shared.getLastFrameDataBytes(frameId: frameId) {
            result.success(result: $0)
        }
    }

    public func finishBarcodeArHighlightForBarcode(viewId: Int, highlightJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        let block = { [weak self] in
            guard self != nil else {
                return
            }
            viewInstance.finishHighlightForBarcode(highlightJson: highlightJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func finishBarcodeArAnnotationForBarcode(viewId: Int, annotationJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        let block = { [weak self] in
            guard self != nil else {
                return
            }
            viewInstance.finishAnnotationForBarcode(annotationJson: annotationJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func updateBarcodeArPopoverButtonAtIndex(viewId: Int, updateJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        let block = { [weak self] in
            guard self != nil else {
                return
            }
            viewInstance.updateBarcodeArPopoverButtonAtIndex(updateJson: updateJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func updateBarcodeArHighlight(viewId: Int, highlightJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        let block = { [weak self] in
            guard self != nil else {
                return
            }
            viewInstance.updateHighlight(highlightJson: highlightJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func updateBarcodeArAnnotation(viewId: Int, annotationJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        let block = { [weak self] in
            guard self != nil else {
                return
            }
            viewInstance.updateAnnotation(annotationJson: annotationJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func updateBarcodeArView(viewId: Int, viewJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.updateView(viewJson: viewJson)
        result.success()
    }

    public func barcodeArViewStart(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            // The RN/JS side can call start() before the native view for this
            // viewId has been created (e.g. a rapid enable racing addViewFromJson,
            // or a re-mount that fires start before createNativeView's async RPC
            // resolves). Mirrors Android's addPostSpecificViewCreationAction
            // (BarcodeArModule.kt:336-344): park the call and replay it once
            // addViewFromJson creates that viewId, instead of silently dropping
            // the start (SDC32484).
            // Resolve the RN promise NOW and park only the action: if the view
            // is never created (screen unmounted first), a parked `result`
            // would leak the bridge promise / hang the JS await. Matches the
            // pre-parking semantics, which resolved success immediately.
            addPostSpecificViewCreationAction(viewId: viewId) { [weak self] in
                self?.viewCache.getView(viewId: viewId)?.startMode()
            }
            result.success()
            return
        }
        viewInstance.startMode()
        result.success()
    }

    public func barcodeArViewStop(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            // Same parking as barcodeArViewStart above (SDC32484): a stop() that
            // arrives before the view exists must be replayed once it's created,
            // not dropped — otherwise a start()+stop() pair racing view creation
            // can leave the view started when the caller expected it stopped.
            // Same promise-safety as barcodeArViewStart: resolve now, park the
            // bare action.
            addPostSpecificViewCreationAction(viewId: viewId) { [weak self] in
                self?.viewCache.getView(viewId: viewId)?.stopMode()
            }
            result.success()
            return
        }
        viewInstance.stopMode()
        result.success()
    }

    public func showView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.show()
        result.success()
    }

    public func hideView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.hide()
        result.success()
    }

    public func showBarcodeArView(viewId: Int, result: FrameworksResult) {
        showView(viewId: viewId, result: result)
    }

    public func hideBarcodeArView(viewId: Int, result: FrameworksResult) {
        hideView(viewId: viewId, result: result)
    }

    public func removeView(viewId: Int, result: FrameworksResult) {
        // Drop any not-yet-replayed parked start/stop for this viewId — the view
        // is gone, so a later replay would resurrect a stale closure (SDC32484).
        clearPostSpecificViewCreationActions(viewId: viewId)
        viewCache.remove(viewId: viewId)?.dispose()
        if let previousView = viewCache.getTopMost() {
            previousView.show()
        }
        result.success()
    }

    override public func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        BarcodeArModuleCommandFactory.create(module: self, method)
    }
}

public extension BarcodeArModule {

    // swiftlint:disable function_body_length
    func addViewFromJson(parent: UIView, viewJson: String, result: FrameworksResult) {

        guard let context = self.captureContext.context else {
            result.reject(error: ScanditFrameworksCoreError.nilDataCaptureContext)
            return
        }
        let json = JSONValue(string: viewJson)
        guard json.containsKey("View") else {
            result.reject(error: ScanditFrameworksCoreError.deserializationError(error: nil, json: viewJson))
            return
        }

        do {
            let viewCreationParams = try BarcodeArViewCreationData.fromJson(viewJson)

            let block = { [weak self] in
                guard let self = self else {
                    result.reject(error: ScanditFrameworksCoreError.nilSelf)
                    return
                }

                do {

                    if let existingView = viewCache.getView(viewId: viewCreationParams.viewId) {
                        existingView.dispose()
                        _ = viewCache.remove(viewId: existingView.viewId)
                    }

                    if let previousView = viewCache.getTopMost() {
                        previousView.hide()
                    }

                    let frameworksView = try FrameworksBarcodeArView.create(
                        emitter: self.emitter,
                        parent: parent,
                        context: context,
                        viewCreationParams: viewCreationParams,
                        augmentationsCache: self.augmentationsCache
                    )
                    viewCache.addView(view: frameworksView)
                    // Replay any barcodeArViewStart/barcodeArViewStop calls parked
                    // while this viewId didn't have a view yet (SDC32484 — mirrors
                    // Android's getPostSpecificViewCreationActions drain in
                    // BarcodeArModule.kt).
                    let parkedActions = self.getPostSpecificViewCreationActions(viewId: viewCreationParams.viewId)
                    for action in parkedActions {
                        action()
                    }
                    result.success()
                } catch {
                    result.reject(error: error)
                }
            }
            dispatchMain(block)
        } catch {
            result.reject(error: error)
        }
    }
    // swiftlint:enable function_body_length

    func addViewToContainer(container: UIView, jsonString: String, result: FrameworksResult) {
        addViewFromJson(parent: container, viewJson: jsonString, result: result)
    }

    func barcodeArViewPause(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        dispatchMain {
            viewInstance.view.pause()
        }
        result.success()
    }

    func barcodeArViewReset(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        let block = { [weak self] in
            guard self != nil else {
                return
            }
            viewInstance.view.reset()
            result.success()
        }
        dispatchMain(block)
    }

    func getTopMostView() -> BarcodeArView? {
        viewCache.getTopMost()?.view
    }
}
