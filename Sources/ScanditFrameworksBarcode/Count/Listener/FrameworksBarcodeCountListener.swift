/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeCountListenerEvent: String, CaseIterable {
    case barcodeScanned = "BarcodeCountListener.onScan"
    case sessionUpdated = "BarcodeCountListener.didUpdateSession"
}

private extension Emitter {
    func hasViewSpecificListenersForEvent(
        _ viewId: Int,
        for event: FrameworksBarcodeCountListenerEvent
    ) -> Bool {
        hasViewSpecificListenersForEvent(viewId, for: event.rawValue)
    }
}

open class FrameworksBarcodeCountListener: NSObject, BarcodeCountListener {
    private static let asyncTimeoutInterval: TimeInterval = 600  // 10 mins
    private static let defaultTimeoutInterval: TimeInterval = 2
    private let emitter: Emitter
    private let viewId: Int
    private let barcodeScannedEvent = EventWithResult<Bool>(
        event: Event(name: FrameworksBarcodeCountListenerEvent.barcodeScanned.rawValue)
    )
    private let sessionUpdatedEvent = EventWithResult<Bool>(
        event: Event(name: FrameworksBarcodeCountListenerEvent.sessionUpdated.rawValue)
    )

    private let isEnabled = AtomicValue<Bool>(false)

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func enable() {
        isEnabled.value = true
        barcodeScannedEvent.open()
        sessionUpdatedEvent.open()
    }

    // The mode removes listeners asynchronously, so callbacks can still arrive after
    // removal was requested; the flag makes the deactivation take effect immediately,
    // and closing the events unblocks an emit already waiting for a response that can
    // no longer arrive.
    public func disable() {
        isEnabled.value = false
        barcodeScannedEvent.close()
        sessionUpdatedEvent.close()
    }

    private var lastSession: BarcodeCountSession?

    func reset() {
        disable()
        lastSession = nil
    }

    public func enableAsync() {
        barcodeScannedEvent.timeout = Self.asyncTimeoutInterval
    }

    public func disableAsync() {
        barcodeScannedEvent.timeout = Self.defaultTimeoutInterval
    }

    public func barcodeCount(
        _ barcodeCount: BarcodeCount,
        didScanIn session: BarcodeCountSession,
        frameData: FrameData
    ) {
        // The emit below blocks the engine's callback thread until the framework side responds
        // (or the timeout elapses), so it must only run when someone is listening.
        guard isEnabled.value, emitter.hasViewSpecificListenersForEvent(viewId, for: .barcodeScanned) else {
            return
        }
        lastSession = session

        let frameId = LastFrameData.shared.addToCache(frameData: frameData)

        barcodeScannedEvent.emit(
            on: emitter,
            payload: [
                "session": session.jsonString,
                "frameId": frameId,
                "viewId": self.viewId,
            ],
            default: barcodeCount.isEnabled
        )

        LastFrameData.shared.removeFromCache(frameId: frameId)
    }

    public func barcodeCount(
        _ barcodeCount: BarcodeCount,
        didUpdate session: BarcodeCountSession,
        frameData: FrameData
    ) {
        // The emit below blocks the engine's callback thread until the framework side responds
        // (or the timeout elapses), so it must only run when someone is listening.
        guard isEnabled.value, emitter.hasViewSpecificListenersForEvent(viewId, for: .sessionUpdated) else {
            return
        }
        lastSession = session

        let frameId = LastFrameData.shared.addToCache(frameData: frameData)

        sessionUpdatedEvent.emit(
            on: emitter,
            payload: [
                "session": session.jsonString,
                "frameId": frameId,
                "viewId": self.viewId,
            ],
            default: barcodeCount.isEnabled
        )

        LastFrameData.shared.removeFromCache(frameId: frameId)
    }

    func finishDidScan(enabled: Bool) {
        barcodeScannedEvent.unlock(value: enabled)
    }

    func finishDidUpdateSession(enabled: Bool) {
        sessionUpdatedEvent.unlock(value: enabled)
    }

    func resetSession(frameSequenceId: Int?) {
        guard let session = lastSession else { return }
        if frameSequenceId == nil || session.frameSequenceId == frameSequenceId {
            session.reset()
        }
    }

    func getSpatialMap() -> BarcodeSpatialGrid? {
        guard let session = lastSession else { return nil }
        return session.spatialMap()
    }

    func getSpatialMap(expectedNumberOfRows: Int, expectedNumberOfColumns: Int) -> BarcodeSpatialGrid? {
        guard let session = lastSession else { return nil }
        return session.spatialMap(
            withExpectedNumberOfRows: expectedNumberOfRows,
            expectedNumberOfColumns: expectedNumberOfColumns
        )
    }
}
