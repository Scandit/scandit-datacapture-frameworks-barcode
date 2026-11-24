/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeArHighlightParserTests: XCTestCase {

    private let barcode = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "1234"))

    private var parser: BarcodeArHighlightParser!

    override func setUp() {
        super.setUp()
        parser = BarcodeArHighlightParser(emitter: NoopEmitter())
    }

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - circle highlight

    func testCircleHighlightIconIsClearedWhenIconKeyIsAbsent() throws {
        let highlight = try circleHighlight(icon: iconJson)
        XCTAssertNotNil(highlight.icon)

        parser.updateHighlight(highlight, json: JSONValue(string: circleJson(icon: nil)))

        XCTAssertNil(highlight.icon)
    }

    func testCircleHighlightIconIsClearedWhenIconIsNull() throws {
        let highlight = try circleHighlight(icon: iconJson)
        XCTAssertNotNil(highlight.icon)

        parser.updateHighlight(highlight, json: JSONValue(string: circleJson(icon: "null")))

        XCTAssertNil(highlight.icon)
    }

    func testCircleHighlightIconIsUpdatedWhenIconIsPresent() throws {
        let highlight = try circleHighlight(icon: nil)
        XCTAssertNil(highlight.icon)

        parser.updateHighlight(highlight, json: JSONValue(string: circleJson(icon: iconJson)))

        XCTAssertEqual(highlight.icon?.backgroundStrokeWidth, 3.0)
    }

    func testCircleHighlightAppliesSiblingPropertiesWhenIconIsInvalid() throws {
        let highlight = try circleHighlight(icon: iconJson)

        parser.updateHighlight(
            highlight,
            json: JSONValue(
                string: circleJson(icon: "\"not-an-icon-object\"", size: 42.0, isPulsing: true, brush: brushJson)
            )
        )

        XCTAssertEqual(highlight.size, 42.0)
        XCTAssertTrue(highlight.isPulsing)
        XCTAssertEqual(highlight.brush.strokeWidth, 7.0)
        XCTAssertNil(highlight.icon)
    }

    func testCircleHighlightIconIsClearedWhenIconIsNotAnObjectOrString() throws {
        let highlight = try circleHighlight(icon: iconJson)
        XCTAssertNotNil(highlight.icon)

        parser.updateHighlight(highlight, json: JSONValue(string: circleJson(icon: "[1, 2, 3]")))

        XCTAssertNil(highlight.icon)
    }

    func testCircleHighlightKeepsSizeWhenSizeKeyIsAbsent() throws {
        let highlight = try circleHighlight(icon: nil)
        highlight.size = 12.0
        let sizeBeforeUpdate = highlight.size

        parser.updateHighlight(highlight, json: JSONValue(string: circleJsonWithoutSize(isPulsing: true)))

        XCTAssertEqual(highlight.size, sizeBeforeUpdate)
        XCTAssertTrue(highlight.isPulsing)
    }

    // MARK: - rectangle highlight

    func testRectangleHighlightKeepsIconWhenBrushKeyIsAbsent() throws {
        let highlight = try rectangleHighlight(icon: nil)

        parser.updateHighlight(highlight, json: JSONValue(string: rectangleJson(icon: iconJson, brush: nil)))

        XCTAssertEqual(highlight.icon?.backgroundStrokeWidth, 3.0)
    }

    func testRectangleHighlightIconIsClearedWhenIconKeyIsAbsent() throws {
        let highlight = try rectangleHighlight(icon: iconJson)
        XCTAssertNotNil(highlight.icon)

        parser.updateHighlight(highlight, json: JSONValue(string: rectangleJson(icon: nil, brush: brushJson)))

        XCTAssertNil(highlight.icon)
    }

    func testRectangleHighlightIconIsClearedWhenIconIsNull() throws {
        let highlight = try rectangleHighlight(icon: iconJson)
        XCTAssertNotNil(highlight.icon)

        parser.updateHighlight(highlight, json: JSONValue(string: rectangleJson(icon: "null", brush: brushJson)))

        XCTAssertNil(highlight.icon)
    }

    func testRectangleHighlightAppliesBrushWhenIconIsInvalid() throws {
        let highlight = try rectangleHighlight(icon: nil)

        parser.updateHighlight(
            highlight,
            json: JSONValue(string: rectangleJson(icon: "\"not-an-icon-object\"", brush: brushJson))
        )

        XCTAssertEqual(highlight.brush.strokeWidth, 7.0)
    }

    // MARK: - fixtures

    private let iconJson = """
        {
            "icon": "starFilled",
            "backgroundStrokeWidth": 3.0
        }
        """

    private let brushJson = """
        {
            "fill": { "color": "#FF0000FF" },
            "stroke": { "color": "#00FF00FF", "width": 7.0 }
        }
        """

    private func circleJson(
        icon: String?,
        size: CGFloat = 1.0,
        isPulsing: Bool = false,
        brush: String? = nil
    ) -> String {
        var entries = [
            "\"type\": \"barcodeArCircleHighlight\"",
            "\"preset\": \"icon\"",
            "\"size\": \(size)",
            "\"isPulsing\": \(isPulsing)",
        ]
        if let icon { entries.append("\"icon\": \(icon)") }
        if let brush { entries.append("\"brush\": \(brush)") }
        return "{\(entries.joined(separator: ","))}"
    }

    private func circleJsonWithoutSize(isPulsing: Bool) -> String {
        """
        {
            "type": "barcodeArCircleHighlight",
            "preset": "icon",
            "isPulsing": \(isPulsing)
        }
        """
    }

    private func rectangleJson(icon: String?, brush: String?) -> String {
        var entries = ["\"type\": \"barcodeArRectangleHighlight\""]
        if let icon { entries.append("\"icon\": \(icon)") }
        if let brush { entries.append("\"brush\": \(brush)") }
        return "{\(entries.joined(separator: ","))}"
    }

    private func circleHighlight(icon: String?) throws -> BarcodeArCircleHighlight {
        let json = JSONValue(string: circleJson(icon: icon))
        return try XCTUnwrap(parser.get(json: json, barcode: barcode, viewId: 1) as? BarcodeArCircleHighlight)
    }

    private func rectangleHighlight(icon: String?) throws -> BarcodeArRectangleHighlight {
        let json = JSONValue(string: rectangleJson(icon: icon, brush: nil))
        return try XCTUnwrap(parser.get(json: json, barcode: barcode, viewId: 1) as? BarcodeArRectangleHighlight)
    }
}

private class NoopEmitter: Emitter {
    func emit(name: String, payload: [String: Any?]) {}

    func hasListener(for event: String) -> Bool { false }

    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { false }

    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { false }
}
