/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodePickModule: NSObject, FrameworkModule, DeserializationLifeCycleObserver {
    let emitter: Emitter
    var actionListener: FrameworksBarcodePickActionListener
    var scanningListener: FrameworksBarcodePickScanningListener
    var viewListener: FrameworksBarcodePickViewListener
    var viewUiListener: FrameworksBarcodePickViewUiListener
    var pickListener: FrameworksBarcodePickListener
    var customViewProvider: FrameworksBarcodePickViewHighlightStyleCustomViewProvider? = nil
    var highlightStyleProvider: FrameworksBarcodePickViewHighlightStyleAsyncProvider? = nil


    let deserializer = BarcodePickDeserializer()
    private let captureContext = DefaultFrameworksCaptureContext.shared

    public var barcodePickView: BarcodePickView? {
        willSet {
            barcodePickView?.removeActionListener(actionListener)
            barcodePickView?.removeListener(viewListener)
            barcodePickView?.uiDelegate = nil
        }
        didSet {
            barcodePickView?.addActionListener(actionListener)
            barcodePickView?.addListener(viewListener)
            barcodePickView?.uiDelegate = viewUiListener
        }
    }
    private var barcodePick: BarcodePick? {
        willSet {
            barcodePick?.removeScanningListener(scanningListener)
            barcodePick?.removeListener(pickListener)
        }
        didSet {
            barcodePick?.addListener(pickListener)
            barcodePick?.addScanningListener(scanningListener)
        }
    }
    private var asyncMapperProductProviderCallback: FrameworksBarcodePickAsyncMapperProductProviderCallback?

    public init(emitter: Emitter) {
        self.emitter = emitter
        actionListener = FrameworksBarcodePickActionListener(emitter: emitter)
        scanningListener = FrameworksBarcodePickScanningListener(emitter: emitter)
        viewListener = FrameworksBarcodePickViewListener(emitter: emitter)
        viewUiListener = FrameworksBarcodePickViewUiListener(emitter: emitter)
        pickListener = FrameworksBarcodePickListener(emitter: emitter)
    }

    public func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
        actionListener.disable()
        viewListener.disable()
        viewUiListener.disable()
        pickListener.disable()
        barcodePickView?.stop()
        barcodePickView?.removeFromSuperview()
    }

    public func didDisposeDataCaptureContext() {
        self.barcodePickView?.uiDelegate = nil
        self.barcodePickView?.removeListener(viewListener)
        self.barcodePickView?.removeActionListener(actionListener)
        self.barcodePick?.removeScanningListener(scanningListener)
        self.barcodePick?.removeListener(pickListener)
        self.asyncMapperProductProviderCallback = nil
        self.barcodePickView = nil
    }

    public let defaults: DefaultsEncodable = BarcodePickDefaults.shared

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
            guard json.containsKey("BarcodePick"), json.containsKey("View") else {
                result.reject(error: ScanditFrameworksCoreError.deserializationError(error: nil,
                                                                                     json: jsonString))
                return
            }
            let barcodePickJson = json.object(forKey: "BarcodePick")
            let productMapperJson = barcodePickJson.object(forKey: "ProductProvider").jsonString()

            do {
                let delegate = FrameworksBarcodePickAsyncMapperProductProviderCallback(emitter: self.emitter)
                let productProvider = try self.deserializer.asyncMapperProductProvider(fromJSONString: productMapperJson,
                                                                                       delegate: delegate)
                self.asyncMapperProductProviderCallback = delegate
                let barcodePick = try self.deserializer.mode(fromJSONString: barcodePickJson.jsonString(),
                                                             context: context,
                                                             productProvider: productProvider)
                self.barcodePick = barcodePick
                let hasScanningListeners = barcodePickJson.bool(forKey: "hasScanningListeners", default: false)
                let hasModeListeners = barcodePickJson.bool(forKey: "hasListeners", default: false)
                
                if hasModeListeners {
                    self.addBarcodePickListener(result: NoopFrameworksResult())
                }
                if hasScanningListeners {
                    self.addScanningListener()
                }
                
                let barcodePickViewJson = json.object(forKey: "View")
                let hasActionListeners = barcodePickViewJson.bool(forKey: "hasActionListeners", default: false)
                let isStarted = barcodePickViewJson.bool(forKey: "isStarted", default: false)
                let hasViewListeners = barcodePickViewJson.bool(forKey: "hasViewListeners", default: false)
                let hasViewUiListener = barcodePickViewJson.bool(forKey: "hasViewUiListener", default: false)
                barcodePickViewJson.removeKeys(["hasActionListeners", "isStarted", "hasViewListeners", "hasViewUiListener"])
                let barcodePickView = try self.deserializeBarcodePickView(barcodePickViewJson, context: context, mode: barcodePick)
                
                container.addSubview(barcodePickView)
                self.barcodePickView = barcodePickView
                if hasActionListeners {
                    self.addActionListener()
                }
                if hasViewListeners {
                    self.addViewListener()
                }
                if hasViewUiListener {
                    self.addViewUiListener()
                }
                if isStarted {
                    self.viewStart()
                }
                result.success(result: nil)
            } catch let error {
                result.reject(error: ScanditFrameworksCoreError.deserializationError(error: error,
                                                                                     json: nil))
                return
            }
        }
        dispatchMain(block)
    }

    private func deserializeBarcodePickView(
        _ barcodePickViewJson: JSONValue,
        context: DataCaptureContext,
        mode: BarcodePick
    ) throws -> BarcodePickView {
        let viewSettingsJson = barcodePickViewJson.object(forKey: "viewSettings")
        let highlightJson = viewSettingsJson.object(forKey: "highlightStyle")
        let jsonString = barcodePickViewJson.jsonString()

        // Common deserializer parameters
        let baseParams = (
            jsonString: jsonString,
            context: context,
            topLayoutAnchor: nil as NSLayoutYAxisAnchor?,
            mode: mode
        )

        // If not using async provider or type is not specified, use the basic view
        if !highlightJson.bool(forKey: "hasAsyncProvider", default: false) {
            return try self.deserializer.view(fromJSONString: baseParams.jsonString,
                                      context: baseParams.context,
                                      topLayoutAnchor: baseParams.topLayoutAnchor,
                                      mode: baseParams.mode)
        }

        // Handle different highlight style types
        switch highlightJson.optionalString(forKey: "type") {
        case "dotWithIcons", "rectangularWithIcons":
            self.highlightStyleProvider = FrameworksBarcodePickViewHighlightStyleAsyncProvider(emitter: emitter)
            return try self.deserializer.view(fromJSONString: baseParams.jsonString,
                                      context: baseParams.context,
                                      topLayoutAnchor: baseParams.topLayoutAnchor,
                                      mode: baseParams.mode,
                                      viewHighlightStyleDelegate: self.highlightStyleProvider)

        case "customView":
            self.customViewProvider = FrameworksBarcodePickViewHighlightStyleCustomViewProvider(emitter: emitter)
            return try self.deserializer.view(fromJSONString: baseParams.jsonString,
                                      context: baseParams.context,
                                      topLayoutAnchor: baseParams.topLayoutAnchor,
                                      mode: baseParams.mode,
                                      customViewHighlightStyleDelegate: self.customViewProvider)

        default:
            return try self.deserializer.view(fromJSONString: baseParams.jsonString,
                                      context: baseParams.context,
                                      topLayoutAnchor: baseParams.topLayoutAnchor,
                                      mode: baseParams.mode)
        }
    }

    public func updateView(viewJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }
            guard let view = self.barcodePickView else {
                result.reject(code: "-3", message: "BarcodePickView is nil", details: nil)
                return
            }
            do {
                self.barcodePickView = try self.deserializer.update(view, fromJSONString: viewJson)
            } catch let error {
                result.reject(error: error)
                return
            }
        }
        dispatchMain(block)
    }

    public func removeBarcodePickView(result: FrameworksResult) {
        actionListener.disable()
        viewListener.disable()
        viewUiListener.disable()
        barcodePickView?.stop()
        barcodePickView?.removeFromSuperview()
        result.success(result: nil)
    }

    public func addScanningListener() {
        scanningListener.enable()
    }

    public func removeScanningListener() {
        scanningListener.disable()
    }

    public func addActionListener() {
        actionListener.enable()
    }

    public func removeActionListener() {
        actionListener.disable()
    }

    public func addViewListener() {
        viewListener.enable()
    }

    public func removeViewListener() {
        viewListener.disable()
    }

    public func addViewUiListener() {
        viewUiListener.enable()
    }

    public func removeViewUiListener() {
        viewUiListener.disable()
    }

    public func finishProductIdentifierForItems(barcodePickProductProviderCallbackItemsJson: String) {
        asyncMapperProductProviderCallback?.finishMapIdentifiersForEvents(
            itemsJson: barcodePickProductProviderCallbackItemsJson
        )
    }

    public func finishPickAction(data: String, result: Bool) {
        actionListener.finishPickAction(with: data, result: result)
    }

    public func finishPickAction(data: String, result: FrameworksResult) {
        let data = BarcodePickActionData(jsonString: data)
        actionListener.finishPickAction(with: data.pickActionData, result: data.result)
        result.success(result: nil)
    }

    public func viewStart() {
        dispatchMain { [weak self] in self?.barcodePickView?.start() }
    }

    public func viewPause() {
        barcodePickView?.pause()
    }

    public func viewFreeze() {
        barcodePickView?.freeze()
    }

    public func viewStop() {
        barcodePickView?.stop()
    }

    public func addBarcodePickListener(result: FrameworksResult) {
        pickListener.enable()
        result.success()
    }

    public func removeBarcodePickListener(result: FrameworksResult) {
        pickListener.disable()
        result.success()
    }

    public func finishBarcodePickViewHighlightStyleCustomViewProviderViewForRequest(
        response: [String: Any?],
        result: FrameworksResult
    ) {
        guard let requestId = response["requestId"] as? Int else {
            result.success()
            return
        }

        var statusIconStyle: BarcodePickStatusIconStyle?
        
        let responseDict = response["response"] as? [String: Any]
        
        if let statusIconStyleJson = responseDict?["statusIconStyle"] as? String {
            statusIconStyle = BarcodePickStatusIconStyle(jsonString: statusIconStyleJson)
        }

        dispatchMain { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }

            var customView: UIImageView?
            if let viewBytes = responseDict?["view"] as? Data {
                customView = UIImageView()
                if let image = UIImage(data: viewBytes) {
                    customView?.image = image
                }
            }

            self.customViewProvider?.finishViewForRequest(requestId: requestId, view: customView, statusIconStyle: statusIconStyle)
            result.success()
        }
    }
    
    public func finishBarcodePickViewHighlightStyleAsyncProviderStyleForRequest(
        response: [String: Any?],
        result: FrameworksResult
    ) {
        guard let requestId = response["requestId"] as? Int else {
            result.success()
            return
        }
        
        let responseJson = response["response"] as? String
        
        dispatchMain { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }

            self.highlightStyleProvider?.finishStyleForRequest(requestId: requestId, responseJson: responseJson)
            result.success()
        }
    }
}
