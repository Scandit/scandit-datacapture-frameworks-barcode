/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditCaptureCore
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

/// SDC-34546: two BarcodeArViews running at once must each get their own batched updates.
final class BarcodeArCustomAugmentationBatchingTests: XCTestCase {
    private let barcode1 = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "VIEW1"))
    private let barcode2 = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "VIEW2"))
    private var emitter: BarcodeArRecordingEmitter!

    override func setUp() {
        super.setUp()
        emitter = BarcodeArRecordingEmitter()
    }

    private func location(_ offset: CGFloat) -> Quadrilateral {
        Quadrilateral(
            topLeft: CGPoint(x: offset, y: offset),
            topRight: CGPoint(x: offset + 10, y: offset),
            bottomRight: CGPoint(x: offset + 10, y: offset + 10),
            bottomLeft: CGPoint(x: offset, y: offset + 10)
        )
    }

    /// Runs the main run loop until `count` emissions of `event` arrived, or 2 s passed.
    private func spinMainRunLoop(untilEmissions count: Int, of event: String) {
        let deadline = Date().addingTimeInterval(2)
        while emitter.emissions.filter({ $0.name == event }).count < count, Date() < deadline {
            RunLoop.main.run(until: Date().addingTimeInterval(0.01))
        }
    }

    /// viewId -> barcodeIds of every update emission addressed to that view.
    private func updatesByView(event: String) -> [Int: [String]] {
        var result: [Int: [String]] = [:]
        for emission in emitter.emissions where emission.name == event {
            let viewId = emission.payload["viewId"] as? Int ?? -1
            let updates = emission.payload["updates"] as? [[String: Any]] ?? []
            result[viewId, default: []] += updates.compactMap { $0["barcodeId"] as? String }
        }
        return result
    }

    func testTwoViews_customHighlightUpdates_stayOnTheirOwnView() {
        let highlight1 = BarcodeArCustomHighlight(barcode: barcode1, emitter: emitter, viewId: 1)
        let highlight2 = BarcodeArCustomHighlight(barcode: barcode2, emitter: emitter, viewId: 2)

        for step in 0..<2 {
            highlight1.update(with: location(CGFloat(step)))
            highlight2.update(with: location(CGFloat(step) + 100))
        }
        let event = BarcodeArCustomHighlightEvents.updateCustomHighlight.rawValue
        spinMainRunLoop(untilEmissions: 4, of: event)

        let byView = updatesByView(event: event)
        XCTAssertEqual(byView[1], [barcode1.uniqueId, barcode1.uniqueId])
        XCTAssertEqual(byView[2], [barcode2.uniqueId, barcode2.uniqueId])
        XCTAssertEqual(Set(byView.keys), [1, 2])
    }

    func testTwoViews_customAnnotationUpdates_stayOnTheirOwnView() {
        let json = JSONValue(string: "{\"annotationTrigger\":\"highlightTap\"}")
        let annotation1 = BarcodeArCustomAnnotation(barcode: barcode1, emitter: emitter, json: json, viewId: 1)
        let annotation2 = BarcodeArCustomAnnotation(barcode: barcode2, emitter: emitter, json: json, viewId: 2)

        for step in 0..<2 {
            annotation1.update(with: location(CGFloat(step)), highlight: nil)
            annotation2.update(with: location(CGFloat(step) + 100), highlight: nil)
        }
        let event = BarcodeArCustomAnnotationEvents.updateCustomAnnotation.rawValue
        spinMainRunLoop(untilEmissions: 4, of: event)

        let byView = updatesByView(event: event)
        XCTAssertEqual(byView[1], [barcode1.uniqueId, barcode1.uniqueId])
        XCTAssertEqual(byView[2], [barcode2.uniqueId, barcode2.uniqueId])
        XCTAssertEqual(Set(byView.keys), [1, 2])
    }
}
