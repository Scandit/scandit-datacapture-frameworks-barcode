/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeCountCaptureListListenerEvent: String, CaseIterable {
    case sessionUpdated = "BarcodeCountCaptureListListener.didUpdateSession"
    case captureListCompleted = "BarcodeCountCaptureListListener.didCompleteCaptureList"
}

open class FrameworksBarcodeCountCaptureListListener: NSObject, BarcodeCountCaptureListListener {
    private let emitter: Emitter
    private let viewId: Int
    private let sessionUpdatedEvent = Event(
        name: FrameworksBarcodeCountCaptureListListenerEvent.sessionUpdated.rawValue
    )
    private let captureListCompletedEvent = Event(
        name: FrameworksBarcodeCountCaptureListListenerEvent.captureListCompleted.rawValue
    )

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func captureList(
        _ captureList: BarcodeCountCaptureList,
        didUpdate session: BarcodeCountCaptureListSession
    ) {
        sessionUpdatedEvent.emit(on: emitter, payload: ["session": session.jsonString, "viewId": self.viewId])
    }

    public func captureList(
        _ captureList: BarcodeCountCaptureList,
        didComplete session: BarcodeCountCaptureListSession
    ) {
        captureListCompletedEvent.emit(on: emitter, payload: ["session": session.jsonString, "viewId": self.viewId])
    }
}
