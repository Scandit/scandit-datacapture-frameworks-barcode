/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

// THIS FILE IS GENERATED. DO NOT EDIT MANUALLY.
// Generator: scripts/bridge_generator/generate.py
// Schema: scripts/bridge_generator/schemas/barcode.json

import Foundation
import ScanditFrameworksCore

/// Per-method `LogRecord` level and category overrides for the barcode
/// bridge surface. Consulted by `ScanditLogger.emit`: per-frame / per-scan
/// callbacks log at `.trace` under their category label, so they only show once
/// the level is raised to `.trace`.
///
/// Registered as a side effect of the generated `<Module>CommandFactory`'s
/// first `create` call -- no customer wiring required.
enum LogMetadata {
    static let metadata: [String: MethodLogMetadata] = [
        "finishBarcodeCaptureDidUpdateSession": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeCaptureDidScan": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeSelectionDidSelect": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeSelectionDidUpdateSession": MethodLogMetadata(level: .trace, category: .events),
        "finishBrushForAimedBarcodeCallback": MethodLogMetadata(level: .trace, category: .events),
        "finishBrushForTrackedBarcodeCallback": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeBatchDidUpdateSessionCallback": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeCountBrushForRecognizedBarcode": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeCountBrushForRecognizedBarcodeNotInList": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeCountBrushForAcceptedBarcode": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeCountBrushForRejectedBarcode": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeCountOnScan": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeCountOnSessionUpdated": MethodLogMetadata(level: .trace, category: .events),
        "finishSparkScanDidUpdateSession": MethodLogMetadata(level: .trace, category: .events),
        "finishSparkScanDidScan": MethodLogMetadata(level: .trace, category: .events),
        "finishPickAction": MethodLogMetadata(level: .trace, category: .events),
        "finishOnProductIdentifierForItems": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodePickViewHighlightStyleCustomViewProviderViewForRequest": MethodLogMetadata(
            level: .trace,
            category: .events
        ),
        "finishBarcodePickViewHighlightStyleAsyncProviderStyleForRequest": MethodLogMetadata(
            level: .trace,
            category: .events
        ),
        "finishBarcodeArFilterBarcodes": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeArAnnotationForBarcode": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeArHighlightForBarcode": MethodLogMetadata(level: .trace, category: .events),
        "finishBarcodeArOnDidUpdateSession": MethodLogMetadata(level: .trace, category: .events),
    ]

    static let registered: Void = {
        ScanditLogger.shared.registerMethodMetadata(metadata)
    }()
}
