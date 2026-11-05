/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksSparkScanViewUIEvent: String, CaseIterable {
    case barcodeFindButtonTapped = "SparkScanViewUiListener.barcodeFindButtonTapped"
    case barcodeCountButtonTapped = "SparkScanViewUiListener.barcodeCountButtonTapped"
    case labelCaptureButtonTapped = "SparkScanViewUiListener.labelCaptureButtonTapped"
    case didChangeViewState = "SparkScanViewUiListener.didChangeViewState"
    case didChangeScanningMode = "SparkScanViewUiListener.didChangeScanningMode"
}

fileprivate extension Event {
    init(_ event: FrameworksSparkScanViewUIEvent) {
        self.init(name: event.rawValue)
    }
}

open class FrameworksSparkScanViewUIListener: NSObject, SparkScanViewUIDelegate {

    private let emitter: Emitter
    private let viewId: Int

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    private let didChangeViewStateEvent = Event(.didChangeViewState)
    private let barcodeFindButtonTappedEvent = Event(.barcodeFindButtonTapped)
    private let barcodeCountButtonTappedEvent = Event(.barcodeCountButtonTapped)
    private let labelCaptureButtonTappedEvent = Event(.labelCaptureButtonTapped)
    private let didChangeScanningModeEvent = Event(.didChangeScanningMode)

    private var isEnabled = AtomicValue<Bool>()

    public func enable() {
        isEnabled.value = true
    }

    public func disable() {
        isEnabled.value = false
    }

    public func sparkScanView(_ view: SparkScanView, didChange viewState: SparkScanViewState) {
        guard isEnabled.value, emitter.hasViewSpecificListenersForEvent(viewId: viewId, for: didChangeViewStateEvent)
        else { return }
        didChangeViewStateEvent.emit(
            on: emitter,
            payload: SchemaTypes.SparkScanViewUiListenerDidChangeViewState(
                state: viewState.jsonString,
                viewId: viewId
            ).toDictionary()
        )
    }

    public func barcodeCountButtonTapped(in view: SparkScanView) {
        guard isEnabled.value,
            emitter.hasViewSpecificListenersForEvent(viewId: viewId, for: barcodeCountButtonTappedEvent)
        else { return }
        barcodeCountButtonTappedEvent.emit(
            on: emitter,
            payload: SchemaTypes.SparkScanViewUiListenerBarcodeCountButtonTapped(viewId: viewId).toDictionary()
        )
    }

    public func barcodeFindButtonTapped(in view: SparkScanView) {
        guard isEnabled.value,
            emitter.hasViewSpecificListenersForEvent(viewId: viewId, for: barcodeFindButtonTappedEvent)
        else { return }
        barcodeFindButtonTappedEvent.emit(
            on: emitter,
            payload: SchemaTypes.SparkScanViewUiListenerBarcodeFindButtonTapped(viewId: viewId).toDictionary()
        )
    }

    public func labelCaptureButtonTapped(in view: SparkScanView) {
        guard isEnabled.value,
            emitter.hasViewSpecificListenersForEvent(viewId: viewId, for: labelCaptureButtonTappedEvent)
        else { return }
        labelCaptureButtonTappedEvent.emit(
            on: emitter,
            payload: SchemaTypes.SparkScanViewUiListenerLabelCaptureButtonTapped(viewId: viewId).toDictionary()
        )
    }

    public func sparkScanView(_ view: SparkScanView, didChange scanningMode: SparkScanScanningMode) {
        guard isEnabled.value,
            emitter.hasViewSpecificListenersForEvent(viewId: viewId, for: didChangeScanningModeEvent)
        else { return }
        didChangeScanningModeEvent.emit(
            on: emitter,
            payload: SchemaTypes.SparkScanViewUiListenerDidChangeScanningMode(
                scanningMode: scanningMode.jsonString,
                viewId: viewId
            ).toDictionary()
        )
    }
}
