/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

private class NoopResult: FrameworksResult {
    private(set) var rejected: Error?
    func success(result: Any?) {}
    func successAndKeepCallback(result: Any?) {}
    func reject(code: String, message: String?, details: Any?) {
        rejected = NSError(domain: code, code: 0, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
    }
    func reject(error: Error) { rejected = error }
}

private class NoopEmitter: Emitter {
    func emit(name: String, payload: [String: Any?]) {}
    func hasListener(for event: String) -> Bool { false }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { false }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { false }
}

// Actions queued by parentId (dataCaptureView(addOverlay:to:) in an AIO view) must run
// once a mode with that parentId is added, as BarcodeBatchModule / BarcodeSelectionModule do.
final class BarcodeCaptureModuleParentDrainTests: XCTestCase {
    private let emitter = NoopEmitter()
    private var core: CoreModule!
    private var module: BarcodeCaptureModule!

    override func setUp() {
        super.setUp()
        core = CoreModule.create(emitter: emitter)
        let result = NoopResult()
        core.createContextFromJson(
            contextJson:
                #"{"licenseKey":"","framework":"react-native","frameworkVersion":"8.7.0","deviceName":"sim","externalId":"test"}"#,
            result: result
        )
        XCTAssertNil(result.rejected)
        module = BarcodeCaptureModule(emitter: emitter)
        module.didStart()
    }

    override func tearDown() {
        module.dataCaptureContextAllModeRemoved()
        module.didStop()
        super.tearDown()
    }

    private func addMode(modeId: Int, parentId: Int) {
        let json =
            #"{"type":"barcodeCapture","modeId":\#(modeId),"parentId":\#(parentId),"enabled":false,"settings":{}}"#
        let result = NoopResult()
        core.addModeToContext(modeJson: json, result: result)
        XCTAssertNil(result.rejected)
    }

    func testActionQueuedByModeIdRunsWhenModeIsAdded() {
        var ran = false
        module.addPostModeCreationAction(1111) { ran = true }

        addMode(modeId: 1111, parentId: 2222)

        XCTAssertNotNil(module.getModeFromCache(1111), "mode must be created for this test to mean anything")
        XCTAssertTrue(ran)
    }

    func testActionQueuedByParentRunsWhenModeWithThatParentIsAdded() {
        var ran = false
        module.addPostModeCreationActionByParent(2222) { ran = true }

        addMode(modeId: 1111, parentId: 2222)

        XCTAssertNotNil(module.getModeFromCacheByParent(2222), "mode must be created for this test to mean anything")
        XCTAssertTrue(ran, "action queued by parentId 2222 never ran after the mode with parentId 2222 was added")
    }
}
