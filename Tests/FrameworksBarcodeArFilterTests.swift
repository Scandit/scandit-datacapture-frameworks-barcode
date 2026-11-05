/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

private class RecordingEmitter: Emitter {
    var onEmit: (() -> Void)?
    var payloads: [[String: Any?]] = []

    func emit(name: String, payload: [String: Any?]) {
        payloads.append(payload)
        onEmit?()
    }

    func hasListener(for event: String) -> Bool { true }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { true }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { true }
}

final class FrameworksBarcodeArFilterTests: XCTestCase {
    private let a = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "AAAA"))
    private let b = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "BBBB"))
    private var emitter: RecordingEmitter!

    override func setUp() {
        super.setUp()
        emitter = RecordingEmitter()
        XCTAssertNotEqual(a.uniqueId, b.uniqueId)
    }

    private func makeFilter(timeout: TimeInterval = 1) -> FrameworksBarcodeArFilter {
        FrameworksBarcodeArFilter(emitter: emitter, viewId: 7, timeout: timeout)
    }

    private func answerEachFrame(_ filter: FrameworksBarcodeArFilter, with json: String) {
        emitter.onEmit = {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.05) {
                filter.finishFilterBarcodes(filteredBarcodesJson: json)
            }
        }
    }

    private func idsJson(_ barcodes: [Barcode]) -> String {
        "{\"barcodes\":[\(barcodes.map { "\"\($0.uniqueId)\"" }.joined(separator: ","))]}"
    }

    // filterBarcodes blocks while the emit is dispatched to main, so run it off main.
    private func runFrame(_ filter: FrameworksBarcodeArFilter) -> [String] {
        var ids: [String] = []
        let done = expectation(description: "frame")
        DispatchQueue.global().async { [a, b] in
            ids = filter.filterBarcodes([a, b]).map { $0.uniqueId }
            done.fulfill()
        }
        wait(for: [done], timeout: 15)
        return ids
    }

    func testAnswerFiltersBarcodes() {
        let filter = makeFilter()
        answerEachFrame(filter, with: idsJson([b, a]))

        XCTAssertEqual(runFrame(filter), [b.uniqueId, a.uniqueId])
    }

    func testTimeoutReturnsAllBarcodes() {
        let filter = makeFilter()

        XCTAssertEqual(runFrame(filter), [a.uniqueId, b.uniqueId])
    }

    func testPayloadCarriesEventNameAndViewId() {
        let filter = makeFilter()
        _ = runFrame(filter)

        let payload = emitter.payloads.first
        XCTAssertEqual(payload?["event"] as? String, "BarcodeArFilter.filterBarcodes")
        XCTAssertEqual(payload?["viewId"] as? Int, 7)
    }

    func testLateAnswerBetweenFramesDoesNotReachNextFrame() {
        let filter = makeFilter()
        XCTAssertEqual(runFrame(filter), [a.uniqueId, b.uniqueId], "timeout returns all")
        filter.finishFilterBarcodes(filteredBarcodesJson: idsJson([a]))

        answerEachFrame(filter, with: idsJson([b]))

        XCTAssertEqual(runFrame(filter), [b.uniqueId], "frame 2 must get its own answer, not frame 1's late one")
    }

    func testMalformedAnswerReturnsAllBarcodes() {
        let filter = makeFilter()
        answerEachFrame(filter, with: idsJson([a]))
        XCTAssertEqual(runFrame(filter), [a.uniqueId])

        answerEachFrame(filter, with: "not json")

        XCTAssertEqual(runFrame(filter), [a.uniqueId, b.uniqueId], "malformed answer must return all, not stale ids")
    }

    func testCloseReleasesBlockedFrameWithAllBarcodes() {
        let filter = makeFilter(timeout: 10)
        emitter.onEmit = {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { filter.close() }
        }

        let start = Date()
        XCTAssertEqual(runFrame(filter), [a.uniqueId, b.uniqueId])
        XCTAssertLessThan(Date().timeIntervalSince(start), 2, "close() must not wait for the timeout")
    }

    func testEmptyAnswerFiltersEverythingOut() {
        let filter = makeFilter()
        answerEachFrame(filter, with: "{\"barcodes\":[]}")

        XCTAssertEqual(runFrame(filter), [])
    }

    func testUnknownIdsInAnswerAreDropped() {
        let filter = makeFilter()
        answerEachFrame(filter, with: "{\"barcodes\":[\"no-such-id\",\"\(b.uniqueId)\"]}")

        XCTAssertEqual(runFrame(filter), [b.uniqueId])
    }

    func testDuplicateBarcodesInFrameDoNotTrap() {
        let filter = makeFilter()
        answerEachFrame(filter, with: idsJson([a]))
        var ids: [String] = []
        let done = expectation(description: "frame")
        DispatchQueue.global().async { [a] in
            ids = filter.filterBarcodes([a, a]).map { $0.uniqueId }
            done.fulfill()
        }
        wait(for: [done], timeout: 15)

        XCTAssertEqual(ids, [a.uniqueId])
    }

    func testClosedFilterReturnsAllBarcodesWithoutWaiting() {
        let filter = makeFilter(timeout: 10)
        filter.close()

        let start = Date()
        XCTAssertEqual(runFrame(filter), [a.uniqueId, b.uniqueId])
        XCTAssertLessThan(Date().timeIntervalSince(start), 2)
    }

    func testReopenedFilterFiltersAgain() {
        let filter = makeFilter()
        filter.close()
        filter.open()
        answerEachFrame(filter, with: idsJson([b]))

        XCTAssertEqual(runFrame(filter), [b.uniqueId])
    }
}
