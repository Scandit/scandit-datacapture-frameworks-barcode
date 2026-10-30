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

    private let semaphore = DispatchSemaphore(value: 0)
    private let lock = NSLock()
    private var pendingResult: [String] = []

    private let filterBarcodesEvent = Event(name: BarcodeArFilterEvents.filterBarcodes.rawValue)

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func filterBarcodes(_ barcodes: [Barcode]) -> [Barcode] {
        let barcodeMap = Dictionary(uniqueKeysWithValues: barcodes.map { ($0.uniqueId, $0) })

        filterBarcodesEvent.emit(
            on: emitter,
            payload: [
                "barcodes": barcodes.map { b in
                    ["barcode": b.jsonString, "barcodeId": b.uniqueId]
                },
                "viewId": viewId,
            ]
        )

        let timeout = DispatchTime.now() + .seconds(2)
        if semaphore.wait(timeout: timeout) == .timedOut {
            return barcodes
        }

        lock.lock()
        let ids = pendingResult
        lock.unlock()

        return ids.compactMap { barcodeMap[$0] }
    }

    public func finishFilterBarcodes(filteredBarcodesJson: String) {
        guard let data = filteredBarcodesJson.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let ids = json["barcodes"] as? [String]
        else {
            semaphore.signal()
            return
        }
        lock.lock()
        pendingResult = ids
        lock.unlock()
        semaphore.signal()
    }
}
