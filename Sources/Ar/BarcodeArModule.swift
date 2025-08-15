/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class BarcodeArModule: NSObject, FrameworkModule, DeserializationLifeCycleObserver {
    private let barcodeArListener: FrameworksBarcodeArListener
    private let barcodeArViewUiDelegate: FrameworksBarcodeArViewUiListener
    private let deserializer: BarcodeArDeserializer
    private let viewDeserialzier: BarcodeArViewDeserializer
    private let highlightProvider: FrameworksBarcodeArHighlightProvider
    private let annotationProvider: FrameworksBarcodeArAnnotationProvider
    private let augmentationsCache: BarcodeArAugmentationsCache
    private let captureContext = DefaultFrameworksCaptureContext.shared

    public init(emitter: Emitter) {
        self.deserializer = BarcodeArDeserializer()
        self.viewDeserialzier = BarcodeArViewDeserializer()
        self.augmentationsCache = BarcodeArAugmentationsCache()

        self.barcodeArViewUiDelegate = FrameworksBarcodeArViewUiListener(emitter: emitter)
        self.barcodeArListener = FrameworksBarcodeArListener(emitter: emitter, cache: augmentationsCache)
        self.highlightProvider = FrameworksBarcodeArHighlightProvider(
            emitter: emitter,
            parser: BarcodeArHighlightParser(emitter: emitter),
            cache: augmentationsCache
        )
        let infoAnnotationDelegate = FrameworksInfoAnnotationDelegate(emitter: emitter)
        let popoverAnnotationDelegate = FrameworksPopoverAnnotationDelegate(emitter: emitter)
        self.annotationProvider = FrameworksBarcodeArAnnotationProvider(
            emitter: emitter,
            parser: BarcodeArAnnotationParser(
                infoAnnotationDelegate: infoAnnotationDelegate,
                popoverAnnotationDelegate: popoverAnnotationDelegate,
                cache: augmentationsCache
            ),
            cache: augmentationsCache
        )
    }

    public var barcodeArView: BarcodeArView?

    private var barcodeAr: BarcodeAr? {
        willSet {
            barcodeAr?.removeListener(barcodeArListener)
        }
        didSet {
            barcodeAr?.addListener(barcodeArListener)
        }
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
        if let view = self.barcodeArView {
            view.stop()
            view.uiDelegate = nil
            view.highlightProvider = nil
            view.annotationProvider = nil
            view.removeFromSuperview()
        }
        self.barcodeArView = nil

        self.barcodeAr?.removeListener(barcodeArListener)
        self.barcodeAr = nil
    }

    public let defaults: DefaultsEncodable = BarcodeArDefaults.shared

    public func registerBarcodeArViewUiListener(result: FrameworksResult) {
        self.barcodeArView?.uiDelegate = self.barcodeArViewUiDelegate
        result.success()
    }

    public func unregisterBarcodeArViewUiListener(result: FrameworksResult) {
        self.barcodeArView?.uiDelegate = nil
        result.success()
    }

    public func registerBarcodeArHighlightProvider(result: FrameworksResult) {
        self.barcodeArView?.highlightProvider = self.highlightProvider
        result.success()
    }

    public func unregisterBarcodeArHighlightProvider(result: FrameworksResult) {
        self.barcodeArView?.highlightProvider = nil
        result.success()
    }

    public func registerBarcodeArAnnotationProvider(result: FrameworksResult) {
        self.barcodeArView?.annotationProvider = self.annotationProvider
        result.success()
    }

    public func unregisterBarcodeArAnnotationProvider(result: FrameworksResult) {
        self.barcodeArView?.annotationProvider = nil
        result.success()
    }

    public func updateFeedback(feedbackJson: String, result: FrameworksResult) {
        do {
            barcodeAr?.feedback = try BarcodeArFeedback(fromJSONString: feedbackJson)
            result.success(result: nil)
        } catch {
            result.reject(error: error)
        }
    }

    public func resetLatestBarcodeArSession(result: FrameworksResult) {
        barcodeArListener.resetSession()
        result.success()
    }

    public func applyBarcodeArModeSettings(modeSettingsJson: String, result: FrameworksResult) {
        guard let mode = barcodeAr else {
            result.success()
            return
        }

        do {
            let settings = try self.deserializer.settings(fromJSONString: modeSettingsJson)
            mode.apply(settings)

            result.success()
        } catch {
            result.reject(error: error)
        }
    }

    public func addModeListener(result: FrameworksResult) {
        barcodeArListener.enable()
        result.success()
    }

    public func removeModeListener(result: FrameworksResult) {
        barcodeArListener.disable()
        result.success()
    }

    public func finishDidUpdateSession(result: FrameworksResult) {
        barcodeArListener.finishDidUpdateSession()
        result.success()
    }

    public func getLastFrameDataBytes(frameId: String, result: FrameworksResult) {
        LastFrameData.shared.getLastFrameDataBytes(frameId: frameId) {
            result.success(result: $0)
        }
    }

    public func finishHighlightForBarcode(highlightJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                return
            }
            self.highlightProvider.finishHighlightForBarcode(highlightJson: highlightJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func finishAnnotationForBarcode(annotationJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                return
            }
            self.annotationProvider.finishAnnotationForBarcode(annotationJson: annotationJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func updateBarcodeArPopoverButtonAtIndex(updateJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                return
            }
            self.annotationProvider.updateBarcodeArPopoverButtonAtIndex(updateJson: updateJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func updateHighlight(highlightJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                return
            }
            self.highlightProvider.updateHighlight(highlightJson: highlightJson)
        }
        dispatchMain(block)
        result.success()
    }

    public func updateAnnotation(annotationJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                return
            }
            self.annotationProvider.updateAnnotation(annotationJson: annotationJson)
        }
        dispatchMain(block)
        result.success()
    }
}

public extension BarcodeArModule {

    // swiftlint:disable function_body_length
    func addViewToContainer(container: UIView, jsonString: String, result: FrameworksResult) {
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
            guard json.containsKey("BarcodeAr"), json.containsKey("View") else {
                result.reject(error: ScanditFrameworksCoreError.deserializationError(error: nil,
                                                                                     json: jsonString))
                return
            }
            let barcodeArJson = json.object(forKey: "BarcodeAr")

            do {
                let barcodeAr = try self.deserializer.mode(fromJSONString: barcodeArJson.jsonString(),
                                                             context: context)
                self.barcodeAr = barcodeAr

                let barcodeArViewJson = json.object(forKey: "View")
                let hasUiListener = barcodeArViewJson.bool(forKey: "hasUiListener", default: false)
                let hasHighlightProvider = barcodeArViewJson.bool(forKey: "hasHighlightProvider", default: false)
                let hasAnnotationProvider = barcodeArViewJson.bool(forKey: "hasAnnotationProvider", default: false)
                let isStarted = barcodeArViewJson.bool(forKey: "isStarted", default: false)

                barcodeArViewJson.removeKeys(
                    ["hasUiListener", "hasHighlightProvider", "hasAnnotationProvider", "isStarted"]
                )
                let barcodeArView = try self.viewDeserialzier.view(
                    fromJSONString: barcodeArViewJson.jsonString(),
                    parentView: container,
                    mode: barcodeAr
                )

                self.barcodeArView = barcodeArView
                if hasUiListener {
                    self.registerBarcodeArViewUiListener(result: NoopFrameworksResult())
                }
                if hasHighlightProvider {
                    self.registerBarcodeArHighlightProvider(result: NoopFrameworksResult())
                }
                if hasAnnotationProvider {
                    self.registerBarcodeArAnnotationProvider(result: NoopFrameworksResult())
                }
                if isStarted {
                    self.viewStart(result: NoopFrameworksResult())
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
    // swiftlint:enable function_body_length

    func updateView(viewJson: String, result: FrameworksResult) {
        let block = { [weak self] in
            guard let self = self else {
                result.reject(error: ScanditFrameworksCoreError.nilSelf)
                return
            }
            guard let view = self.barcodeArView else {
                result.reject(code: "-3", message: "BarcodeArView is nil", details: nil)
                return
            }
            do {
                self.barcodeArView = try self.viewDeserialzier.update(view, fromJSONString: viewJson)
            } catch let error {
                result.reject(error: error)
                return
            }
        }
        dispatchMain(block)
    }

    func viewStart(result: FrameworksResult) {
        self.barcodeArView?.start()
        result.success()
    }

    func viewStop(result: FrameworksResult) {
        self.barcodeArView?.stop()
        result.success()
    }

    func viewPause(result: FrameworksResult) {
        self.barcodeArView?.pause()
        result.success()
    }
    
    func viewReset(result: FrameworksResult) {
        self.barcodeArView?.reset()
        result.success()
    }
}
