/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditFrameworksCore

final class BarcodeArRecordingEmitter: Emitter {
    private let lock = NSLock()
    private var recorded: [(name: String, payload: [String: Any?])] = []

    var emissions: [(name: String, payload: [String: Any?])] {
        lock.lock()
        defer { lock.unlock() }
        return recorded
    }

    /// Values of `key` across every update addressed to `viewId`, in emission order.
    func updateValues(_ key: String, forView viewId: Int) -> [String] {
        emissions
            .filter { $0.payload["viewId"] as? Int == viewId }
            .flatMap { ($0.payload["updates"] as? [[String: Any]] ?? []).compactMap { $0[key] as? String } }
    }

    func emit(name: String, payload: [String: Any?]) {
        lock.lock()
        defer { lock.unlock() }
        recorded.append((name, payload))
    }

    func hasListener(for event: String) -> Bool { true }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { true }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { true }
}
