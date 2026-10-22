/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import Foundation
import QuartzCore
import ScanditFrameworksCore

internal final class BarcodeArEmitBatcher {
    private final class BatchState {
        var pendingUpdates: [[String: Any]] = []
        var lastEmitTime: TimeInterval = 0
        var hasPendingEmit = false
    }

    private let updateEventName: String
    private let scheduler: BarcodeArDeletionScheduler
    private let emitInterval: TimeInterval
    private let now: () -> TimeInterval
    private let lock = NSLock()
    private var states: [Int: BatchState] = [:]

    init(
        updateEventName: String,
        scheduler: BarcodeArDeletionScheduler = MainRunLoopDeletionScheduler(),
        emitInterval: TimeInterval = 1.0 / 30.0,
        now: @escaping () -> TimeInterval = CACurrentMediaTime
    ) {
        self.updateEventName = updateEventName
        self.scheduler = scheduler
        self.emitInterval = emitInterval
        self.now = now
    }

    func submit(emitter: Emitter, viewId: Int, payload: [String: Any]) {
        guard let delay = enqueue(viewId: viewId, payload: payload) else { return }
        // Timer needs a run loop; the AR thread has none, so hop to main first.
        scheduler.onMain {
            _ = self.scheduler.schedule(after: delay) {
                emitter.emit(
                    name: self.updateEventName,
                    payload: ["updates": self.drain(viewId: viewId), "viewId": viewId]
                )
            }
        }
    }

    /// Returns the delay for a new emit, or nil when one is already pending for this view.
    private func enqueue(viewId: Int, payload: [String: Any]) -> TimeInterval? {
        lock.lock()
        defer { lock.unlock() }
        let state = states[viewId] ?? BatchState()
        if states[viewId] == nil { states[viewId] = state }
        state.pendingUpdates.append(payload)
        guard !state.hasPendingEmit else { return nil }
        state.hasPendingEmit = true
        return max(0, emitInterval - (now() - state.lastEmitTime))
    }

    private func drain(viewId: Int) -> [[String: Any]] {
        lock.lock()
        defer { lock.unlock() }
        guard let state = states[viewId] else { return [] }
        let snapshot = state.pendingUpdates
        state.pendingUpdates.removeAll()
        state.lastEmitTime = now()
        state.hasPendingEmit = false
        return snapshot
    }
}
