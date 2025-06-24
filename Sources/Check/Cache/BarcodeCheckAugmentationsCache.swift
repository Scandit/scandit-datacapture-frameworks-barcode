/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public typealias BarcodeId = String
private typealias TrackedBarcodeId = Int

public class BarcodeCheckAugmentationsCache {
    private static let DELETION_DELAY: TimeInterval = 2.0

    private let instanceId = UUID().uuidString
    private var annotationsCache = ConcurrentDictionary<BarcodeId, BarcodeCheckAnnotation>()
    private var highlightsCache = ConcurrentDictionary<BarcodeId, BarcodeCheckHighlight>()
    private var trackedBarcodeCache = ConcurrentDictionary<TrackedBarcodeId, BarcodeId>()
    private var barcodeCheckHighlightProviderCallback = ConcurrentDictionary<BarcodeId, HighlightCallbackData>()
    private var barcodeCheckAnnotationProviderCallback = ConcurrentDictionary<BarcodeId, AnnotationCallbackData>()

    // The native SDK has implemented a mechanism where the items are not immediately removed from the cache but
    // only marked for deletion and deleted after a delay. We need to have the same mechanism in the frameworks to
    // avoid not finding annotations or highlights in our cache.
    private var markedForDeletion = ConcurrentDictionary<BarcodeId, Timer>()

    func updateFromSession(_ session: BarcodeCheckSession) {
        for trackedBarcode in session.addedTrackedBarcodes {
            cancelDeletion(for: trackedBarcode.barcode.uniqueId)
            trackedBarcodeCache.setValue(trackedBarcode.barcode.uniqueId, for: trackedBarcode.identifier)
        }

        for trackedBarcodeId in session.removedTrackedBarcodes {
            if let barcodeId = trackedBarcodeCache.removeValue(for: trackedBarcodeId) {
                scheduleDeletion(for: barcodeId)
            }
        }
    }

    private func scheduleDeletion(for barcodeId: BarcodeId) {
        if let existingTimer = markedForDeletion.removeValue(for: barcodeId) {
            existingTimer.invalidate()
        }

        let timer = Timer.scheduledTimer(withTimeInterval: Self.DELETION_DELAY, repeats: false) { [weak self] _ in
            self?.performDeletion(for: barcodeId)
        }
        markedForDeletion.setValue(timer, for: barcodeId)
    }

    private func performDeletion(for barcodeId: BarcodeId) {
        _ = annotationsCache.removeValue(for: barcodeId)
        _ = highlightsCache.removeValue(for: barcodeId)
        _ = barcodeCheckHighlightProviderCallback.removeValue(for: barcodeId)
        _ = barcodeCheckAnnotationProviderCallback.removeValue(for: barcodeId)
    }

    func cancelDeletion(for barcodeId: BarcodeId) {
        if let timer = markedForDeletion.removeValue(for: barcodeId) {
            timer.invalidate()
        }
    }

    func addHighlightProviderCallback(barcodeId: BarcodeId, callback: HighlightCallbackData) {
        barcodeCheckHighlightProviderCallback.setValue(callback, for: barcodeId)
    }

    func getHighlightProviderCallback(barcodeId: BarcodeId) -> HighlightCallbackData? {
        return barcodeCheckHighlightProviderCallback.getValue(for: barcodeId)
    }

    func addHighlight(barcodeId: BarcodeId, highlight: BarcodeCheckHighlight) {
        highlightsCache.setValue(highlight, for: barcodeId)
    }

    func getHighlight(barcodeId: BarcodeId) -> BarcodeCheckHighlight? {
        return highlightsCache.getValue(for: barcodeId)
    }

    func addAnnotationProviderCallback(barcodeId: BarcodeId, callback: AnnotationCallbackData) {
        barcodeCheckAnnotationProviderCallback.setValue(callback, for: barcodeId)
    }

    func getAnnotationProviderCallback(barcodeId: BarcodeId) -> AnnotationCallbackData? {
        return barcodeCheckAnnotationProviderCallback.getValue(for: barcodeId)
    }

    func addAnnotation(barcodeId: BarcodeId, annotation: BarcodeCheckAnnotation) {
        annotationsCache.setValue(annotation, for: barcodeId)
    }

    func getAnnotation(barcodeId: BarcodeId) -> BarcodeCheckAnnotation? {
        return annotationsCache.getValue(for: barcodeId)
    }

    func clear() {
        markedForDeletion.getAllValues().forEach { timer in
            timer.value.invalidate()
        }
        markedForDeletion.removeAllValues()
        trackedBarcodeCache.removeAllValues()
        annotationsCache.removeAllValues()
        highlightsCache.removeAllValues()
        barcodeCheckHighlightProviderCallback.removeAllValues()
        barcodeCheckAnnotationProviderCallback.removeAllValues()
    }
}
