/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

/// Regression coverage for SDC-32821: four BarcodeArModule registration methods
/// (registerBarcodeArFilter, registerBarcodeArViewUiListener,
/// registerBarcodeArHighlightProvider, registerBarcodeArAnnotationProvider) used to
/// optional-chain into `viewCache.getView(viewId:)` and, when the native view wasn't
/// cached yet (new-architecture creation racing the JS registration call), silently
/// no-op while still reporting success via `successAndKeepCallback`. JS believed it
/// registered; no events ever fired.
///
/// A real FrameworksBarcodeArView can't be constructed in a unit test (it needs a
/// live, licensed DataCaptureContext + native view deserialization), so this verifies
/// the fix at the retry-queue boundary, mirroring the already-fixed sibling in this
/// same file, `registerBarcodeArListener`: on a cache miss the call must defer via
/// `addPostSpecificViewCreationAction` instead of completing with no way to retry once
/// the view is created. `registerBarcodeArListener`'s own rationale is that resolving
/// the bridge callback immediately (rather than holding it) is intentional here -
/// holding it would leak the callback if the view is never created - so
/// `successAndKeepCallback` firing on the miss path is the *correct* shape, not the bug;
/// the bug was the missing queue entry.
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

final class BarcodeArModuleRegistrationQueueTests: XCTestCase {

    private func assertQueuesRetryInsteadOfSilentlySucceeding(
        _ register: (BarcodeArModule, Int, FrameworksResult) -> Void,
        viewId: Int,
        line: UInt = #line
    ) {
        let module = BarcodeArModule(emitter: NoopEmitter())
        let result = SpyFrameworksResult()

        register(module, viewId, result)

        XCTAssertEqual(
            result.successCallCount,
            0,
            "must not resolve via success() before the view exists",
            line: line
        )
        XCTAssertEqual(
            result.successAndKeepCallbackCallCount,
            1,
            "must resolve the bridge callback immediately (matching registerBarcodeArListener) "
                + "so a never-created view doesn't leak the promise",
            line: line
        )

        let queuedActions = module.getPostSpecificViewCreationActions(viewId: viewId)
        XCTAssertEqual(
            queuedActions.count,
            1,
            "must queue exactly one retry action via addPostSpecificViewCreationAction, "
                + "matching registerBarcodeArListener",
            line: line
        )

        // Draining above already removed the entry (getPostSpecificViewCreationActions
        // pops it); a second read must come back empty.
        XCTAssertEqual(
            module.getPostSpecificViewCreationActions(viewId: viewId).count,
            0,
            "the queue must be drained by the first read",
            line: line
        )
    }

    func testRegisterBarcodeArFilterBeforeViewExistsQueuesRetryInsteadOfReportingSuccess() {
        assertQueuesRetryInsteadOfSilentlySucceeding(
            { module, viewId, result in module.registerBarcodeArFilter(viewId: viewId, result: result) },
            viewId: Int.max - 1
        )
    }

    func testRegisterBarcodeArViewUiListenerBeforeViewExistsQueuesRetryInsteadOfReportingSuccess() {
        assertQueuesRetryInsteadOfSilentlySucceeding(
            { module, viewId, result in module.registerBarcodeArViewUiListener(viewId: viewId, result: result) },
            viewId: Int.max - 2
        )
    }

    func testRegisterBarcodeArHighlightProviderBeforeViewExistsQueuesRetryInsteadOfReportingSuccess() {
        assertQueuesRetryInsteadOfSilentlySucceeding(
            { module, viewId, result in module.registerBarcodeArHighlightProvider(viewId: viewId, result: result) },
            viewId: Int.max - 3
        )
    }

    func testRegisterBarcodeArAnnotationProviderBeforeViewExistsQueuesRetryInsteadOfReportingSuccess() {
        assertQueuesRetryInsteadOfSilentlySucceeding(
            { module, viewId, result in module.registerBarcodeArAnnotationProvider(viewId: viewId, result: result) },
            viewId: Int.max - 4
        )
    }
}
