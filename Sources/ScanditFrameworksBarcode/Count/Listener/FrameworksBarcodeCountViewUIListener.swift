/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeCountViewUIListenerEvent: String, CaseIterable {
    case exitButtonTapped = "BarcodeCountViewUiListener.onExitButtonTapped"
    case listButtonTapped = "BarcodeCountViewUiListener.onListButtonTapped"
    case singleScanButtonTapped = "BarcodeCountViewUiListener.onSingleScanButtonTapped"
}

open class FrameworksBarcodeCountViewUIListener: NSObject, BarcodeCountViewUIDelegate {
    private let emitter: Emitter
    private let viewId: Int

    private let exitButtonTappedEvent = Event(name: FrameworksBarcodeCountViewUIListenerEvent.exitButtonTapped.rawValue)
    private let listButtonTappedEvent = Event(name: FrameworksBarcodeCountViewUIListenerEvent.listButtonTapped.rawValue)
    private let singleScanButtonTappedEvent = Event(
        name: FrameworksBarcodeCountViewUIListenerEvent.singleScanButtonTapped.rawValue
    )

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func exitButtonTapped(for view: BarcodeCountView) {
        exitButtonTappedEvent.emit(on: emitter, payload: ["viewId": self.viewId])
    }

    public func listButtonTapped(for view: BarcodeCountView) {
        listButtonTappedEvent.emit(on: emitter, payload: ["viewId": self.viewId])
    }

    public func singleScanButtonTapped(for view: BarcodeCountView) {
        singleScanButtonTappedEvent.emit(on: emitter, payload: ["viewId": self.viewId])
    }
}
