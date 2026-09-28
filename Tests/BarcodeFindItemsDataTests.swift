/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeFindItemsDataTests: XCTestCase {

    func testItemWithFullContentIsParsedCorrectly() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ABC123" },
                    "content": {
                        "info": "Product A",
                        "additionalInfo": "Shelf 3"
                    }
                }
            ]
            """

        let items = BarcodeFindItemsData(jsonString: json).items
        XCTAssertEqual(items.count, 1)

        let item = items.first!
        XCTAssertEqual(item.searchOptions.barcodeData, "ABC123")
        XCTAssertNotNil(item.content)
        XCTAssertEqual(item.content?.info, "Product A")
        XCTAssertEqual(item.content?.additionalInfo, "Shelf 3")
    }

    func testItemWithoutContentKeyHasNilContent() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ABC123" }
                }
            ]
            """

        let items = BarcodeFindItemsData(jsonString: json).items
        XCTAssertEqual(items.count, 1)
        XCTAssertNil(items.first?.content)
    }

    func testContentWithOnlyInfo() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ABC123" },
                    "content": { "info": "Product A" }
                }
            ]
            """

        let item = BarcodeFindItemsData(jsonString: json).items.first!
        XCTAssertNotNil(item.content)
        XCTAssertEqual(item.content?.info, "Product A")
        XCTAssertNil(item.content?.additionalInfo)
    }

    func testContentWithOnlyAdditionalInfo() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ABC123" },
                    "content": { "additionalInfo": "Shelf 3" }
                }
            ]
            """

        let item = BarcodeFindItemsData(jsonString: json).items.first!
        XCTAssertNotNil(item.content)
        XCTAssertNil(item.content?.info)
        XCTAssertEqual(item.content?.additionalInfo, "Shelf 3")
    }

    func testMultipleItemsWithMixedContent() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ITEM1" },
                    "content": { "info": "First", "additionalInfo": "Extra1" }
                },
                {
                    "searchOptions": { "barcodeData": "ITEM2" }
                },
                {
                    "searchOptions": { "barcodeData": "ITEM3" },
                    "content": { "info": "Third" }
                }
            ]
            """

        let items = BarcodeFindItemsData(jsonString: json).items
        XCTAssertEqual(items.count, 3)

        let byBarcode = Dictionary(
            uniqueKeysWithValues: items.map { ($0.searchOptions.barcodeData, $0) }
        )

        XCTAssertNotNil(byBarcode["ITEM1"]?.content)
        XCTAssertEqual(byBarcode["ITEM1"]?.content?.info, "First")
        XCTAssertEqual(byBarcode["ITEM1"]?.content?.additionalInfo, "Extra1")

        XCTAssertNil(byBarcode["ITEM2"]?.content)

        XCTAssertNotNil(byBarcode["ITEM3"]?.content)
        XCTAssertEqual(byBarcode["ITEM3"]?.content?.info, "Third")
        XCTAssertNil(byBarcode["ITEM3"]?.content?.additionalInfo)
    }

    func testRegressionContentFieldsComeFromContentKeyNotSearchOptions() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ABC123", "info": "wrong" },
                    "content": { "info": "correct" }
                }
            ]
            """

        let item = BarcodeFindItemsData(jsonString: json).items.first!
        XCTAssertNotNil(item.content)
        XCTAssertEqual(item.content?.info, "correct")
    }

    func testEmptyContentObjectYieldsNilContent() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ABC123" },
                    "content": {}
                }
            ]
            """

        let item = BarcodeFindItemsData(jsonString: json).items.first!
        XCTAssertNil(item.content)
    }

    func testItemWithNullContentValueHasNilContent() {
        let json = """
            [
                {
                    "searchOptions": { "barcodeData": "ABC123" },
                    "content": null
                }
            ]
            """

        let item = BarcodeFindItemsData(jsonString: json).items.first!
        XCTAssertNil(item.content)
    }
}
