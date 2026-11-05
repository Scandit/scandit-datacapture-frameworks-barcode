/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeArEmitBatcherTests: XCTestCase {
    private let event = "test.update"

    private func makeSut(
        scheduler: FakeMainScheduler,
        interval: TimeInterval = 0.033,
        now: @escaping () -> TimeInterval = { 1_000 }
    ) -> BarcodeArEmitBatcher {
        BarcodeArEmitBatcher(updateEventName: event, scheduler: scheduler, emitInterval: interval, now: now)
    }

    func testSubmitsFromDifferentViews_neverSharePendingUpdates() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = FakeMainScheduler()
        let sut = makeSut(scheduler: scheduler)

        sut.submit(emitter: emitter, viewId: 1, payload: ["id": "a"])
        sut.submit(emitter: emitter, viewId: 2, payload: ["id": "b"])
        sut.submit(emitter: emitter, viewId: 1, payload: ["id": "c"])
        scheduler.fireAll()

        XCTAssertEqual(emitter.emissions.count, 2)
        XCTAssertEqual(emitter.updateValues("id", forView: 1), ["a", "c"])
        XCTAssertEqual(emitter.updateValues("id", forView: 2), ["b"])
    }

    func testMultipleSubmitsWithinInterval_coalesceIntoOneEmissionPerView() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = FakeMainScheduler()
        let sut = makeSut(scheduler: scheduler)

        sut.submit(emitter: emitter, viewId: 7, payload: ["id": "a"])
        sut.submit(emitter: emitter, viewId: 7, payload: ["id": "b"])
        sut.submit(emitter: emitter, viewId: 7, payload: ["id": "c"])
        scheduler.fireAll()

        XCTAssertEqual(emitter.emissions.count, 1)
        XCTAssertEqual(emitter.emissions[0].name, event)
        XCTAssertEqual(emitter.updateValues("id", forView: 7), ["a", "b", "c"])
    }

    func testConcurrentSubmitsToTheSameView_doNotLoseUpdates() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = FakeMainScheduler()
        let sut = makeSut(scheduler: scheduler)
        let threads = 8
        let perThread = 125

        DispatchQueue.concurrentPerform(iterations: threads) { thread in
            for i in 0..<perThread {
                sut.submit(emitter: emitter, viewId: 99, payload: ["id": "\(thread)-\(i)"])
                if i % 50 == 0 { scheduler.fireAll() }
            }
        }
        scheduler.fireAll()

        XCTAssertEqual(emitter.updateValues("id", forView: 99).count, threads * perThread)
    }

    func testDelay_isZeroWhenIntervalHasAlreadyElapsed() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = FakeMainScheduler()
        let sut = makeSut(scheduler: scheduler, now: { 10_000 })

        sut.submit(emitter: emitter, viewId: 1, payload: ["id": "a"])

        XCTAssertEqual(scheduler.delays, [0])
    }

    func testDelay_isRemainingIntervalAfterRecentEmission() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = FakeMainScheduler()
        var clock: TimeInterval = 1_000
        let sut = makeSut(scheduler: scheduler, interval: 0.5, now: { clock })

        sut.submit(emitter: emitter, viewId: 1, payload: ["id": "a"])
        scheduler.fireAll()
        clock = 1_000.25
        sut.submit(emitter: emitter, viewId: 1, payload: ["id": "b"])

        XCTAssertEqual(scheduler.delays.last ?? -1, 0.25, accuracy: 0.0001)
    }

    func testSubmitAfterFlush_startsNewBatchWithoutReplayingOldUpdates() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = FakeMainScheduler()
        let sut = makeSut(scheduler: scheduler)

        sut.submit(emitter: emitter, viewId: 3, payload: ["id": "a"])
        scheduler.fireAll()
        sut.submit(emitter: emitter, viewId: 3, payload: ["id": "b"])
        scheduler.fireAll()

        let batches = emitter.emissions.map {
            ($0.payload["updates"] as? [[String: Any]] ?? []).compactMap { $0["id"] as? String }
        }
        XCTAssertEqual(batches, [["a"], ["b"]])
    }

    func testRecentEmissionOnOneView_doesNotDelayFirstEmissionOnAnotherView() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = FakeMainScheduler()
        var clock: TimeInterval = 1_000
        let sut = makeSut(scheduler: scheduler, interval: 0.5, now: { clock })

        sut.submit(emitter: emitter, viewId: 1, payload: ["id": "a"])
        scheduler.fireAll()
        clock = 1_000.1
        sut.submit(emitter: emitter, viewId: 2, payload: ["id": "b"])

        XCTAssertEqual(scheduler.delays.last ?? -1, 0, accuracy: 0.0001)
    }

    func testSubmit_schedulesOnlyAfterHoppingToMain() {
        let emitter = BarcodeArRecordingEmitter()
        let scheduler = DeferredMainScheduler()
        let sut = BarcodeArEmitBatcher(
            updateEventName: event,
            scheduler: scheduler,
            emitInterval: 0.033,
            now: { 1_000 }
        )

        sut.submit(emitter: emitter, viewId: 1, payload: ["id": "a"])
        XCTAssertEqual(scheduler.scheduleCount, 0)

        scheduler.runMain()
        XCTAssertEqual(scheduler.scheduleCount, 1)
    }
}

/// `onMain` buffers its block until `runMain()`; `schedule` only counts.
private class DeferredMainScheduler: BarcodeArDeletionScheduler {
    private struct NoopHandle: ScheduledDeletion {
        func cancel() {}
    }

    private var mainBlocks: [() -> Void] = []
    private(set) var scheduleCount = 0

    func onMain(_ block: @escaping () -> Void) {
        mainBlocks.append(block)
    }

    func schedule(after delay: TimeInterval, _ block: @escaping () -> Void) -> ScheduledDeletion {
        scheduleCount += 1
        return NoopHandle()
    }

    func runMain() {
        let blocks = mainBlocks
        mainBlocks.removeAll()
        blocks.forEach { $0() }
    }
}

/// Thread-safe: runs `onMain` inline and buffers scheduled blocks until `fireAll()`.
private class FakeMainScheduler: BarcodeArDeletionScheduler {
    private struct NoopHandle: ScheduledDeletion {
        func cancel() {}
    }

    private let lock = NSLock()
    private var pending: [() -> Void] = []
    private var recordedDelays: [TimeInterval] = []

    var delays: [TimeInterval] {
        lock.lock()
        defer { lock.unlock() }
        return recordedDelays
    }

    func onMain(_ block: @escaping () -> Void) {
        block()
    }

    func schedule(after delay: TimeInterval, _ block: @escaping () -> Void) -> ScheduledDeletion {
        lock.lock()
        defer { lock.unlock() }
        recordedDelays.append(delay)
        pending.append(block)
        return NoopHandle()
    }

    func fireAll() {
        lock.lock()
        let blocks = pending
        pending.removeAll()
        lock.unlock()
        blocks.forEach { $0() }
    }
}
