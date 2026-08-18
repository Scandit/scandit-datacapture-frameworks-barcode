/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum SparkScanError: Error {
    case nilContext
    case json(String, String)
    case nilView
    case nilParent
}

open class SparkScanModule: NSObject, FrameworkModule {
    private let captureContext = DefaultFrameworksCaptureContext.shared
    private let emitter: Emitter

    private let viewCache = FrameworksViewsCache<FrameworksSparkScanView>()

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    public func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
    }

    public func getDefaults() -> [String: Any?] {
        SparkScanDefaults.shared.toEncodable()
    }

    public func registerSparkScanListenerForEvents(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.enableSparkScanListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterSparkScanListenerForEvents(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.disableSparkScanListener()
        result.success()
    }

    public func finishSparkScanDidUpdateSession(viewId: Int, isEnabled: Bool, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.finishDidUpdateCallback(enabled: isEnabled)
        result.success()
    }

    public func finishSparkScanDidScan(viewId: Int, isEnabled: Bool, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.finishDidScanCallback(enabled: isEnabled)
        result.success()
    }

    public func resetSparkScanSession(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.resetLastSession()
        result.success()
    }

    public func registerSparkScanViewListenerEvents(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addSparkScanViewUiListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterSparkScanViewListenerEvents(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeSparkScanViewUiListener()
        result.success()
    }

    public func addViewToContainer(
        _ container: UIView,
        jsonString: String,
        result: FrameworksResult,
        completion: ((Int) -> Void)? = nil
    ) {
        guard let context = self.captureContext.context else {
            Log.error(SparkScanError.nilContext)
            result.reject(error: SparkScanError.nilContext)
            return
        }
        dispatchMain { [weak self] in
            guard let self = self else {
                return
            }

            do {
                let viewCreationParams = SparkScanViewCreationData.fromJson(jsonString)

                if let existingView = self.viewCache.getView(viewId: viewCreationParams.viewId) {
                    existingView.dispose()
                    _ = self.viewCache.remove(viewId: existingView.viewId)
                }

                if let previousView = viewCache.getTopMost() {
                    previousView.hide()
                }

                let view = try FrameworksSparkScanView.create(
                    emitter: emitter,
                    context: context,
                    container: container,
                    viewCreationParams: viewCreationParams
                )
                self.viewCache.addView(view: view)
                result.success()
                completion?(view.viewId)
            } catch {
                Log.error(error)
                result.reject(error: error)
            }
        }
    }

    public func updateSparkScanView(viewId: Int, viewJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.updateView(viewJson: viewJson)
        result.success()
    }

    public func updateSparkScanMode(viewId: Int, modeJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        do {
            try viewInstance.updateMode(modeJson: modeJson)
            result.success()
        } catch {
            Log.error(error)
            result.reject(error: error)
        }
    }

    public func pauseSparkScanViewScanning(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.pauseScanning()
        result.success()
    }

    public func stopSparkScanViewScanning(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.stopScanning()
        result.success()
    }

    public func onHostPauseSparkScanView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.stopScanning()
        result.success()
    }

    public func startSparkScanViewScanning(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            Log.error(SparkScanError.nilView)
            result.reject(error: SparkScanError.nilView)
            return
        }
        viewInstance.startScanning()
        result.success()
    }

    public func prepareSparkScanViewScanning(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            Log.error(SparkScanError.nilView)
            result.reject(error: SparkScanError.nilView)
            return
        }
        viewInstance.prepareScanning()
        result.success()
    }

    public func showSparkScanViewToast(viewId: Int, text: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            Log.error(SparkScanError.nilView)
            result.reject(error: SparkScanError.nilView)
            return
        }
        viewInstance.showToast(text: text)
        result.success()
    }

    public func setSparkScanModeEnabledState(viewId: Int, isEnabled: Bool, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.setModeEnabled(isEnabled)
        result.success()
    }

    public func isModeEnabled() -> Bool {
        viewCache.getTopMost()?.isModeEnabled() ?? false
    }

    public func submitSparkScanFeedbackForBarcode(viewId: Int, feedbackJson: String?, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            Log.error(SparkScanError.nilView)
            result.reject(error: SparkScanError.nilView)
            return
        }
        viewInstance.submitFeedbackForBarcode(feedbackJson: feedbackJson)
        result.success()
    }

    public func submitSparkScanFeedbackForScannedItem(viewId: Int, feedbackJson: String?, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            Log.error(SparkScanError.nilView)
            result.reject(error: SparkScanError.nilView)
            return
        }
        viewInstance.submitFeedbackForScannedItem(feedbackJson: feedbackJson)
        result.success()
    }

    public func registerSparkScanFeedbackDelegateForEvents(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addFeedbackDelegate()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterSparkScanFeedbackDelegateForEvents(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeFeedbackDelegate()
        result.success()
    }

    public func bringSparkScanViewToFront(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.bringViewToTop()
        result.success()
    }

    public func setupViewConstraints(viewId: Int, referenceView: UIView) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else { return }
        viewInstance.setupViewConstraints(referenceView: referenceView)
    }

    public func hitTest(viewId: Int, point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let viewInstance = viewCache.getView(viewId: viewId) else { return nil }
        return viewInstance.hitTest(point, with: event)
    }

    public func disposeSparkScanView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.remove(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.dispose()

        if let previousView = viewCache.getTopMost() {
            previousView.show()
        }
        result.success()
    }

    public func getLastFrameDataBytes(frameId: String, result: FrameworksResult) {
        LastFrameData.shared.getLastFrameDataBytes(frameId: frameId) {
            result.success(result: $0)
        }
    }

    public func showSparkScanView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.show()
        result.success()
    }

    public func hideSparkScanView(viewId: Int, result: FrameworksResult) {
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
        SparkScanModuleCommandFactory.create(module: self, method)
    }
}

extension SparkScanModule: DeserializationLifeCycleObserver {
    public func didDisposeDataCaptureContext() {
        viewCache.disposeAll()
    }
}
