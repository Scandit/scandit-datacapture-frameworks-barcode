/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

private final class RecordingEmitter: Emitter {
    var listening = true
    private let lock = NSLock()
    private var storage: [String] = []
    var emitted: [String] {
        lock.lock()
        defer { lock.unlock() }
        return storage
    }

    func emit(name: String, payload: [String: Any?]) {
        lock.lock()
        defer { lock.unlock() }
        storage.append(name)
    }
    func hasListener(for event: String) -> Bool { listening }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { false }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { false }
}

private struct ProviderUnderTest {
    let name: String
    let brush: (Barcode) -> Brush?
    let finish: (String?, String?) -> Void
    let clear: () -> Void
}

final class FrameworksBarcodeSelectionBrushProviderCacheTests: XCTestCase {

    private let brushJson = ##"{"fill":{"color":"#FF0000FF"},"stroke":{"color":"#00FF00FF","width":7.0}}"##

    private func barcode(_ data: String = "1234") -> Barcode {
        Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: data))
    }

    private func id(_ barcode: Barcode) -> String {
        "\(barcode.data ?? "")\(SymbologyDescription(symbology: barcode.symbology).identifier)"
    }

    private func makeProviders(_ emitter: Emitter) -> [ProviderUnderTest] {
        let aimed = FrameworksBarcodeSelectionAimedBrushProvider(emitter: emitter)
        let tracked = FrameworksBarcodeSelectionTrackedBrushProvider(emitter: emitter)
        return [
            ProviderUnderTest(
                name: "aimed",
                brush: { aimed.brush(for: $0) },
                finish: { aimed.finishCallback(brushJson: $0, selectionIdentifier: $1) },
                clear: { aimed.clearCache() }
            ),
            ProviderUnderTest(
                name: "tracked",
                brush: { tracked.brush(for: $0) },
                finish: { tracked.finishCallback(brushJson: $0, selectionIdentifier: $1) },
                clear: { tracked.clearCache() }
            ),
        ]
    }

    /// Runs `body` once per provider with a fresh emitter.
    private func forEachProvider(
        listening: Bool = true,
        _ body: (ProviderUnderTest, RecordingEmitter) -> Void
    ) {
        for name in ["aimed", "tracked"] {
            let emitter = RecordingEmitter()
            emitter.listening = listening
            body(makeProviders(emitter).first { $0.name == name }!, emitter)
        }
    }

    private func assertTransparent(
        _ brush: Brush?,
        _ label: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard let brush = brush else {
            return XCTFail("\(label): expected transparent brush, got nil", file: file, line: line)
        }
        XCTAssertEqual(brush.strokeWidth, 0, "\(label): transparent has no stroke", file: file, line: line)
        XCTAssertEqual(
            brush.fillColor.cgColor.alpha,
            0,
            accuracy: 0.001,
            "\(label): transparent fill",
            file: file,
            line: line
        )
    }

    func testB1_cacheMiss_returnsTransparentAndEmitsExactlyOnce() {
        forEachProvider { p, emitter in
            let b = barcode()
            assertTransparent(p.brush(b), "\(p.name) first")
            XCTAssertEqual(emitter.emitted.count, 1, "\(p.name): first call emits once")
            assertTransparent(p.brush(b), "\(p.name) second")
            XCTAssertEqual(emitter.emitted.count, 1, "\(p.name): second call while pending must not re-emit")
        }
    }

    func testB2_answeredWithBrush_returnsThatBrushWithoutEmit() {
        forEachProvider { p, emitter in
            let b = barcode()
            _ = p.brush(b)
            let before = emitter.emitted.count
            p.finish(brushJson, id(b))
            let brush = p.brush(b)
            XCTAssertNotNil(brush, "\(p.name): answered brush")
            XCTAssertEqual(brush?.strokeWidth ?? -1, 7.0, accuracy: 0.001, "\(p.name): stroke width from JSON")
            XCTAssertEqual(emitter.emitted.count, before, "\(p.name): no emit after answer")
        }
    }

    func testB3_answeredWithNil_returnsNilWithoutEmit() {
        forEachProvider { p, emitter in
            let b = barcode()
            _ = p.brush(b)
            let before = emitter.emitted.count
            p.finish(nil, id(b))
            XCTAssertNil(p.brush(b), "\(p.name): nil answer means default brush")
            XCTAssertEqual(emitter.emitted.count, before, "\(p.name): no re-emit after nil answer")
        }
    }

    func testB5_noListener_returnsNilWithoutEmit() {
        forEachProvider(listening: false) { p, emitter in
            XCTAssertNil(p.brush(barcode()), "\(p.name): no listener -> default brush")
            XCTAssertEqual(emitter.emitted.count, 0, "\(p.name): no emit without listener")
        }
    }

    func testB6_clearCache_nextCallEmitsAgain() {
        forEachProvider { p, emitter in
            let b = barcode()
            _ = p.brush(b)
            p.finish(brushJson, id(b))
            p.clear()
            assertTransparent(p.brush(b), "\(p.name) after clear")
            XCTAssertEqual(emitter.emitted.count, 2, "\(p.name): emits again after clearCache")
        }
    }

    func testB7_finishWithNilOrEmptyIdentifier_isIgnored() {
        forEachProvider { p, emitter in
            let b = barcode()
            _ = p.brush(b)
            p.finish(brushJson, nil)
            p.finish(brushJson, "")
            assertTransparent(p.brush(b), "\(p.name) after ignored finishes")
            XCTAssertEqual(emitter.emitted.count, 1, "\(p.name): no re-emit")
        }
    }

    func testB8_malformedBrushJson_isTreatedAsNoBrush() {
        XCTAssertNil(Brush(jsonString: "garbage"), "precondition: malformed JSON does not parse")
        forEachProvider { p, emitter in
            let b = barcode()
            _ = p.brush(b)
            p.finish("garbage", id(b))
            XCTAssertNil(p.brush(b), "\(p.name): malformed JSON means default brush")
            XCTAssertEqual(emitter.emitted.count, 1, "\(p.name): emitted once in total")
        }
    }

    func testB10_identifiersAreIndependent() {
        forEachProvider { p, emitter in
            let b1 = barcode("1111")
            let b2 = barcode("2222")
            _ = p.brush(b1)
            _ = p.brush(b2)
            XCTAssertEqual(emitter.emitted.count, 2, "\(p.name): both miss")
            p.finish(nil, id(b1))
            XCTAssertNil(p.brush(b1), "\(p.name): answered barcode")
            assertTransparent(p.brush(b2), "\(p.name) unanswered barcode")
            XCTAssertEqual(emitter.emitted.count, 2, "\(p.name): no further emit")
        }
    }

    func testB11_concurrentMisses_emitOnce() {
        forEachProvider { p, emitter in
            let b = barcode()
            DispatchQueue.concurrentPerform(iterations: 16) { _ in _ = p.brush(b) }
            XCTAssertEqual(emitter.emitted.count, 1, "\(p.name): concurrent misses emit once")
        }
    }
}
