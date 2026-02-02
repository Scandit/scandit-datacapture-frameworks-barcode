/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodePickModule: NSObject, FrameworkModule, DeserializationLifeCycleObserver {
    let emitter: Emitter

    private let captureContext = DefaultFrameworksCaptureContext.shared

    private let viewCache = FrameworksViewsCache<FrameworksBarcodePickView>()

    public init(emitter: Emitter) {
        self.emitter = emitter
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
        viewCache.disposeAll()
    }

    public func getDefaults() -> [String: Any?] {
        BarcodePickDefaults.shared.toEncodable()
    }

    public func addViewToContainer(container: UIView, jsonString: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }
            guard let context = self.captureContext.context else {
                result.reject(error: ScanditFrameworksCoreError.nilDataCaptureContext)
                return
            }
            let json = JSONValue(string: jsonString)
            guard json.containsKey("View") else {
                result.reject(
                    error: ScanditFrameworksCoreError.deserializationError(
                        error: nil,
                        json: jsonString
                    )
                )
                return
            }

            do {
                let viewCreationParams = try BarcodePickViewCreationData.fromJson(jsonString)

                if let existingView = viewCache.getView(viewId: viewCreationParams.viewId) {
                    existingView.dispose()
                    _ = viewCache.remove(viewId: existingView.viewId)
                }

                if let previousView = viewCache.getTopMost() {
                    previousView.hide()
                }

                let frameworksView = try FrameworksBarcodePickView.create(
                    emitter: self.emitter,
                    parent: container,
                    context: context,
                    viewCreationParams: viewCreationParams
                )

                viewCache.addView(view: frameworksView)

                result.success(result: nil)
            } catch let error {
                result.reject(
                    error: ScanditFrameworksCoreError.deserializationError(
                        error: error,
                        json: nil
                    )
                )
                return
            }
        }
        dispatchMain(block)
    }

    public func createCommand(
        _ method: any ScanditFrameworksCore.FrameworksMethodCall
    ) -> (any ScanditFrameworksCore.BaseCommand)? {
        BarcodePickModuleCommandFactory.create(module: self, method)
    }
}

public extension BarcodePickModule {

    func pickViewStart(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.start()
        result.success()
    }

    func pickViewStop(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.stop()
        result.success()
    }

    func pickViewFreeze(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.freeze()
        result.success()
    }

    func removeView(viewId: Int, result: FrameworksResult) {
        viewCache.remove(viewId: viewId)?.dispose()
        if let previousView = viewCache.getTopMost() {
            previousView.show()
        }
        result.success()
    }

    func updatePickView(viewId: Int, json: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.updateView(viewJson: json)
        result.success()
    }

    func finishOnProductIdentifierForItems(
        viewId: Int,
        itemsJson: String,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.finishProductIdentifierForItems(
            barcodePickProductProviderCallbackItemsJson: itemsJson
        )
        result.success()
    }

    func finishPickAction(viewId: Int, itemData: String, actionResult: Bool, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.finishPickAction(data: itemData, result: actionResult)
        result.success()
    }

    func addPickActionListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodePickActionListener()
        result.successAndKeepCallback(result: nil)
    }

    func removePickActionListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodePickActionListener()
        result.success()
    }

    func addBarcodePickScanningListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodePickScanningListener()
        result.successAndKeepCallback(result: nil)
    }

    func removeBarcodePickScanningListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodePickScanningListener()
        result.success()
    }

    func addPickViewListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodePickViewListener()
        result.successAndKeepCallback(result: nil)
    }

    func removePickViewListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodePickViewListener()
        result.success()
    }

    func registerBarcodePickViewUiListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodePickViewUiListener()
        result.successAndKeepCallback(result: nil)
    }

    func unregisterBarcodePickViewUiListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodePickViewUiListener()
        result.success()
    }

    func addBarcodePickListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.successAndKeepCallback(result: nil)
            return
        }
        viewInstance.addBarcodePickListener()
        result.successAndKeepCallback(result: nil)
    }

    func removeBarcodePickListener(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.removeBarcodePickListener()
        result.success()
    }

    func pickViewReset(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.reset()
        result.success()
    }

    func pickViewRelease(viewId: Int, result: FrameworksResult) {
        viewCache.remove(viewId: viewId)?.dispose()

        let previousView = viewCache.getTopMost()
        previousView?.show()
        previousView?.start()
        result.success()
    }

    func pickViewPause(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.pause()
        result.success()
    }

    func pickViewResume(viewId: Int, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.start()
        result.success()
    }

    func registerOnProductIdentifierForItemsListener(viewId: Int, result: FrameworksResult) {
        // Noop - handled automatically by FrameworksBarcodePickView
        result.successAndKeepCallback(result: nil)
    }

    func unregisterOnProductIdentifierForItemsListener(viewId: Int, result: FrameworksResult) {
        // Noop - handled automatically by FrameworksBarcodePickView
        result.success()
    }

    func finishBarcodePickViewHighlightStyleCustomViewProviderViewForRequest(
        viewId: Int,
        requestId: Int,
        response: [String: Any]?,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        var statusIconStyle: BarcodePickStatusIconStyle?

        if let statusIconStyleJson = response?["statusIconStyle"] as? String {
            statusIconStyle = BarcodePickStatusIconStyle(jsonString: statusIconStyleJson)
        }

        dispatchMain {
            var customView: UIImageView?
            if let viewBytes = response?["view"] as? Data {
                customView = UIImageView()
                if let image = UIImage(data: viewBytes) {
                    customView?.image = image
                }
            }

            viewInstance.finishBarcodePickViewHighlightStyleCustomViewProviderViewForRequest(
                requestId: requestId,
                customView: customView,
                statusIconStyle: statusIconStyle
            )
            result.success()
        }
    }

    func finishBarcodePickViewHighlightStyleAsyncProviderStyleForRequest(
        viewId: Int,
        requestId: Int,
        responseJson: String?,
        result: FrameworksResult
    ) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }

        dispatchMain {
            viewInstance.finishBarcodePickViewHighlightStyleAsyncProviderStyleForRequest(
                requestId: requestId,
                responseJson: responseJson
            )
            result.success()
        }
    }

    func getTopMostView() -> BarcodePickView? {
        viewCache.getTopMost()?.view
    }

    func confirmActionForItemWithData(viewId: Int, data: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.confirmActionForItemWithData(data: data)
        result.success()
    }

    func selectItemWithData(viewId: Int, data: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.reject(code: "-1", message: "View not found.", details: nil)
            return
        }
        viewInstance.selectItemWithData(
            data: data,
            completionHandler: { action in
                result.success(result: action.jsonString)
            }
        )
    }

    func cancelActionForItemWithData(viewId: Int, data: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.success()
            return
        }
        viewInstance.cancelActionForItemWithData(data: data)
        result.success()
    }

    func updateProductList(viewId: Int, productsJson: String, result: FrameworksResult) {
        guard let viewInstance = viewCache.getView(viewId: viewId) else {
            result.reject(code: "-1", message: "View not found.", details: nil)
            return
        }
        viewInstance.updateProductList(productsJson: productsJson)
        result.success()
    }

    func registerHighlightStyleAsyncProviderListener(viewId: Int, result: FrameworksResult) {
        result.successAndKeepCallback(result: nil)
    }

    func unregisterHighlightStyleAsyncProviderListener(viewId: Int, result: FrameworksResult) {
        result.success()
    }
}
