/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeCountViewCreationDataTests: XCTestCase {

    func testViewListenerFlagIsReadFromHasListenerOnUpdate() throws {
        let sut = try BarcodeCountViewCreationData.fromViewJsonOnly(#"{"viewId": 7, "hasListener": true}"#)

        XCTAssertTrue(sut.hasViewListener)
    }

    func testViewListenerFlagIsReadFromHasListenerOnCreate() throws {
        let json = #"{"BarcodeCount": {"hasListeners": false}, "View": {"viewId": 7, "hasListener": true}}"#

        let sut = try BarcodeCountViewCreationData.fromJson(json)

        XCTAssertTrue(sut.hasViewListener)
        XCTAssertFalse(sut.hasModeListener)
    }
}
