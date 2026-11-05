/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture
import ScanditFrameworksCore

@testable import ScanditFrameworksBarcode

/// Test-only *wide* defaults builders for the Barcode sub-modes.
///
/// Production only ever emits the narrow, dynamic payload (`toDynamicEncodable()` on each
/// sub-mode's `*Defaults`), so the wide `toEncodable()` graphs - and the leaf `*SettingsDefaults`
/// / `*OverlayDefaults` builders reachable only through them (also relocated into this test
/// target) - live here. They are the oracle `BarcodeDefaultsDriftTests` and
/// `DynamicDefaultsKeysTests` compare against: real SDK objects, dumped wide.
///
/// Each type is named `*WideDefaults` so it does not clash with the narrow production type of
/// the same name, which the test target sees via `@testable import`.
///
/// `BarcodeDefaults` is deliberately absent: it still emits its whole block in production, so
/// the drift test uses the production type directly.

struct BarcodeArWideDefaults: DefaultsEncodable {
    let recommendedCameraSettings: CameraSettingsDefaults
    let barcodeArFeedback: BarcodeArFeedback
    let viewDefaults: DefaultsBarcodeArView
    let settingsDefaults: BarcodeArSettingsDefaults

    static let shared = {
        BarcodeArWideDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(cameraSettings: BarcodeAr.recommendedCameraSettings),
            barcodeArFeedback: .default,
            viewDefaults: DefaultsBarcodeArView(),
            settingsDefaults: BarcodeArSettingsDefaults(barcodeArSettings: BarcodeArSettings())
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            BarcodeArDefaults.Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            "barcodeArFeedback": barcodeArFeedback.jsonString,
            BarcodeArDefaults.Keys.barcodeArView: viewDefaults.toEncodable(),
            "BarcodeArSettings": settingsDefaults.toEncodable(),
        ]
    }
}

struct BarcodeBatchWideDefaults: DefaultsEncodable {
    let recommendedCameraSettings: CameraSettingsDefaults
    let basicOverlayDefaults: BarcodeBatchBasicOverlayDefaults

    static let shared: BarcodeBatchWideDefaults = {
        let mode = BarcodeBatch(context: nil, settings: BarcodeBatchSettings())
        let overlay = BarcodeBatchBasicOverlay(barcodeBatch: mode, view: nil)
        let overlayDefaults = BarcodeBatchBasicOverlayDefaults(defaultStyle: overlay.style)
        return BarcodeBatchWideDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(cameraSettings: BarcodeBatch.recommendedCameraSettings),
            basicOverlayDefaults: overlayDefaults
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            BarcodeBatchDefaults.Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            "BarcodeBatchBasicOverlay": basicOverlayDefaults.toEncodable(),
        ]
    }
}

struct BarcodeCaptureWideDefaults: DefaultsEncodable {
    private let recommendedCameraSettings: CameraSettingsDefaults
    private let barcodeCaptureSettingsDefaults: BarcodeCaptureSettingsDefaults
    private let barcodeCaptureOverlayDefaults: BarcodeCaptureOverlayDefaults

    static let shared: BarcodeCaptureWideDefaults = {
        BarcodeCaptureWideDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodeCapture.recommendedCameraSettings
            ),
            barcodeCaptureSettingsDefaults: BarcodeCaptureSettingsDefaults(
                barcodeCaptureSettings: BarcodeCaptureSettings()
            ),
            barcodeCaptureOverlayDefaults: BarcodeCaptureOverlayDefaults()
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            BarcodeCaptureDefaults.Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            "BarcodeCaptureSettings": barcodeCaptureSettingsDefaults.toEncodable(),
            "BarcodeCaptureOverlay": barcodeCaptureOverlayDefaults.toEncodable(),
        ]
    }
}

struct BarcodeCountWideDefaults: DefaultsEncodable {
    let recommendedCameraSettings: CameraSettingsDefaults
    let barcodeCountSettings: BarcodeCountSettingsDefaults
    let barcodeCountFeedback: BarcodeCountFeedback
    let barcodeCountView: DefaultsBarcodeCountView

    static let shared = {
        BarcodeCountWideDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(cameraSettings: BarcodeCount.recommendedCameraSettings),
            barcodeCountSettings: BarcodeCountSettingsDefaults(barcodeCountSettings: BarcodeCountSettings()),
            barcodeCountFeedback: .default,
            barcodeCountView: DefaultsBarcodeCountView(
                barcodeCountToolbarSettingsDefaults: BarcodeCountToolbarSettingsDefaults(),
                barcodeCountMappingFlowSettingsDefaults: BarcodeCountMappingFlowSettingsDefaults()
            )
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            BarcodeCountDefaults.Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            "BarcodeCountSettings": barcodeCountSettings.toEncodable(),
            "BarcodeCountFeedback": barcodeCountFeedback.jsonString,
            BarcodeCountDefaults.Keys.barcodeCountView: barcodeCountView.toEncodable(),
        ]
    }
}

struct BarcodeFindWideDefaults: DefaultsEncodable {
    private let feedback: BarcodeFindFeedback
    private let viewDefaults: FrameworksBarcodeFindViewDefaults
    private let viewSettingsDefaults: FrameworksBarcodeFindViewSettingsDefaults
    private let recommendedCameraSettings: CameraSettingsDefaults

    init(
        feedback: BarcodeFindFeedback,
        viewDefaults: FrameworksBarcodeFindViewDefaults,
        viewSettingsDefaults: FrameworksBarcodeFindViewSettingsDefaults,
        recommendedCameraSettings: CameraSettingsDefaults
    ) {
        self.feedback = feedback
        self.viewDefaults = viewDefaults
        self.viewSettingsDefaults = viewSettingsDefaults
        self.recommendedCameraSettings = recommendedCameraSettings
    }

    static let shared = {
        BarcodeFindWideDefaults(
            feedback: .default,
            viewDefaults: FrameworksBarcodeFindViewDefaults(),
            viewSettingsDefaults: FrameworksBarcodeFindViewSettingsDefaults(
                barcodeFindViewSettings: BarcodeFindViewSettings()
            ),
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodeFind.recommendedCameraSettings
            )
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            BarcodeFindDefaults.Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            "BarcodeFindFeedback": feedback.jsonString,
            BarcodeFindDefaults.Keys.barcodeFindView: viewDefaults.toEncodable(),
            "BarcodeFindViewSettings": viewSettingsDefaults.toEncodable(),
        ]
    }
}

struct BarcodePickWideDefaults: DefaultsEncodable {
    private let recommendedCameraSettings: CameraSettingsDefaults
    private let settingsDefaults: FrameworksBarcodePickSettingsDefaults
    private let viewSettingsDefaults: FrameworksBarcodePickViewDefaults
    private let barcodePickViewHighlightStyleDefaults: BarcodePickViewHighlightStyleDefaults
    private let barcodePickSymbologySettingsDefaults: BarcodePickSymbologySettingsDefaults
    private let barcodePickStatusIconSettingsDefaults: BarcodePickStatusIconSettingsDefaults

    static let shared: BarcodePickWideDefaults = {
        BarcodePickWideDefaults(
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodePick.recommendedCameraSettings
            ),
            settingsDefaults: FrameworksBarcodePickSettingsDefaults(barcodePickSettings: BarcodePickSettings()),
            viewSettingsDefaults: FrameworksBarcodePickViewDefaults(),
            barcodePickViewHighlightStyleDefaults: .shared,
            barcodePickSymbologySettingsDefaults: .shared,
            barcodePickStatusIconSettingsDefaults: .shared
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            BarcodePickDefaults.Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            "BarcodePickSettings": settingsDefaults.toEncodable(),
            BarcodePickDefaults.Keys.viewSettings: viewSettingsDefaults.toEncodable(),
            BarcodePickDefaults.Keys.barcodePickViewHighlightStyle:
                barcodePickViewHighlightStyleDefaults.toEncodable(),
            BarcodePickDefaults.Keys.symbologySettings: barcodePickSymbologySettingsDefaults.toEncodable(),
            "BarcodePickStatusIconSettings": barcodePickStatusIconSettingsDefaults.toEncodable(),
        ]
    }
}

struct BarcodeSelectionWideDefaults: DefaultsEncodable {
    let feedback: BarcodeSelectionFeedback
    let recommendedCameraSettings: CameraSettingsDefaults
    let settings: BarcodeSelectionSettingsDefaults
    let tapSelection: BarcodeSelectionTapSelectionDefaults
    let aimerSelection: BarcodeSelectionAimerSelectionDefaults
    let overlay: BarcodeSelectionBasicOverlayDefaults

    static let shared: BarcodeSelectionWideDefaults = {
        let settings = BarcodeSelectionSettings()
        let overlay = {
            let mode = BarcodeSelection(context: nil, settings: settings)
            return BarcodeSelectionBasicOverlay(barcodeSelection: mode, view: nil)
        }()
        return BarcodeSelectionWideDefaults(
            feedback: .default,
            recommendedCameraSettings: CameraSettingsDefaults(
                cameraSettings: BarcodeSelection.recommendedCameraSettings
            ),
            settings: BarcodeSelectionSettingsDefaults(settings: settings),
            tapSelection: BarcodeSelectionTapSelectionDefaults(tapSelection: BarcodeSelectionTapSelection()),
            aimerSelection: BarcodeSelectionAimerSelectionDefaults(aimerSelection: BarcodeSelectionAimerSelection()),
            overlay: BarcodeSelectionBasicOverlayDefaults(overlay: overlay)
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            "BarcodeSelectionBasicOverlay": overlay.toEncodable(),
            "BarcodeSelectionSettings": settings.toEncodable(),
            "Feedback": feedback.jsonString,
            BarcodeSelectionDefaults.Keys.recommendedCameraSettings: recommendedCameraSettings.toEncodable(),
            "BarcodeSelectionTapSelection": tapSelection.toEncodable(),
            "BarcodeSelectionAimerSelection": aimerSelection.toEncodable(),
        ]
    }
}

struct SparkScanWideDefaults: DefaultsEncodable {
    let feedbackDefaults: SparkScanFeedbackDefaults
    let viewDefaults: DefaultsSparkScanView
    let settingsDefaults: SparkScanSettingsDefaults

    static let shared = {
        SparkScanWideDefaults(
            feedbackDefaults: SparkScanFeedbackDefaults(
                successFeedback: SparkScanBarcodeSuccessFeedback(),
                // the default values passed here will be ignored on the common layer
                errorFeedback: SparkScanBarcodeErrorFeedback(message: "ignore", resumeCapturingDelay: TimeInterval(1.0))
            ),
            viewDefaults: DefaultsSparkScanView(viewSettings: SparkScanViewSettings()),
            settingsDefaults: SparkScanSettingsDefaults(sparkScanSettings: SparkScanSettings())
        )
    }()

    func toEncodable() -> [String: Any?] {
        [
            "Feedback": feedbackDefaults.toEncodable(),
            "SparkScanSettings": settingsDefaults.toEncodable(),
            SparkScanDefaults.Keys.sparkScanView: viewDefaults.toEncodable(),
        ]
    }
}
