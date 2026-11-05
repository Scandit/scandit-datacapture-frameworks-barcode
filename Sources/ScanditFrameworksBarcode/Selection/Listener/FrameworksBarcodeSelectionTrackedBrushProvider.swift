/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeSelectionTrackedBrushProviderEvent: String, CaseIterable {
    case brushForBarcode = "BarcodeSelectionTrackedBrushProvider.brushForBarcode"
}

open class FrameworksBarcodeSelectionTrackedBrushProvider: NSObject, BarcodeSelectionBrushProvider {
    private let emitter: Emitter
    private let cache = FrameworksBarcodeSelectionBrushCache()

    private let brushForBarcodeEvent = Event(
        name: FrameworksBarcodeSelectionTrackedBrushProviderEvent.brushForBarcode.rawValue
    )

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    public func brush(for barcode: Barcode) -> Brush? {
        let eventName = FrameworksBarcodeSelectionTrackedBrushProviderEvent.brushForBarcode.rawValue
        guard emitter.hasListener(for: eventName) else { return nil }
        return cache.brush(for: barcode.selectionIdentifier) {
            let payload = SchemaTypes.BarcodeSelectionTrackedBrushProviderBrushForBarcode(
                barcode: barcode.jsonString,
                event: eventName
            ).toDictionary()
            brushForBarcodeEvent.emit(on: emitter, payload: payload)
        }
    }

    public func finishCallback(brushJson: String?, selectionIdentifier: String?) {
        cache.finish(brushJson: brushJson, selectionIdentifier: selectionIdentifier)
    }

    public func clearCache() {
        cache.clear()
    }
}
