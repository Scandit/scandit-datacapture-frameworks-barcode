/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

/// Regression coverage for SDC-32821: registration/listener/provider methods on
/// `BarcodeCountModule`, `BarcodeFindModule`, `BarcodePickModule` and `SparkScanModule`
/// used to optional-chain into `viewCache.getView(viewId:)` and, on a cache miss (native
/// view not created yet - a new-architecture creation race), silently no-op while still
/// reporting success via `successAndKeepCallback`. JS believed it registered; no events
/// ever fired.
///
/// None of these four modules derive from `BaseFrameworkModule` (they have no
/// post-creation action queue of their own), so the fix gives each an instance of the shared
/// `ViewCreationActionQueue` (ScanditFrameworksCore, Sources/ScanditFrameworksCore/ViewCreationActionQueue.swift)
/// instead. A real `FrameworksBarcodeCountView`/`FrameworksBarcodeFindView`/
/// `FrameworksBarcodePickView`/`FrameworksSparkScanView` can't be constructed in a unit
/// test (private init, live licensed DataCaptureContext, native deserialization), so this
/// verifies the fix at the queue boundary, mirroring
/// `Tests/BarcodeArModuleRegistrationQueueTests.swift`: on a cache miss the call must
/// enqueue exactly one retry action instead of completing with no way to retry once the
/// view is created.
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

/// Generic assertion shared by all four modules below: on a cache miss, `register` must
/// resolve `successAndKeepCallback` immediately (never `success`, and never leave the
/// callback unresolved) while parking exactly one retry action in `queue` for `viewId`.
private func assertQueuesRetryInsteadOfSilentlySucceeding<Module>(
    module: Module,
    register: (Module, Int, FrameworksResult) -> Void,
    queue: ViewCreationActionQueue,
    viewId: Int,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let result = SpyFrameworksResult()

    register(module, viewId, result)

    XCTAssertEqual(
        result.successCallCount,
        0,
        "must not resolve via success() before the view exists",
        file: file,
        line: line
    )
    XCTAssertEqual(
        result.successAndKeepCallbackCallCount,
        1,
        "must resolve the bridge callback immediately so a never-created view doesn't "
            + "leak the promise",
        file: file,
        line: line
    )

    let queuedActions = queue.drain(viewId: viewId)
    XCTAssertEqual(
        queuedActions.count,
        1,
        "must queue exactly one retry action for this viewId",
        file: file,
        line: line
    )

    // Draining above already removed the entry; a second read must come back empty.
    XCTAssertEqual(
        queue.drain(viewId: viewId).count,
        0,
        "the queue must be drained by the first read",
        file: file,
        line: line
    )
}

final class BarcodeCountModuleRegistrationQueueTests: XCTestCase {
    private func assertQueues(
        _ register: (BarcodeCountModule, Int, FrameworksResult) -> Void,
        viewId: Int,
        line: UInt = #line
    ) {
        let module = BarcodeCountModule(emitter: NoopEmitter())
        assertQueuesRetryInsteadOfSilentlySucceeding(
            module: module,
            register: register,
            queue: module.viewCreationActionQueue,
            viewId: viewId,
            line: line
        )
    }

    func testRegisterBarcodeCountViewListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerBarcodeCountViewListener(viewId: viewId, result: result) },
            viewId: Int.max - 1
        )
    }

    func testRegisterBarcodeCountViewUiListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerBarcodeCountViewUiListener(viewId: viewId, result: result) },
            viewId: Int.max - 2
        )
    }

    func testRegisterBarcodeCountListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerBarcodeCountListener(viewId: viewId, result: result) },
            viewId: Int.max - 3
        )
    }

    func testRegisterBarcodeCountAsyncListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerBarcodeCountAsyncListener(viewId: viewId, result: result) },
            viewId: Int.max - 4
        )
    }

    func testAddBarcodeCountStatusProviderBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.addBarcodeCountStatusProvider(viewId: viewId, result: result) },
            viewId: Int.max - 5
        )
    }
}

final class BarcodeFindModuleRegistrationQueueTests: XCTestCase {
    private func assertQueues(
        _ register: (BarcodeFindModule, Int, FrameworksResult) -> Void,
        viewId: Int,
        line: UInt = #line
    ) {
        let module = BarcodeFindModule(emitter: NoopEmitter())
        assertQueuesRetryInsteadOfSilentlySucceeding(
            module: module,
            register: register,
            queue: module.viewCreationActionQueue,
            viewId: viewId,
            line: line
        )
    }

    func testRegisterBarcodeFindListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerBarcodeFindListener(viewId: viewId, result: result) },
            viewId: Int.max - 1
        )
    }

    func testRegisterBarcodeFindViewListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerBarcodeFindViewListener(viewId: viewId, result: result) },
            viewId: Int.max - 2
        )
    }
}

final class BarcodePickModuleRegistrationQueueTests: XCTestCase {
    private func assertQueues(
        _ register: (BarcodePickModule, Int, FrameworksResult) -> Void,
        viewId: Int,
        line: UInt = #line
    ) {
        let module = BarcodePickModule(emitter: NoopEmitter())
        assertQueuesRetryInsteadOfSilentlySucceeding(
            module: module,
            register: register,
            queue: module.viewCreationActionQueue,
            viewId: viewId,
            line: line
        )
    }

    func testAddPickActionListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.addPickActionListener(viewId: viewId, result: result) },
            viewId: Int.max - 1
        )
    }

    func testAddBarcodePickScanningListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.addBarcodePickScanningListener(viewId: viewId, result: result) },
            viewId: Int.max - 2
        )
    }

    func testAddPickViewListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.addPickViewListener(viewId: viewId, result: result) },
            viewId: Int.max - 3
        )
    }

    func testRegisterBarcodePickViewUiListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerBarcodePickViewUiListener(viewId: viewId, result: result) },
            viewId: Int.max - 4
        )
    }

    func testAddBarcodePickListenerBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.addBarcodePickListener(viewId: viewId, result: result) },
            viewId: Int.max - 5
        )
    }
}

final class SparkScanModuleRegistrationQueueTests: XCTestCase {
    private func assertQueues(
        _ register: (SparkScanModule, Int, FrameworksResult) -> Void,
        viewId: Int,
        line: UInt = #line
    ) {
        let module = SparkScanModule(emitter: NoopEmitter())
        assertQueuesRetryInsteadOfSilentlySucceeding(
            module: module,
            register: register,
            queue: module.viewCreationActionQueue,
            viewId: viewId,
            line: line
        )
    }

    func testRegisterSparkScanListenerForEventsBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerSparkScanListenerForEvents(viewId: viewId, result: result) },
            viewId: Int.max - 1
        )
    }

    func testRegisterSparkScanViewListenerEventsBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in module.registerSparkScanViewListenerEvents(viewId: viewId, result: result) },
            viewId: Int.max - 2
        )
    }

    func testRegisterSparkScanFeedbackDelegateForEventsBeforeViewExistsQueuesRetry() {
        assertQueues(
            { module, viewId, result in
                module.registerSparkScanFeedbackDelegateForEvents(viewId: viewId, result: result)
            },
            viewId: Int.max - 3
        )
    }
}
