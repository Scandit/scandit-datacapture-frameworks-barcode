/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodeCountModule: NSObject, FrameworkModule, DeserializationLifeCycleObserver {
    private let emitter: Emitter
    private let captureContext = DefaultFrameworksCaptureContext.shared

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    private let viewCache = FrameworksViewsCache<FrameworksBarcodeCountView>()

    public func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
        viewCache.disposeAll()
    }

    public func didDisposeDataCaptureContext() {
        viewCache.disposeAll()
    }

    public func getDefaults() -> [String: Any?] {
        BarcodeCountDefaults.shared.toEncodable()
    }

    public func addViewFromJson(parent: UIView, viewJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else { return }
            guard let context = self.captureContext.context else {
                result.reject(error: ScanditFrameworksCoreError.nilDataCaptureContext)
                Log.error(
                    "Error during the barcode count view deserialization.\nError: The DataCaptureView has not been initialized yet."
                )
                return
            }

            do {

                let viewCreationParams = try BarcodeCountViewCreationData.fromJson(viewJson)

                if let existingView = viewCache.getView(viewId: viewCreationParams.viewId) {
                    existingView.dispose()
                    _ = viewCache.remove(viewId: existingView.viewId)
                }

                if let previousView = viewCache.getTopMost() {
                    previousView.hide()
                }

                let view = try FrameworksBarcodeCountView.create(
                    emitter: self.emitter,
                    parent: parent,
                    context: context,
                    viewCreationParams: viewCreationParams
                )
                viewCache.addView(view: view)
                result.success()
            } catch {
                Log.error("Unable to create the BarcodeCountView.", error: error)
                result.reject(error: error)
            }
        }
        dispatchMain(block)
    }

    public func updateBarcodeCountView(viewId: Int, viewJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        let block = { [weak self] in
            guard self != nil else { return }
            viewInstance.updateView(viewJson: viewJson)
            result.success()
        }
        dispatchMain(block)
    }

    public func removeBarcodeCountView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.remove(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.dispose()
        result.success()
    }

    public func addBarcodeCountStatusProvider(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }

        let block = { [weak self] in
            guard self != nil else { return }
            viewInstance.addBarcodeCountStatusProvider()
            result.successAndKeepCallback(result: nil)
        }
        dispatchMain(block)
    }

    public func updateBarcodeCountMode(viewId: Int, barcodeCountJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.updateMode(modeJson: barcodeCountJson)
        result.success(result: nil)
    }

    public func registerBarcodeCountViewListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.addBarcodeCountViewListener()
            result.successAndKeepCallback(result: nil)
        }
    }

    public func unregisterBarcodeCountViewListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.removeBarcodeCountViewListener()
            result.success()
        }
    }

    public func registerBarcodeCountViewUiListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }

        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.addBarcodeCountViewUiListener()
            result.successAndKeepCallback(result: nil)
        }
    }

    public func unregisterBarcodeCountViewUiListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.removeBarcodeCountViewUiListener()
            result.success()
        }
    }

    public func clearBarcodeCountHighlights(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.barcodeViewClearHighlights()
        result.success()
    }

    public func finishBarcodeCountBrushForRecognizedBarcode(
        viewId: Int,
        brushJson: String?,
        trackedBarcodeId: Int,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        let brush = brushJson.flatMap { Brush(jsonString: $0) }
        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.finishBrushForRecognizedBarcodeEvent(brush: brush, trackedBarcodeId: trackedBarcodeId)
            result.success()
        }
    }

    public func finishBarcodeCountBrushForRecognizedBarcodeNotInList(
        viewId: Int,
        brushJson: String?,
        trackedBarcodeId: Int,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        let brush = brushJson.flatMap { Brush(jsonString: $0) }
        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.finishBrushForRecognizedBarcodeNotInListEvent(brush: brush, trackedBarcodeId: trackedBarcodeId)
            result.success()
        }
    }

    public func finishBarcodeCountBrushForAcceptedBarcode(
        viewId: Int,
        brushJson: String?,
        trackedBarcodeId: Int,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        let brush = brushJson.flatMap { Brush(jsonString: $0) }
        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.finishBrushForAcceptedBarcodeEvent(brush: brush, trackedBarcodeId: trackedBarcodeId)
            result.success()
        }
    }

    public func finishBarcodeCountBrushForRejectedBarcode(
        viewId: Int,
        brushJson: String?,
        trackedBarcodeId: Int,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        let brush = brushJson.flatMap { Brush(jsonString: $0) }
        dispatchMain { [weak self] in
            guard self != nil else { return }
            viewInstance.finishBrushForRejectedBarcodeEvent(brush: brush, trackedBarcodeId: trackedBarcodeId)
            result.success()
        }
    }

    public func setBarcodeCountCaptureList(viewId: Int, captureListJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }

        let jsonArray = JSONValue(string: captureListJson).asArray()
        let targetBarcodes = Set(
            (0...jsonArray.count() - 1).map { jsonArray.atIndex($0).asObject() }.map {
                TargetBarcode(data: $0.string(forKey: "data"), quantity: $0.integer(forKey: "quantity"))
            }
        )

        viewInstance.setBarcodeCountCaptureList(targetBarcodes: targetBarcodes)
        result.successAndKeepCallback(result: nil)
    }

    public func resetBarcodeCountSession(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.resetBarcodeCountSession(frameSequenceId: nil)
        result.success()
    }

    public func finishBarcodeCountOnScan(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.finishOnScan(enabled: true)
        result.success()
    }

    public func registerBarcodeCountListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodeCountListener()
        result.successAndKeepCallback(result: nil)
    }

    public func registerBarcodeCountAsyncListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addAsyncBarcodeCountListener()
        result.successAndKeepCallback(result: nil)
    }

    public func unregisterBarcodeCountAsyncListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeAsyncBarcodeCountListener()
        result.success()
    }

    public func unregisterBarcodeCountListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodeCountListener()
        result.success()
    }

    public func resetBarcodeCount(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.resetBarcodeCount()
        result.success()
    }

    public func startBarcodeCountScanningPhase(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.startScanningPhase()
        result.success()
    }

    public func endBarcodeCountScanningPhase(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.endScanningPhase()
        result.success()
    }

    public func getBarcodeCountSpatialMap(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.reject(code: "-1", message: "View with id \(viewId) not found.", details: nil)
            return
        }
        result.success(result: viewInstance.getSpatialMap()?.jsonString)
    }

    public func getBarcodeCountSpatialMapWithHints(
        viewId: Int,
        expectedNumberOfRows: Int,
        expectedNumberOfColumns: Int,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.reject(code: "-1", message: "View with id \(viewId) not found.", details: nil)
            return
        }
        result.success(
            result: viewInstance.getSpatialMap(
                expectedNumberOfRows: expectedNumberOfRows,
                expectedNumberOfColumns: expectedNumberOfColumns
            )?.jsonString
        )
    }

    public func setBarcodeCountModeEnabledState(viewId: Int, isEnabled: Bool, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.setModeEnabled(isEnabled)
        result.success()
    }

    public func isModeEnabled() -> Bool {
        viewCache.getTopMost()?.isModeEnabled == true
    }

    public func updateBarcodeCountFeedback(viewId: Int, feedbackJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        guard let jsonData = feedbackJson.data(using: .utf8) else {
            result.reject(code: "-1", message: "Invalid feedback json", details: nil)
            return
        }

        do {
            try viewInstance.updateFeedback(feedbackJsonData: jsonData)
            result.success()
        } catch let error {
            result.reject(error: error)
        }
    }

    public func submitBarcodeCountStatusProviderCallback(
        viewId: Int,
        statusJson: String,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.submitBarcodeCountStatusProviderCallbackResult(statusJson: statusJson)
        result.success()
    }

    public func getLastFrameDataBytes(frameId: String, result: FrameworksResult) {
        LastFrameData.shared.getLastFrameDataBytes(frameId: frameId) {
            result.success(result: $0)
        }
    }

    public func disposeBarcodeCountView(viewId: Int) {
        viewCache.remove(viewId: viewId)?.dispose()

        if let previousView = viewCache.getTopMost() {
            previousView.show()
        }
    }

    public func showBarcodeCountView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.show()
        result.success()
    }

    public func hideBarcodeCountView(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        viewInstance.hide()
        result.success()
    }

    public func enableBarcodeCountHardwareTrigger(
        viewId: Int,
        hardwareTriggerKeyCode: Int?,
        result: FrameworksResult
    ) {
        // Not relevant on iOS
        result.success()
    }

    public func getTopMostView() -> BarcodeCountView? {
        viewCache.getTopMost()?.view
    }

    public func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        BarcodeCountModuleCommandFactory.create(module: self, method)
    }
}
