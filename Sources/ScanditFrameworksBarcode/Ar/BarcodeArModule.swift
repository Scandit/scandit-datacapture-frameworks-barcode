/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodeArModule: NSObject, FrameworkModule, DeserializationLifeCycleObserver {
    private let emitter: Emitter
    private let deserializer: BarcodeArDeserializer
    private let viewDeserialzier: BarcodeArViewDeserializer
    private let augmentationsCache: BarcodeArAugmentationsCache
    private let captureContext = DefaultFrameworksCaptureContext.shared

    private let viewCache = FrameworksViewsCache<FrameworksBarcodeArView>()

    public init(emitter: Emitter) {
        self.emitter = emitter
        self.deserializer = BarcodeArDeserializer()
        self.viewDeserialzier = BarcodeArViewDeserializer()
        self.augmentationsCache = BarcodeArAugmentationsCache()
    }

    public func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
        cleanup()
    }

    public func didDisposeDataCaptureContext() {
        cleanup()
    }

    private func cleanup() {
        augmentationsCache.clear()
        viewCache.disposeAll()
    }

    public func getDefaults() -> [String: Any?] {
        BarcodeArDefaults.shared.toEncodable()
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
            result.success()
            return
        }
        viewInstance.startMode()
        result.success()
    }

    public func barcodeArViewStop(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
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

    public func removeView(viewId: Int, result: FrameworksResult) {
        viewCache.remove(viewId: viewId)?.dispose()
        if let previousView = viewCache.getTopMost() {
            previousView.show()
        }
        result.success()
    }

    public func createCommand(
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
        viewInstance.view.pause()
        result.success()
    }

    func barcodeArViewReset(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.view.reset()
        result.success()
    }

    func getTopMostView() -> BarcodeArView? {
        viewCache.getTopMost()?.view
    }
}
