/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture

internal class BarcodeCountStatusProviderResult {
    private enum FieldNames {
        static let status = "status"
        static let barcodeId = "barcodeId"
        static let statusList = "statusList"
        static let errorMessage = "errorMessage"
        static let enabledMessage = "statusModeEnabledMessage"
        static let disabledMessage = "statusModeDisabledMessage"
        static let resultType = "type"
    }

    private let json: [String: Any]

    private init(json: [String: Any]) {
        self.json = json
    }

    var requestId: String {
        json[BarcodeCountStatusProviderRequest.id] as? String ?? ""
    }

    func get(barcodesFromEvent: [TrackedBarcode]) throws -> BarcodeCountStatusResult {
        guard let resultType = json[FieldNames.resultType] as? String else {
            throw NSError(domain: "Invalid BarcodeCountStatusResult type", code: -1, userInfo: nil)
        }

        switch resultType {
        case "barcodeCountStatusResultSuccess":
            return getSuccess(barcodesFromEvent: barcodesFromEvent)
        case "barcodeCountStatusResultError":
            return getError(barcodesFromEvent: barcodesFromEvent)
        case "barcodeCountStatusResultAbort":
            return getAbort()
        default:
            throw NSError(domain: "Invalid BarcodeCountStatusResult type", code: -1, userInfo: nil)
        }
    }

    private func getSuccess(barcodesFromEvent: [TrackedBarcode]) -> BarcodeCountStatusResult {
        BarcodeCountStatusSuccessResult(
            statusList: getStatusList(barcodesFromEvent: barcodesFromEvent),
            statusModeEnabledMessage: json[FieldNames.enabledMessage] as? String,
            statusModeDisabledMessage: json[FieldNames.disabledMessage] as? String
        )
    }

    private func getError(barcodesFromEvent: [TrackedBarcode]) -> BarcodeCountStatusResult {
        BarcodeCountStatusErrorResult(
            statusList: getStatusList(barcodesFromEvent: barcodesFromEvent),
            errorMessage: json[FieldNames.errorMessage] as? String,
            statusModeDisabledMessage: json[FieldNames.disabledMessage] as? String
        )
    }

    private func getAbort() -> BarcodeCountStatusResult {
        BarcodeCountStatusAbortResult(errorMessage: json[FieldNames.errorMessage] as? String)
    }

    private func getStatusList(barcodesFromEvent: [TrackedBarcode]) -> [BarcodeCountStatusItem] {
        guard let jsonItems = json[FieldNames.statusList] as? [[String: Any]] else { return [] }

        var items: [BarcodeCountStatusItem] = []
        for item in jsonItems {
            if let trackedBarcodeId = item[FieldNames.barcodeId] as? Int,
                let barcode = barcodesFromEvent.first(where: { $0.identifier == trackedBarcodeId }),
                let statusString = item[FieldNames.status] as? String
            {
                let status = statusString.toBarcodeCountStatus()
                items.append(BarcodeCountStatusItem(barcode: barcode, status: status))
            }
        }
        return items
    }

    static func createFromJson(statusJson: String) -> BarcodeCountStatusProviderResult? {
        guard let data = statusJson.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else {
            return nil
        }

        return BarcodeCountStatusProviderResult(json: json)
    }
}

private extension String {
    func toBarcodeCountStatus() -> BarcodeCountStatus {
        switch self {
        case "notAvailable":
            return .notAvailable
        case "expired":
            return .expired
        case "fragile":
            return .fragile
        case "qualityCheck":
            return .qualityCheck
        case "lowStock":
            return .lowStock
        case "wrong":
            return .wrong
        case "expiringSoon":
            return .expiringSoon
        default:
            return .none
        }
    }
}
