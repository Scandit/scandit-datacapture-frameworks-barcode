/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum BarcodeArAugmentationsEvents: String, CaseIterable {
    case evicted = "BarcodeArAugmentations.evicted"
}

/// Feeds the augmentations cache from the session, and nothing else.
///
/// The providers add to that cache whenever a barcode appears, but they have no "disappeared"
/// counterpart: the session's removed tracked barcodes are the only removal signal the frameworks
/// layer gets. The view therefore keeps this listener attached for its whole life, independently of
/// the app-facing `FrameworksBarcodeArListener`, so eviction never depends on the app subscribing
/// to `didUpdateSession`.
open class FrameworksBarcodeArCacheListener: NSObject, BarcodeArListener {
    private let cache: BarcodeArAugmentationsCache

    public init(cache: BarcodeArAugmentationsCache) {
        self.cache = cache
    }

    public func barcodeAr(
        _ barcodeAr: BarcodeAr,
        didUpdate session: BarcodeArSession,
        frameData: any FrameData
    ) {
        cache.updateFromSession(session)
    }
}
