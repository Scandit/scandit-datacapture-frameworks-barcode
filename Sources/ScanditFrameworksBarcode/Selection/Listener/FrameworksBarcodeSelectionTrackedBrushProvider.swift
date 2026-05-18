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
    private let cachedBrushes = ConcurrentDictionary<String, Brush>()

    private let brushForBarcodeEvent = Event(
        name: FrameworksBarcodeSelectionTrackedBrushProviderEvent.brushForBarcode.rawValue
    )

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    public func brush(for barcode: Barcode) -> Brush? {
        if let brush = cachedBrushes.getValue(for: barcode.selectionIdentifier) {
            return brush
        }
        brushForBarcodeEvent.emit(on: emitter, payload: ["barcode": barcode.jsonString])
        return .transparent
    }

    public func finishCallback(brushJson: String?, selectionIdentifier: String?) {
        guard let selectionIdentifier = selectionIdentifier,
            let brushJson = brushJson, let brush = Brush(jsonString: brushJson)
        else { return }
        cachedBrushes.setValue(brush, for: selectionIdentifier)
    }

    public func clearCache() {
        cachedBrushes.removeAllValues()
    }
}
