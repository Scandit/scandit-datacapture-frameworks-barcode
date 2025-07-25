/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum BarcodePickListenerEvent: String, CaseIterable {
    case didUpdateSession = "BarcodePickListener.didUpdateSession"
}

open class FrameworksBarcodePickListener: NSObject, BarcodePickListener {
    private let emitter: Emitter
    private var events: [String: (Bool) -> Void] = [:]
    private let coordinator = ReadWriteCoordinator()
    private var hasListener = AtomicBool()

    public init(emitter: Emitter) {
        self.emitter = emitter
    }
    
    public func barcodePick(_ barcodePick: BarcodePick, didUpdate session: BarcodePickSession) {
        guard hasListener.value else { return }
        guard emitter.hasListener(for: BarcodePickListenerEvent.didUpdateSession.rawValue) else { return }
        emitter.emit(
            name: BarcodePickListenerEvent.didUpdateSession.rawValue,
            payload: ["session" : session.jsonString]
        )
    }

    public func enable() {
        if !hasListener.value {
            hasListener.value = true
        }
    }

    public func disable() {
        if hasListener.value {
            hasListener.value = false
        }
    }
}
