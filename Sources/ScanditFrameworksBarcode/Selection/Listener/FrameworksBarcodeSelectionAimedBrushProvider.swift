/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeSelectionAimedBrushProviderEvent: String, CaseIterable {
    case brushForBarcode = "BarcodeSelectionAimedBrushProvider.brushForBarcode"
}

open class FrameworksBarcodeSelectionAimedBrushProvider: NSObject, BarcodeSelectionBrushProvider {
    private let emitter: Emitter
    private let cache = FrameworksBarcodeSelectionBrushCache()

    private let brushForBarcodeEvent = Event(
        name: FrameworksBarcodeSelectionAimedBrushProviderEvent.brushForBarcode.rawValue
    )

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    public func brush(for barcode: Barcode) -> Brush? {
        let eventName = FrameworksBarcodeSelectionAimedBrushProviderEvent.brushForBarcode.rawValue
        guard emitter.hasListener(for: eventName) else { return nil }
        return cache.brush(for: barcode.selectionIdentifier) {
            let payload = SchemaTypes.BarcodeSelectionAimedBrushProviderBrushForBarcode(
                barcode: barcode.jsonString,
                event: eventName
            ).toDictionary()
            brushForBarcodeEvent.emit(on: emitter, payload: payload)
        }
    }

    func finishCallback(brushJson: String?, selectionIdentifier: String?) {
        cache.finish(brushJson: brushJson, selectionIdentifier: selectionIdentifier)
    }

    func clearCache() {
        cache.clear()
    }
}
