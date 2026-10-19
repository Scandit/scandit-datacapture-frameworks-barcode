/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture
import ScanditCaptureCore

internal class BarcodeCountStatusProviderResult {
    private enum FieldNames {
        static let status = "status"
        static let barcodeId = "barcodeId"
        static let icon = "icon"
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
            guard let trackedBarcodeId = item[FieldNames.barcodeId] as? Int,
                let barcode = barcodesFromEvent.first(where: { $0.identifier == trackedBarcodeId })
            else { continue }

            let icon: ScanditIcon?
            if let iconDict = item[FieldNames.icon],
                let iconJson = try? JSONSerialization.data(withJSONObject: iconDict),
                let iconJsonString = String(data: iconJson, encoding: .utf8),
                let parsedIcon = try? ScanditIcon(fromJSONString: iconJsonString)
            {
                icon = parsedIcon
            } else {
                icon = (item[FieldNames.status] as? String)?.toBarcodeCountIcon()
            }
            items.append(BarcodeCountStatusItem(barcode: barcode, icon: icon))
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
    func toBarcodeCountIcon() -> ScanditIcon? {
        switch self {
        case "expired":
            return ScanditIconBuilder().withIcon(.expiredItem).build()
        case "fragile":
            return ScanditIconBuilder().withIcon(.fragileItem).build()
        case "wrong":
            return ScanditIconBuilder().withIcon(.wrongItem).build()
        case "lowStock":
            return ScanditIconBuilder().withIcon(.lowStock).build()
        case "qualityCheck":
            return ScanditIconBuilder().withIcon(.inspectItem).build()
        case "notAvailable":
            return ScanditIconBuilder().withIcon(.xMark).build()
        case "expiringSoon":
            return ScanditIconBuilder().withIcon(.exclamationMark).build()
        default:
            return nil
        }
    }
}
