/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeCountStatusProviderEvent: String, CaseIterable {
    case onStatusRequested = "BarcodeCountStatusProvider.onStatusRequested"
}

open class FrameworksBarcodeCountStatusProvider: NSObject, BarcodeCountStatusProvider {
    private let events = ConcurrentDictionary<String, BarcodeCountStatusProviderRequest>()

    private let emitter: Emitter
    private let viewId: Int
    private let onStatusRequestedEvent = Event(
        name: FrameworksBarcodeCountStatusProviderEvent.onStatusRequested.rawValue
    )

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func statusRequested(for barcodes: [TrackedBarcode], callback: BarcodeCountStatusProviderCallback) {
        guard emitter.hasListener(for: FrameworksBarcodeCountStatusProviderEvent.onStatusRequested.rawValue) else {
            return
        }

        let request = BarcodeCountStatusProviderRequest(barcodes: barcodes, callback: callback)

        addEvent(request: request)

        onStatusRequestedEvent.emit(
            on: emitter,
            payload: [
                "barcodes": barcodes.map { $0.jsonString },
                BarcodeCountStatusProviderRequest.id: request.requestId,
                "viewId": self.viewId,
            ]
        )
    }

    public func submitCallbackResult(resultJson: String) {
        guard let result = BarcodeCountStatusProviderResult.createFromJson(statusJson: resultJson) else {
            return
        }

        guard let event = getEvent(for: result.requestId) else {
            return
        }

        do {
            let statusesForBarcodes = try result.get(barcodesFromEvent: event.barcodes)

            event.callback.onStatusReady(statusesForBarcodes)
        } catch {
            Log.error(error)
        }
    }

    private func addEvent(request: BarcodeCountStatusProviderRequest) {
        events.setValue(request, for: request.requestId)
    }

    private func getEvent(for key: String) -> BarcodeCountStatusProviderRequest? {
        events.getValue(for: key)
    }

    private func removeEvent(for key: String) {
        _ = events.removeValue(for: key)
    }
}
