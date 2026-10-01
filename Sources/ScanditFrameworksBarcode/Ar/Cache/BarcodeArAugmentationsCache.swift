/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public typealias BarcodeId = String
private typealias TrackedBarcodeId = Int

public class BarcodeArAugmentationsCache {
    private static let deletionDelay: TimeInterval = 2.0

    private let instanceId = UUID().uuidString
    private var annotationsCache = ConcurrentDictionary<BarcodeId, BarcodeArAnnotation>()
    private var highlightsCache = ConcurrentDictionary<BarcodeId, BarcodeArHighlight>()
    private var trackedBarcodeCache = ConcurrentDictionary<TrackedBarcodeId, BarcodeId>()
    private var barcodeArHighlightProviderCallback = ConcurrentDictionary<BarcodeId, HighlightCallbackData>()
    private var barcodeArAnnotationProviderCallback = ConcurrentDictionary<BarcodeId, AnnotationCallbackData>()

    // The native SDK has implemented a mechanism where the items are not immediately removed from the cache but
    // only marked for deletion and deleted after a delay. We need to have the same mechanism in the frameworks to
    // avoid not finding annotations or highlights in our cache.
    private var markedForDeletion = ConcurrentDictionary<BarcodeId, Timer>()

    // Notified once a barcode's augmentations are really gone, so the script-layer caches can
    // drop the same key without re-implementing the delay-and-cancel policy above.
    private let onEvicted: (BarcodeId) -> Void

    init(onEvicted: @escaping (BarcodeId) -> Void = { _ in }) {
        self.onEvicted = onEvicted
    }

    func updateFromSession(_ session: BarcodeArSession) {
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

    // Timers are installed on and invalidated from the main run loop: the session callback
    // feeding this cache has no run loop of its own, and Timer is only valid on its installer.
    private func scheduleDeletion(for barcodeId: BarcodeId) {
        dispatchMain {
            if let existingTimer = self.markedForDeletion.removeValue(for: barcodeId) {
                existingTimer.invalidate()
            }

            let timer = Timer.scheduledTimer(withTimeInterval: Self.deletionDelay, repeats: false) { [weak self] _ in
                self?.performDeletion(for: barcodeId)
            }
            self.markedForDeletion.setValue(timer, for: barcodeId)
        }
    }

    private func performDeletion(for barcodeId: BarcodeId) {
        _ = annotationsCache.removeValue(for: barcodeId)
        _ = highlightsCache.removeValue(for: barcodeId)
        _ = barcodeArHighlightProviderCallback.removeValue(for: barcodeId)
        _ = barcodeArAnnotationProviderCallback.removeValue(for: barcodeId)
        // The fired timer would otherwise stay keyed here forever, like the Android twin drops it.
        _ = markedForDeletion.removeValue(for: barcodeId)
        onEvicted(barcodeId)
    }

    func cancelDeletion(for barcodeId: BarcodeId) {
        dispatchMain {
            if let timer = self.markedForDeletion.removeValue(for: barcodeId) {
                timer.invalidate()
            }
        }
    }

    func addHighlightProviderCallback(barcodeId: BarcodeId, callback: HighlightCallbackData) {
        barcodeArHighlightProviderCallback.setValue(callback, for: barcodeId)
    }

    func getHighlightProviderCallback(barcodeId: BarcodeId) -> HighlightCallbackData? {
        barcodeArHighlightProviderCallback.getValue(for: barcodeId)
    }

    func addHighlight(barcodeId: BarcodeId, highlight: BarcodeArHighlight) {
        highlightsCache.setValue(highlight, for: barcodeId)
    }

    func getHighlight(barcodeId: BarcodeId) -> BarcodeArHighlight? {
        highlightsCache.getValue(for: barcodeId)
    }

    func addAnnotationProviderCallback(barcodeId: BarcodeId, callback: AnnotationCallbackData) {
        barcodeArAnnotationProviderCallback.setValue(callback, for: barcodeId)
    }

    func getAnnotationProviderCallback(barcodeId: BarcodeId) -> AnnotationCallbackData? {
        barcodeArAnnotationProviderCallback.getValue(for: barcodeId)
    }

    func addAnnotation(barcodeId: BarcodeId, annotation: BarcodeArAnnotation) {
        annotationsCache.setValue(annotation, for: barcodeId)
    }

    func getAnnotation(barcodeId: BarcodeId) -> BarcodeArAnnotation? {
        annotationsCache.getValue(for: barcodeId)
    }

    func clear() {
        dispatchMain {
            self.markedForDeletion.getAllValues().forEach { timer in
                timer.value.invalidate()
            }
            self.markedForDeletion.removeAllValues()
        }
        trackedBarcodeCache.removeAllValues()
        annotationsCache.removeAllValues()
        highlightsCache.removeAllValues()
        barcodeArHighlightProviderCallback.removeAllValues()
        barcodeArAnnotationProviderCallback.removeAllValues()
    }
}
