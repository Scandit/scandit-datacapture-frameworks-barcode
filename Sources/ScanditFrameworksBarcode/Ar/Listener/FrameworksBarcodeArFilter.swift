/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum BarcodeArFilterEvents: String, CaseIterable {
    case filterBarcodes = "BarcodeArFilter.filterBarcodes"
}

public class FrameworksBarcodeArFilter: NSObject, BarcodeArFilter {
    private let emitter: Emitter
    private let viewId: Int
    private let filterBarcodesEvent: EventWithResult<[String]>

    public init(emitter: Emitter, viewId: Int, timeout: TimeInterval = defaultTimeoutInterval) {
        self.emitter = emitter
        self.viewId = viewId
        self.filterBarcodesEvent = EventWithResult(
            event: Event(name: BarcodeArFilterEvents.filterBarcodes.rawValue),
            timeout: timeout
        )
    }

    public func filterBarcodes(_ barcodes: [Barcode]) -> [Barcode] {
        // Tracked AR scans can deliver the same barcode twice in one batch;
        // keep the first occurrence rather than trapping on duplicates.
        let barcodeMap = Dictionary(barcodes.map { ($0.uniqueId, $0) }, uniquingKeysWith: { first, _ in first })

        // EventWithResult.emit does not add the event key the way Event.emit does.
        let payload = SchemaTypes.BarcodeArFilterFilterBarcodes(
            barcodes: barcodes.map { b in
                SchemaTypes.BarcodeArFilterFilterBarcodesBarcodesItem(
                    barcode: b.jsonString,
                    barcodeId: b.uniqueId
                )
            },
            viewId: viewId,
            event: BarcodeArFilterEvents.filterBarcodes.rawValue
        ).toDictionary()

        // nil means timed out, malformed answer, or closed: let every barcode through.
        guard let ids = filterBarcodesEvent.emit(on: emitter, payload: payload) else {
            return barcodes
        }
        return ids.compactMap { barcodeMap[$0] }
    }

    public func finishFilterBarcodes(filteredBarcodesJson: String) {
        guard let data = filteredBarcodesJson.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let ids = json["barcodes"] as? [String]
        else {
            filterBarcodesEvent.reset()
            return
        }
        filterBarcodesEvent.unlock(value: ids)
    }

    public func open() {
        filterBarcodesEvent.open()
    }

    public func close() {
        filterBarcodesEvent.close()
    }
}
