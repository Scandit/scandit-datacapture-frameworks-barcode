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
    private let lock = NSLock()
    private var events: [String: BarcodeCountStatusProviderRequest] = [:]
    private var isAttached = false

    private let emitter: Emitter
    private let viewId: Int
    private let onStatusRequestedEvent = Event(
        name: FrameworksBarcodeCountStatusProviderEvent.onStatusRequested.rawValue
    )

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func attach() {
        withLock { isAttached = true }
    }

    public func detach() {
        let pending: [BarcodeCountStatusProviderRequest] = withLock {
            isAttached = false
            let drained = Array(events.values)
            events.removeAll()
            return drained
        }

        for request in pending {
            request.callback.onStatusReady(BarcodeCountStatusAbortResult(errorMessage: nil))
        }
    }

    public func statusRequested(for barcodes: [TrackedBarcode], callback: BarcodeCountStatusProviderCallback) {
        let request: BarcodeCountStatusProviderRequest? = withLock {
            let hasListener = emitter.hasViewSpecificListenersForEvent(
                viewId,
                for: FrameworksBarcodeCountStatusProviderEvent.onStatusRequested.rawValue
            )
            guard isAttached, hasListener else { return nil }
            let newRequest = BarcodeCountStatusProviderRequest(barcodes: barcodes, callback: callback)
            events[newRequest.requestId] = newRequest
            return newRequest
        }

        guard let request else {
            callback.onStatusReady(BarcodeCountStatusAbortResult(errorMessage: nil))
            return
        }

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

        guard let event = withLock({ events.removeValue(forKey: result.requestId) }) else {
            return
        }

        do {
            let statusesForBarcodes = try result.get(barcodesFromEvent: event.barcodes)

            event.callback.onStatusReady(statusesForBarcodes)
        } catch {
            Log.error(error)
            event.callback.onStatusReady(BarcodeCountStatusAbortResult(errorMessage: nil))
        }
    }

    private func withLock<T>(_ body: () -> T) -> T {
        lock.lock()
        defer { lock.unlock() }
        return body()
    }
}
