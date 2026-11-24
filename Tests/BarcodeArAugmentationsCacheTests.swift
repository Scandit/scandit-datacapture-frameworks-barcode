/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

/// SDC-34119: the eviction path (schedule/cancel/fire) is native-mirroring logic owned by
/// this Swift cache, exercised here through the injected `BarcodeArDeletionScheduler` seam
/// instead of a real `Timer` or a `BarcodeArSession` (which cannot be constructed in a test).
final class BarcodeArAugmentationsCacheTests: XCTestCase {

    func testRemovedBarcode_schedulesDeletion_withoutAnnouncing() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [1])

        XCTAssertEqual(scheduler.scheduledCount, 1)
        XCTAssertEqual(scheduler.delays, [2.0])
        XCTAssertTrue(evicted.isEmpty)
    }

    func testBarcodeReAddedBeforeDelay_cancelsPendingDeletion_withoutAnnouncing() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [1])
        sut.update(added: [(identifier: 2, barcodeId: "a")], removedIdentifiers: [])

        XCTAssertEqual(scheduler.cancelledCount, 1)
        XCTAssertTrue(evicted.isEmpty)
    }

    // On start() after a pause the tracker re-identifies every barcode in view: one session
    // adds it under a new identifier and removes the old one.
    func testBarcodeReIdentifiedInSameSession_isNotEvicted() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [(identifier: 2, barcodeId: "a")], removedIdentifiers: [1])
        scheduler.fireAll()

        XCTAssertTrue(evicted.isEmpty)
    }

    func testBarcodeReIdentifiedBeforeOldIdentifierIsRemoved_isNotEvicted() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [(identifier: 2, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [1])
        scheduler.fireAll()

        XCTAssertTrue(evicted.isEmpty)
    }

    func testReIdentifiedBarcode_isEvictedOnceItsLastIdentifierIsRemoved() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [(identifier: 2, barcodeId: "a")], removedIdentifiers: [1])
        sut.update(added: [], removedIdentifiers: [2])
        scheduler.fireAll()

        XCTAssertEqual(evicted, ["a"])
    }

    func testFiringScheduledDeletion_announcesOnEvictedExactlyOnce() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [1])
        scheduler.fireAll()

        XCTAssertEqual(evicted, ["a"])
    }

    func testFiringScheduledDeletion_clearsAnnotationHighlightAndProviderCallbacks() {
        let scheduler = FakeDeletionScheduler()
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { _ in })
        let barcode = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "1234"))

        sut.addAnnotation(barcodeId: "a", annotation: FakeAnnotation())
        sut.addHighlight(barcodeId: "a", highlight: FakeHighlight())
        sut.addAnnotationProviderCallback(
            barcodeId: "a",
            callback: AnnotationCallbackData(barcode: barcode, callback: { _ in })
        )
        sut.addHighlightProviderCallback(
            barcodeId: "a",
            callback: HighlightCallbackData(barcode: barcode, callback: { _ in })
        )

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [1])
        scheduler.fireAll()

        XCTAssertNil(sut.getAnnotation(barcodeId: "a"))
        XCTAssertNil(sut.getHighlight(barcodeId: "a"))
        XCTAssertNil(sut.getAnnotationProviderCallback(barcodeId: "a"))
        XCTAssertNil(sut.getHighlightProviderCallback(barcodeId: "a"))
    }

    func testClear_cancelsPendingDeletion_insteadOfAnnouncing() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [1])
        sut.clear()

        XCTAssertEqual(scheduler.cancelledCount, 1)
        XCTAssertTrue(evicted.isEmpty)
    }

    func testTrackedBarcodeMapping_cachesTheBarcodeUniqueId() {
        let scheduler = FakeDeletionScheduler()
        var evicted: [BarcodeId] = []
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { evicted.append($0) })
        let tracked = TrackedBarcode(
            trackedBarcodeInfo: TrackedBarcodeInfo(symbology: .code128, data: "1234")
        )

        sut.update(addedTrackedBarcodes: [tracked], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [tracked.identifier])
        scheduler.fireAll()

        XCTAssertEqual(evicted, [tracked.barcode.uniqueId])
    }

    func testFiredDeletion_isDroppedFromMarkedForDeletion() {
        // Asserted indirectly: a stale retained entry would be cancelled when re-scheduled
        // for the same id; a dropped one is not.
        let scheduler = FakeDeletionScheduler()
        let sut = BarcodeArAugmentationsCache(scheduler: scheduler, onEvicted: { _ in })

        sut.update(added: [(identifier: 1, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [1])
        let firstHandle = scheduler.handles[0]
        scheduler.fireAll()

        sut.update(added: [(identifier: 2, barcodeId: "a")], removedIdentifiers: [])
        sut.update(added: [], removedIdentifiers: [2])

        XCTAssertFalse(firstHandle.wasCancelled)
    }
}

private class FakeHighlight: UIView, BarcodeArHighlight {
    func update(with location: Quadrilateral) {}
}

private class FakeAnnotation: UIView, BarcodeArAnnotation {
    var annotationTrigger: BarcodeArAnnotationTrigger = .highlightTap

    func update(with location: Quadrilateral, highlight: (UIView & BarcodeArHighlight)?) {}
}

private class FakeScheduledDeletion: ScheduledDeletion {
    private(set) var wasCancelled = false

    func cancel() {
        wasCancelled = true
    }
}

/// Buffers scheduled blocks instead of firing them, mirroring Android's `FakeMainThread`.
private class FakeDeletionScheduler: BarcodeArDeletionScheduler {
    private(set) var handles: [FakeScheduledDeletion] = []
    private var pending: [() -> Void] = []
    private(set) var cancelledCount = 0
    private(set) var delays: [TimeInterval] = []

    var scheduledCount: Int { handles.count }

    func onMain(_ block: @escaping () -> Void) {
        block()
    }

    func schedule(after delay: TimeInterval, _ block: @escaping () -> Void) -> ScheduledDeletion {
        let handle = FakeScheduledDeletion()
        handles.append(handle)
        delays.append(delay)
        pending.append(block)
        return TrackingHandle(inner: handle) { [weak self] in self?.cancelledCount += 1 }
    }

    func fireAll() {
        let blocks = pending
        pending.removeAll()
        blocks.forEach { $0() }
    }
}

/// Wraps a `FakeScheduledDeletion` so cancellation both marks the handle and counts on the
/// scheduler, without the cache needing to know about either.
private class TrackingHandle: ScheduledDeletion {
    private let inner: FakeScheduledDeletion
    private let onCancel: () -> Void

    init(inner: FakeScheduledDeletion, onCancel: @escaping () -> Void) {
        self.inner = inner
        self.onCancel = onCancel
    }

    func cancel() {
        inner.cancel()
        onCancel()
    }
}
