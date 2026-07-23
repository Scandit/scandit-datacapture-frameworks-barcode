/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeCountStatusProviderResultTests: XCTestCase {

    // MARK: - createFromJson

    func testCreateFromJson_returnsNonNilForValidJson() {
        XCTAssertNotNil(BarcodeCountStatusProviderResult.createFromJson(statusJson: abortJson()))
    }

    func testCreateFromJson_returnsNilForEmptyString() {
        XCTAssertNil(BarcodeCountStatusProviderResult.createFromJson(statusJson: ""))
    }

    func testCreateFromJson_returnsNilForMalformedJson() {
        XCTAssertNil(BarcodeCountStatusProviderResult.createFromJson(statusJson: "not json {{{"))
    }

    func testCreateFromJson_returnsNilForBareNumber() {
        XCTAssertNil(BarcodeCountStatusProviderResult.createFromJson(statusJson: "42"))
    }

    // MARK: - requestId

    func testRequestId_isParsedFromJson() {
        let result = BarcodeCountStatusProviderResult.createFromJson(statusJson: abortJson(requestId: "my-id"))
        XCTAssertEqual(result?.requestId, "my-id")
    }

    func testRequestId_isEmptyStringWhenMissing() {
        let json = "{\"type\":\"barcodeCountStatusResultAbort\",\"errorMessage\":\"\"}"
        let result = BarcodeCountStatusProviderResult.createFromJson(statusJson: json)
        XCTAssertEqual(result?.requestId, "")
    }

    // MARK: - abort result

    func testGet_returnsAbortForAbortType() throws {
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: abortJson()))
        let statusResult = try result.get(barcodesFromEvent: [])
        XCTAssertTrue(statusResult is BarcodeCountStatusAbortResult)
    }

    // MARK: - error result

    func testGet_returnsErrorForErrorType() throws {
        let json = """
            {
                "requestId": "req-1",
                "type": "barcodeCountStatusResultError",
                "errorMessage": "something went wrong",
                "statusModeDisabledMessage": "disabled",
                "statusList": []
            }
            """
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
        let statusResult = try result.get(barcodesFromEvent: [])
        XCTAssertTrue(statusResult is BarcodeCountStatusErrorResult)
    }

    // MARK: - unknown result type

    func testGet_throwsForUnknownResultType() {
        let json = "{\"requestId\":\"req-1\",\"type\":\"unknownType\",\"statusList\":[]}"
        let result = BarcodeCountStatusProviderResult.createFromJson(statusJson: json)
        XCTAssertNotNil(result)
        XCTAssertThrowsError(try result!.get(barcodesFromEvent: []))
    }

    // MARK: - success with empty status list

    func testGet_returnsSuccessWithEmptyStatusListWhenStatusListIsEmpty() throws {
        let json = successJson(statusList: "[]")
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
        let statusResult = try result.get(barcodesFromEvent: [])
        XCTAssertTrue(statusResult is BarcodeCountStatusSuccessResult)
    }

    func testGet_dropsItemsWhoseBarcodeIdIsNotInEventList() throws {
        let json = successJson(statusList: "[{\"barcodeId\":99,\"status\":\"expired\"}]")
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
        // passing an empty barcodesFromEvent: the item for id=99 is silently dropped — result is still a success
        let statusResult = try result.get(barcodesFromEvent: [])
        XCTAssertTrue(statusResult is BarcodeCountStatusSuccessResult)
    }

    // MARK: - legacy status mapping

    func testGet_legacyStatus_knownStatusesDoNotThrow() throws {
        let knownStatuses = ["expired", "fragile", "wrong", "lowStock", "qualityCheck", "notAvailable", "expiringSoon"]
        for status in knownStatuses {
            let json = successJson(statusList: "[{\"barcodeId\":1,\"status\":\"\(status)\"}]")
            let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
            // barcode id=1 is not in empty list so item is dropped — test only that no exception is thrown
            XCTAssertNoThrow(try result.get(barcodesFromEvent: []), "Unexpected throw for status=\(status)")
        }
    }

    func testGet_legacyStatus_unknownStatusDropsItemSilently() throws {
        let json = successJson(statusList: "[{\"barcodeId\":1,\"status\":\"unknownStatus\"}]")
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
        let statusResult = try result.get(barcodesFromEvent: [])
        XCTAssertTrue(statusResult is BarcodeCountStatusSuccessResult)
    }

    // MARK: - icon key (graceful fallback)

    func testGet_iconKey_malformedIconStringDoesNotThrow() throws {
        // "icon" is a plain string, not a JSON object — deserialization must fail gracefully
        let json = successJson(statusList: "[{\"barcodeId\":1,\"icon\":\"not-an-object\",\"status\":\"expired\"}]")
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
        XCTAssertNoThrow(try result.get(barcodesFromEvent: []))
    }

    func testGet_iconKey_emptyIconObjectDoesNotThrow() throws {
        let json = successJson(statusList: "[{\"barcodeId\":1,\"icon\":{},\"status\":\"none\"}]")
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
        XCTAssertNoThrow(try result.get(barcodesFromEvent: []))
    }

    func testGet_iconKey_nullIconDoesNotThrow() throws {
        let json = successJson(statusList: "[{\"barcodeId\":1,\"icon\":null,\"status\":\"expired\"}]")
        let result = try XCTUnwrap(BarcodeCountStatusProviderResult.createFromJson(statusJson: json))
        XCTAssertNoThrow(try result.get(barcodesFromEvent: []))
    }

    // MARK: - helpers

    private func abortJson(requestId: String = "req-1", errorMessage: String = "") -> String {
        "{\"requestId\":\"\(requestId)\",\"type\":\"barcodeCountStatusResultAbort\",\"errorMessage\":\"\(errorMessage)\"}"
    }

    private func successJson(statusList: String) -> String {
        """
        {
            "requestId": "req-1",
            "type": "barcodeCountStatusResultSuccess",
            "statusModeEnabledMessage": "enabled",
            "statusModeDisabledMessage": "disabled",
            "statusList": \(statusList)
        }
        """
    }
}
