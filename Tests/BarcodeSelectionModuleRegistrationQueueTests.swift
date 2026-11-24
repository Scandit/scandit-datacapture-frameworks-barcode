/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

/// Regression coverage for SDC-32821: `registerBarcodeSelectionListenerForEvents` used
/// to optional-chain into `getModeFromCache(modeId)` and, when the mode wasn't cached
/// yet (new-architecture creation racing the JS registration call), silently no-op
/// while still reporting success via `successAndKeepCallback`. JS believed it
/// registered; no events ever fired.
///
/// A real FrameworksBarcodeSelectionMode can't be exercised through the cache-hit path
/// in a unit test (deserializing a mode needs a live, licensed DataCaptureContext), so
/// this verifies the fix at the retry-queue boundary, mirroring the already-fixed
/// sibling `BarcodeBatchModule.registerBarcodeBatchListenerForEvents`: on a cache miss
/// the call must re-invoke itself via `addPostModeCreationAction` once the mode is
/// created, and must NOT resolve the bridge callback at all in the meantime (holding
/// the closure's captured `result` is what lets the retry eventually resolve it).
private class SpyFrameworksResult: FrameworksResult {
    private(set) var successCallCount = 0
    private(set) var successAndKeepCallbackCallCount = 0

    func success(result: Any?) {
        successCallCount += 1
    }

    func successAndKeepCallback(result: Any?) {
        successAndKeepCallbackCallCount += 1
    }

    func reject(code: String, message: String?, details: Any?) {}
    func reject(error: Error) {}
}

private class NoopEmitter: Emitter {
    func emit(name: String, payload: [String: Any?]) {}
    func hasListener(for event: String) -> Bool { false }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { false }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { false }
}

final class BarcodeSelectionModuleRegistrationQueueTests: XCTestCase {

    private func makeModule() -> BarcodeSelectionModule {
        let emitter = NoopEmitter()
        return BarcodeSelectionModule(
            emitter: emitter,
            aimedBrushProvider: FrameworksBarcodeSelectionAimedBrushProvider(emitter: emitter),
            trackedBrushProvider: FrameworksBarcodeSelectionTrackedBrushProvider(emitter: emitter)
        )
    }

    func testRegisterListenerForEventsBeforeModeExistsQueuesRetryInsteadOfReportingSuccess() {
        let module = makeModule()
        let result = SpyFrameworksResult()
        // A modeId guaranteed not to be in this fresh module's mode cache.
        let modeId = Int.max - 12345

        module.registerBarcodeSelectionListenerForEvents(modeId: modeId, result: result)

        // The bug: success was reported unconditionally even though no listener was
        // attached and nothing was queued to retry once the mode is created.
        XCTAssertEqual(
            result.successCallCount,
            0,
            "must not resolve via success() before the mode exists"
        )
        XCTAssertEqual(
            result.successAndKeepCallbackCallCount,
            0,
            "must not resolve the bridge callback before the mode exists - the retried "
                + "call (once the mode is created) is what resolves it, matching "
                + "BarcodeBatchModule.registerBarcodeBatchListenerForEvents"
        )

        let queuedActions = module.getPostModeCreationActions(modeId)
        XCTAssertEqual(
            queuedActions.count,
            1,
            "must queue exactly one retry action via addPostModeCreationAction, "
                + "matching BarcodeBatchModule.registerBarcodeBatchListenerForEvents"
        )

        // Draining above already removed the entry; a second read must come back empty.
        XCTAssertEqual(
            module.getPostModeCreationActions(modeId).count,
            0,
            "the queue must be drained by the first read"
        )
    }
}
