/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import Foundation

public class SparkScanViewCreationData {
    let modeJson: String
    let viewJson: String
    let hasModeListener: Bool
    let hasFeedbackDelegate: Bool
    let hasUIListener: Bool
    let shouldShowOnTopAlways: Bool
    let viewId: Int

    private init(
        modeJson: String,
        viewJson: String,
        hasModeListener: Bool,
        hasFeedbackDelegate: Bool,
        hasUIListener: Bool,
        shouldShowOnTopAlways: Bool,
        viewId: Int
    ) {
        self.modeJson = modeJson
        self.viewJson = viewJson
        self.hasModeListener = hasModeListener
        self.hasFeedbackDelegate = hasFeedbackDelegate
        self.hasUIListener = hasUIListener
        self.shouldShowOnTopAlways = shouldShowOnTopAlways
        self.viewId = viewId
    }

    static func fromJson(_ jsonString: String) -> SparkScanViewCreationData {
        guard let jsonData = jsonString.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any]
        else {
            // Return default values if JSON parsing fails
            return SparkScanViewCreationData(
                modeJson: "{}",
                viewJson: "{}",
                hasModeListener: false,
                hasFeedbackDelegate: false,
                hasUIListener: false,
                shouldShowOnTopAlways: false,
                viewId: 0
            )
        }

        // Get JSON objects directly, defaulting to empty dictionaries
        let viewJsonObject = json[Constants.viewKey] as? [String: Any] ?? [:]
        let modeJsonObject = json[Constants.modeKey] as? [String: Any] ?? [:]

        // Convert dictionaries back to JSON strings
        let modeJsonString = convertToJsonString(modeJsonObject) ?? "{}"
        let viewJsonString = convertToJsonString(viewJsonObject) ?? "{}"

        let hasViewUIListener = viewJsonObject[Constants.hasUiListenerKey] as? Bool ?? false

        return SparkScanViewCreationData(
            modeJson: modeJsonString,
            viewJson: viewJsonString,
            hasModeListener: modeJsonObject[Constants.hasModeListenerKey] as? Bool ?? false,
            hasFeedbackDelegate: viewJsonObject[Constants.hasFeedbackDelegateKey] as? Bool ?? false,
            hasUIListener: hasViewUIListener,
            shouldShowOnTopAlways: viewJsonObject[Constants.hasShouldShowViewOnTop] as? Bool ?? false,
            viewId: viewJsonObject[Constants.viewIdKey] as? Int ?? 0
        )
    }

    private static func convertToJsonString(_ dict: [String: Any]) -> String? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dict) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }

    private struct Constants {
        static let modeKey = "SparkScan"
        static let viewKey = "SparkScanView"
        static let hasFeedbackDelegateKey = "hasFeedbackDelegate"
        static let hasUiListenerKey = "hasUiListener"
        static let viewIdKey = "viewId"
        static let hasModeListenerKey = "hasListeners"
        static let hasShouldShowViewOnTop = "shouldShowOnTopAlways"
    }
}
