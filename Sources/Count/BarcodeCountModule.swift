/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public class BarcodeCountModule: NSObject, FrameworkModule, DeserializationLifeCycleObserver {
    private let barcodeCountListener: FrameworksBarcodeCountListener
    private let captureListListener: FrameworksBarcodeCountCaptureListListener
    private let viewListener: FrameworksBarcodeCountViewListener
    private let viewUiListener: FrameworksBarcodeCountViewUIListener
    private let barcodeCountDeserializer: BarcodeCountDeserializer
    private let barcodeCountViewDeserializer: BarcodeCountViewDeserializer

    public init(barcodeCountListener: FrameworksBarcodeCountListener,
                captureListListener: FrameworksBarcodeCountCaptureListListener,
                viewListener: FrameworksBarcodeCountViewListener,
                viewUiListener: FrameworksBarcodeCountViewUIListener,
                barcodeCountDeserializer: BarcodeCountDeserializer = BarcodeCountDeserializer(),
                barcodeCountViewDeserializer: BarcodeCountViewDeserializer = BarcodeCountViewDeserializer()) {
        self.barcodeCountListener = barcodeCountListener
        self.captureListListener = captureListListener
        self.viewListener = viewListener
        self.viewUiListener = viewUiListener
        self.barcodeCountDeserializer = barcodeCountDeserializer
        self.barcodeCountViewDeserializer = barcodeCountViewDeserializer
    }

    private var context: DataCaptureContext?
    
    private var modeEnabled = true

    public var barcodeCountView: BarcodeCountView?

    private var barcodeCountCaptureList: BarcodeCountCaptureList?

    private var barcodeCount: BarcodeCount? {
        willSet {
            barcodeCount?.removeListener(barcodeCountListener)
        }
        didSet {
            barcodeCount?.addListener(barcodeCountListener)
            if let captureList = barcodeCountCaptureList {
                barcodeCount?.setCaptureList(captureList)
            }
        }
    }

    public func didStart() {
        DeserializationLifeCycleDispatcher.shared.attach(observer: self)
    }

    public func didStop() {
        DeserializationLifeCycleDispatcher.shared.detach(observer: self)
        disposeBarcodeCountView()
    }

    public func dataCaptureContext(deserialized context: DataCaptureContext?) {
        self.context = context
    }

    public let defaults: DefaultsEncodable = BarcodeCountDefaults.shared

    public func addViewFromJson(parent: UIView, viewJson: String) {
        let block = { [weak self] in
            guard let self = self else { return }
            guard let context = self.context else {
                Log.error("Error during the barcode count view deserialization.\nError: The DataCaptureView has not been initialized yet.")
                return
            }
            let json = JSONValue(string: viewJson)
            guard json.containsKey("BarcodeCount") else {
                Log.error("Error during the barcode count view deserialization.\nError: Json string doesn't contain `BarcodeCount`")
                return
            }
            let barcodeCountModeJson = json.object(forKey: "BarcodeCount").jsonString()

            var mode: BarcodeCount
            do {
                mode = try self.barcodeCountDeserializer.mode(fromJSONString: barcodeCountModeJson,
                                                              context: context)
            } catch {
                Log.error("Error during the barcode count view deserialization.\nError:", error: error)
                return
            }
            mode.isEnabled = self.modeEnabled
            self.barcodeCount = mode

            guard json.containsKey("View") else {
                Log.error("Error during the barcode count view deserialization.\nError: Json string doesn't contain `View`")
                return
            }
            let barcodeCountViewJson = json.object(forKey: "View").jsonString()
            do {
                let view = try self.barcodeCountViewDeserializer.view(fromJSONString: barcodeCountViewJson,
                                                                      barcodeCount: mode,
                                                                      context: context)
                view.delegate = self.viewListener
                view.uiDelegate = self.viewUiListener
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                parent.addSubview(view)
                self.barcodeCountView = view
            } catch {
                Log.error("Error during the barcode count view deserialization.\nError:", error: error)
                return
            }
        }
        dispatchMainSync(block)
    }

    public func updateBarcodeCountView(viewJson: String) {
        let block = { [weak self] in
            guard let self = self else { return }
            guard let view = self.barcodeCountView else {
                return
            }
            do {
                self.barcodeCountView = try self.barcodeCountViewDeserializer.update(view, fromJSONString: viewJson)
            } catch {
                return
            }
        }
        dispatchMainSync(block)
    }

    public func updateBarcodeCount(modeJson: String) {
        guard let mode = barcodeCount else { return }
        do {
            barcodeCount = try barcodeCountDeserializer.updateMode(mode, fromJSONString: modeJson)
        } catch {
            return
        }
    }

    public func addBarcodeCountViewListener() {
        dispatchMainSync { [weak self] in
            self?.barcodeCountView?.delegate = self?.viewListener
        }
    }

    public func removeBarcodeCountViewListener() {
        dispatchMainSync { [weak self] in
            self?.barcodeCountView?.delegate = nil
        }
    }

    public func addBarcodeCountViewUiListener() {
        dispatchMainSync { [weak self] in
            self?.barcodeCountView?.uiDelegate = self?.viewUiListener
        }
    }

    public func removeBarcodeCountViewUiListener() {
        dispatchMainSync { [weak self] in
            self?.barcodeCountView?.uiDelegate = nil
        }
    }

    public func clearHighlights() {
        barcodeCountView?.clearHighlights()
    }

    public func finishBrushForRecognizedBarcodeEvent(brush: Brush?, trackedBarcodeId: Int) {
        dispatchMainSync { [weak self] in
            let barcode = self?.viewListener.getTrackedBarcodeForBrush(with: trackedBarcodeId,
                                                                       for: .brushForRecognizedBarcode)
            if let trackedBarcode = barcode, let brush = brush {
                self?.barcodeCountView?.setBrush(brush, forRecognizedBarcode: trackedBarcode)
            }
        }
    }

    public func finishBrushForRecognizedBarcodeNotInListEvent(brush: Brush?, trackedBarcodeId: Int) {
        dispatchMainSync { [weak self] in
            let barcode = self?.viewListener.getTrackedBarcodeForBrush(with: trackedBarcodeId,
                                                                       for: .brushForRecognizedBarcodeNotInList)
            if let trackedBarcode = barcode, let brush = brush {
                self?.barcodeCountView?.setBrush(brush, forRecognizedBarcode: trackedBarcode)
            }
        }
    }

    public func finishBrushForUnrecognizedBarcodeEvent(brush: Brush?, trackedBarcodeId: Int) {
        dispatchMainSync { [weak self] in
            let barcode = self?.viewListener.getTrackedBarcodeForBrush(with: trackedBarcodeId,
                                                                       for: .brushForUnrecognizedBarcode)
            if let trackedBarcode = barcode, let brush = brush {
                self?.barcodeCountView?.setBrush(brush, forRecognizedBarcode: trackedBarcode)
            }
        }
    }

    public func setBarcodeCountCaptureList(barcodesJson: String) {
        let jsonArray = JSONValue(string: barcodesJson).asArray()
        let targetBarcodes = Set((0...jsonArray.count() - 1).map { jsonArray.atIndex($0).asObject() }.map {
            TargetBarcode(data: $0.string(forKey: "data"), quantity: $0.integer(forKey: "quantity"))
        })
        barcodeCountCaptureList = BarcodeCountCaptureList(listener: captureListListener, targetBarcodes: targetBarcodes)
        
        guard let mode = barcodeCount else {
            return
        }
        
        mode.setCaptureList(barcodeCountCaptureList)
    }

    public func resetBarcodeCountSession(frameSequenceId: Int?) {
        barcodeCountListener.resetSession(frameSequenceId: frameSequenceId)
    }

    public func finishOnScan(enabled: Bool) {
        barcodeCountListener.finishDidScan(enabled: enabled)
    }

    public func addBarcodeCountListener() {
        barcodeCountListener.enable()
    }

    public func removeBarcodeCountListener() {
        barcodeCountListener.disable()
    }

    public func resetBarcodeCount() {
        barcodeCount?.reset()
    }

    public func startScanningPhase() {
        barcodeCount?.startScanningPhase()
    }

    public func endScanningPhase() {
        barcodeCount?.endScanningPhase()
    }

    public func disposeBarcodeCountView() {
        barcodeCountView?.delegate = nil
        barcodeCountView?.uiDelegate = nil
        barcodeCountView?.removeFromSuperview()
        barcodeCountView = nil
        barcodeCount?.removeListener(barcodeCountListener)
        barcodeCount = nil
    }
    
    public func getSpatialMap() -> BarcodeSpatialGrid? {
        return barcodeCountListener.getSpatialMap()
    }
    
    public func getSpatialMap(expectedNumberOfRows: Int, expectedNumberOfColumns: Int) -> BarcodeSpatialGrid? {
        return barcodeCountListener.getSpatialMap(expectedNumberOfRows: expectedNumberOfRows, expectedNumberOfColumns: expectedNumberOfColumns)
    }
    
    public func setModeEnabled(enabled: Bool) {
        modeEnabled = enabled
        barcodeCount?.isEnabled = enabled
    }
    
    public func isModeEnabled() -> Bool {
        return barcodeCount?.isEnabled == true
    }
}
