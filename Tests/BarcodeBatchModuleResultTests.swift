/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import UIKit
import XCTest

@testable import ScanditFrameworksBarcode

private class SpyFrameworksResult: FrameworksResult {
    private(set) var successCallCount = 0
    private let onSuccess: (() -> Void)?

    init(onSuccess: (() -> Void)? = nil) {
        self.onSuccess = onSuccess
    }

    func success(result: Any?) {
        successCallCount += 1
        onSuccess?()
    }

    func successAndKeepCallback(result: Any?) {}
    func reject(code: String, message: String?, details: Any?) {}
    func reject(error: Error) {}
}

private class NoopEmitter: Emitter {
    func emit(name: String, payload: [String: Any?]) {}
    func hasListener(for event: String) -> Bool { false }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { false }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { false }
}

private class StubTappableView: UIView, TappableView {
    var didTap: (() -> Void)?
    var isAnimating = false
}

final class BarcodeBatchModuleResultTests: XCTestCase {

    private let trackedBarcodeId = 5

    private func module(with view: UIView) -> BarcodeBatchModule {
        let module = BarcodeBatchModule(emitter: NoopEmitter(), viewFromJsonResolver: nil)
        let cache = DefaultAdvancedOverlayViewCache()
        cache.addToCache(viewIdentifier: String(trackedBarcodeId), view: view)
        module.setAdvancedOverlayViewPoolForTesting(cache)
        return module
    }

    func testUnregisterListenerForBasicOverlayEventsResolvesOnce() {
        let module = BarcodeBatchModule(emitter: NoopEmitter(), viewFromJsonResolver: nil)
        let resolved = expectation(description: "result resolved")
        let result = SpyFrameworksResult { resolved.fulfill() }

        module.unregisterListenerForBasicOverlayEvents(dataCaptureViewId: -1, result: result)

        wait(for: [resolved], timeout: 2)
        XCTAssertEqual(result.successCallCount, 1)
    }

    func testUpdateSizeOfTrackedBarcodeViewResolvesOnceWhileAnimating() {
        let view = StubTappableView()
        view.isAnimating = true
        let module = module(with: view)
        let resolved = expectation(description: "result resolved")
        let result = SpyFrameworksResult { resolved.fulfill() }

        module.updateSizeOfTrackedBarcodeView(
            trackedBarcodeIdentifier: trackedBarcodeId,
            width: 40,
            height: 40,
            result: result
        )

        wait(for: [resolved], timeout: 2)
        XCTAssertEqual(result.successCallCount, 1)
    }

    func testUpdateSizeOfTrackedBarcodeViewResolvesOnceBeforeAnimationEnds() {
        let view = StubTappableView()
        let module = module(with: view)
        let resolved = expectation(description: "result resolved")
        let result = SpyFrameworksResult { resolved.fulfill() }

        module.updateSizeOfTrackedBarcodeView(
            trackedBarcodeIdentifier: trackedBarcodeId,
            width: 40,
            height: 40,
            result: result
        )

        wait(for: [resolved], timeout: 0.25)
        XCTAssertEqual(result.successCallCount, 1)
        XCTAssertTrue(view.isAnimating)
    }
}
