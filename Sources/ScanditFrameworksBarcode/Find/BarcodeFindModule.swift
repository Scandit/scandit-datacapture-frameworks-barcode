/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodeFindModule: NSObject, FrameworkModule {
    private let emitter: Emitter
    private let captureContext = DefaultFrameworksCaptureContext.shared

    public init(emitter: Emitter) {
        self.emitter = emitter
        super.init()
    }

    private let viewCache = FrameworksViewsCache<FrameworksBarcodeFindView>()

    private var barcodeFindFeedback: BarcodeFindFeedback?

    public func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        viewCache.disposeAll()
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
    }

    public func getDefaults() -> [String: Any?] {
        BarcodeFindDefaults.shared.toEncodable()
    }

    public func addViewToContainer(container: UIView, jsonString: String, result: FrameworksResult) {
        guard let context = self.captureContext.context else {
            result.reject(error: ScanditFrameworksCoreError.nilDataCaptureContext)
            return
        }

        do {

            let viewCreationParams = try BarcodeFindViewCreationData.fromJson(viewJson: jsonString)
            if let existingView = viewCache.getView(viewId: viewCreationParams.viewId) {
                existingView.dispose()
                _ = viewCache.remove(viewId: existingView.viewId)
            }

            if let previousView = viewCache.getTopMost() {
                previousView.hide()
            }

            let block = { [weak self] in
                guard let self = self else {
                    result.reject(error: ScanditFrameworksCoreError.nilSelf)
                    return
                }

                do {
                    let view = try FrameworksBarcodeFindView.create(
                        emitter: emitter,
                        context: context,
                        container: container,
                        viewCreationParams: viewCreationParams
                    )
                    viewCache.addView(view: view)
                    result.success()
                } catch {
                    result.reject(error: error)
                    return
                }
            }

            dispatchMain(block)
        } catch {
            result.reject(error: error)
            return
        }
    }

    public func getViewById(_ viewId: Int) -> BarcodeFindView? {
        viewCache.getView(viewId: viewId)?.view
    }

    public func updateFindView(viewId: Int, barcodeFindViewJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.updateBarcodeFindView(viewJson: barcodeFindViewJson)
        result.success()
    }

    public func onViewRemovedFromSuperview(viewId: Int) {
        if let viewInstance = viewCache.remove(viewId: viewId) {
            viewInstance.dispose()
        }

        if let previousView = viewCache.getTopMost() {
            previousView.show()
        }
    }

    public func removeBarcodeFindView(_ viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.remove(viewId: viewId) else {
            return
        }

        viewInstance.dispose()
        result.success()
    }

    public func updateFindMode(viewId: Int, barcodeFindJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.updateBarcodeFindMode(modeJson: barcodeFindJson)
        result.success()
    }

    public func registerBarcodeFindListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeFindListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeFindListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeFindListener()
        result.success()
    }

    public func registerBarcodeFindViewListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeFindViewListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeFindViewListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeFindViewListener()
        result.success()
    }

    public func barcodeFindSetItemList(viewId: Int, itemsJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.setItemList(barcodeFindItemsJson: itemsJson)
        result.success()
    }

    public func prepareSearching(_ viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.viewPrepareSearching()
        result.success()
    }

    public func barcodeFindViewPauseSearching(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.viewPauseSearching()
        result.success()
    }

    public func barcodeFindViewStopSearching(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.viewStopSearching()
        result.success()
    }

    public func barcodeFindViewStartSearching(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.viewStartSearching()
        result.success()
    }

    public func barcodeFindModeStart(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.modeStart()
        result.success()
    }

    public func barcodeFindModeStop(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.modeStop()
        result.success()
    }

    public func barcodeFindModePause(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.modePause()
        result.success()
    }

    public func setBarcodeFindModeEnabledState(viewId: Int, enabled: Bool, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.setModeEnabled(enabled: enabled)
        result.success()
    }

    public func isModeEnabled() -> Bool {
        viewCache.getTopMost()?.isModeEnabled() ?? false
    }

    public func setBarcodeTransformer(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }

        viewInstance.setBarcodeFindTransformer()
        result.successAndKeepCallback(result: nil)
    }

    public func unsetBarcodeTransformer(viewId: Int, result: FrameworksResult) {
        // The native API isn't allowing the removal of the transformer
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.unsetBarcodeFindTransformer()
        result.success()
    }

    public func submitBarcodeFindTransformerResult(viewId: Int, transformedBarcode: String?, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.submitBarcodeFindTransformerResult(transformedData: transformedBarcode)
        result.success()
    }

    public func updateBarcodeFindFeedback(viewId: Int, feedbackJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        do {
            try viewInstance.updateFeedback(feedbackJson: feedbackJson)
            result.success()
        } catch let error {
            result.reject(error: error)
        }
    }

    public func showFindView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.show()
        result.success()
    }

    public func hideFindView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.hide()
        result.success()
    }

    public func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        BarcodeFindModuleCommandFactory.create(module: self, method)
    }
}

extension BarcodeFindModule: DeserializationLifeCycleObserver {
    public func didDisposeDataCaptureContext() {
        viewCache.disposeAll()
    }
}
