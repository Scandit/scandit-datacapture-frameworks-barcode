/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum BarcodeArListenerEvents: String, CaseIterable {
    case didUpdateSession = "BarcodeArListener.didUpdateSession"
}

fileprivate extension Event {
    init(_ event: BarcodeArListenerEvents) {
        self.init(name: event.rawValue)
    }
}

fileprivate extension Emitter {
    func hasListener(for event: BarcodeArListenerEvents) -> Bool {
        hasListener(for: event.rawValue)
    }
}

open class FrameworksBarcodeArListener: NSObject, BarcodeArListener {
    private let emitter: Emitter
    private var isEnabled = AtomicBool()

    private let sessionUpdatedEvent = EventWithResult<Bool>(event: Event(BarcodeArListenerEvents.didUpdateSession))

    private var latestSession: BarcodeArSession?

    private let cache: BarcodeArAugmentationsCache

    public init(emitter: Emitter, cache: BarcodeArAugmentationsCache) {
        self.emitter = emitter
        self.cache = cache
    }

    public func enable() {
        if isEnabled.value { return }
        isEnabled.value = true
    }

    public func disable() {
        guard isEnabled.value else { return }
        isEnabled.value = false
    }

    public func barcodeAr(
        _ barcodeAr: BarcodeAr, didUpdate session: BarcodeArSession, frameData: any FrameData
    ) {
        guard isEnabled.value, emitter.hasListener(for: BarcodeArListenerEvents.didUpdateSession) else { return }
        latestSession = session
        cache.updateFromSession(session)

        let frameId = LastFrameData.shared.addToCache(frameData: frameData)

        sessionUpdatedEvent.emit(
            on: emitter,
            payload: [
                "session": session.jsonString,
                "frameId": frameId
            ]
        )

        LastFrameData.shared.removeFromCache(frameId: frameId)
    }

    public func finishDidUpdateSession() {
        sessionUpdatedEvent.unlock(value: true)
    }

    public func resetSession() {
        latestSession?.reset()
    }
}
