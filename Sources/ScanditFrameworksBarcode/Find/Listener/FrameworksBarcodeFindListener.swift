/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeFindEvent: String, CaseIterable {
    case didStartSearch = "BarcodeFindListener.onSearchStarted"
    case didPauseSearch = "BarcodeFindListener.onSearchPaused"
    case didStopSearch = "BarcodeFindListener.onSearchStopped"
    case didUpdateSession = "BarcodeFindListener.didUpdateSession"
    case finishButtonTapped = "BarcodeFindViewUiListener.onFinishButtonTapped"
    case transformBarcodeData = "BarcodeFindTransformer.transformBarcodeData"
}

extension Emitter {
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: FrameworksBarcodeFindEvent) -> Bool {
        hasViewSpecificListenersForEvent(viewId, for: event.rawValue)
    }
}

// The `event` value passed into each generated payload struct is redundant on the paths that go
// through `Event.emit`: it overwrites `payload["event"]` with its own name (`Event.swift:16`).
// It is passed anyway so the payload struct is constructed complete and identical to the Android
// side. On those paths the schema's `event` const is not load-bearing, so a divergence between
// `FrameworksBarcodeFindEvent`'s raw values and the schema consts would be masked on iOS and
// caught only on Android — the raw values above are the ones to keep in step. This does NOT
// extend to the transformer: `EventWithResult.emit` calls `emitter.emit(name:payload:)` directly
// (`EventWithResult.swift:69`), so in `FrameworksBarcodeFindTransformer.swift` the explicitly
// passed `rawValue` IS the `event` value on the wire (SDC-32667).

extension Event {
    init(_ event: FrameworksBarcodeFindEvent) {
        self.init(name: event.rawValue)
    }
}

open class FrameworksBarcodeFindListener: NSObject, BarcodeFindListener {
    private let emitter: Emitter
    private let viewId: Int
    private let didStartSearchEvent = Event(.didStartSearch)
    private let didPauseSearchEvent = Event(.didPauseSearch)
    private let didStopSearchEvent = Event(.didStopSearch)
    private let didUpdateSessionEvent = Event(.didUpdateSession)

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func barcodeFindDidStartSearch(_ barcodeFind: BarcodeFind) {
        guard emitter.hasViewSpecificListenersForEvent(viewId, for: .didStartSearch) else { return }
        dispatchMain { [weak self] in
            guard let self else { return }
            let payload = SchemaTypes.BarcodeFindListenerOnSearchStarted(
                viewId: self.viewId,
                event: FrameworksBarcodeFindEvent.didStartSearch.rawValue
            ).toDictionary()
            self.didStartSearchEvent.emit(on: self.emitter, payload: payload)
        }
    }

    public func barcodeFind(_ barcodeFind: BarcodeFind, didPauseSearch foundItems: Set<BarcodeFindItem>) {
        guard emitter.hasViewSpecificListenersForEvent(viewId, for: .didPauseSearch) else { return }
        let foundItemsBarcodeData = foundItems.map { $0.searchOptions.barcodeData }
        dispatchMain { [weak self] in
            guard let self else { return }
            let payload = SchemaTypes.BarcodeFindListenerOnSearchPaused(
                foundItems: foundItemsBarcodeData,
                viewId: self.viewId,
                event: FrameworksBarcodeFindEvent.didPauseSearch.rawValue
            ).toDictionary()
            self.didPauseSearchEvent.emit(on: self.emitter, payload: payload)
        }
    }

    public func barcodeFind(_ barcodeFind: BarcodeFind, didStopSearch foundItems: Set<BarcodeFindItem>) {
        guard emitter.hasViewSpecificListenersForEvent(viewId, for: .didStopSearch) else { return }
        let foundItemsBarcodeData = foundItems.map { $0.searchOptions.barcodeData }
        dispatchMain { [weak self] in
            guard let self else { return }
            let payload = SchemaTypes.BarcodeFindListenerOnSearchStopped(
                foundItems: foundItemsBarcodeData,
                viewId: self.viewId,
                event: FrameworksBarcodeFindEvent.didStopSearch.rawValue
            ).toDictionary()
            self.didStopSearchEvent.emit(on: self.emitter, payload: payload)
        }
    }

    public func barcodeFind(_ barcodeFind: BarcodeFind, didUpdate session: BarcodeFindSession) {
        guard emitter.hasViewSpecificListenersForEvent(viewId, for: .didUpdateSession) else { return }
        let payload = SchemaTypes.BarcodeFindListenerDidUpdateSession(
            session: session.jsonString,
            viewId: self.viewId,
            event: FrameworksBarcodeFindEvent.didUpdateSession.rawValue
        ).toDictionary()
        didUpdateSessionEvent.emit(on: emitter, payload: payload)
    }
}
