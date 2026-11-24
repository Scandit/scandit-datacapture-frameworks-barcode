/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class FrameworksBarcodeBatchAdvancedOverlayListener: NSObject, BarcodeBatchAdvancedOverlayDelegate {
    private let emitter: Emitter
    private let fullPayloadGate: TrackedBarcodeFullPayloadGate

    public init(emitter: Emitter, fullPayloadGate: TrackedBarcodeFullPayloadGate = TrackedBarcodeFullPayloadGate()) {
        self.emitter = emitter
        self.fullPayloadGate = fullPayloadGate
    }

    private let offsetForTrackedBarcodeEvent = Event(.offsetForTrackedBarcode)
    private let anchorForTrackedBarcodeEvent = Event(.anchorForTrackedBarcode)
    private let widgetForTrackedBarcodeEvent = Event(.widgetForTrackedBarcode)

    public func barcodeBatchAdvancedOverlay(
        _ overlay: BarcodeBatchAdvancedOverlay,
        viewFor trackedBarcode: TrackedBarcode
    ) -> UIView? {
        if emitter.hasListener(for: widgetForTrackedBarcodeEvent) {
            widgetForTrackedBarcodeEvent.emit(
                on: emitter,
                payload: payload(for: trackedBarcode) { full, identifier, location in
                    SchemaTypes.BarcodeBatchAdvancedOverlayListenerViewForTrackedBarcode(
                        trackedBarcode: full,
                        identifier: identifier,
                        location: location,
                        event: FrameworksBarcodeBatchEvent.widgetForTrackedBarcode.rawValue
                    ).toDictionary()
                }
            )
        }
        return nil
    }

    public func barcodeBatchAdvancedOverlay(
        _ overlay: BarcodeBatchAdvancedOverlay,
        anchorFor trackedBarcode: TrackedBarcode
    ) -> Anchor {
        if emitter.hasListener(for: anchorForTrackedBarcodeEvent) {
            anchorForTrackedBarcodeEvent.emit(
                on: emitter,
                payload: payload(for: trackedBarcode) { full, identifier, location in
                    SchemaTypes.BarcodeBatchAdvancedOverlayListenerAnchorForTrackedBarcode(
                        trackedBarcode: full,
                        identifier: identifier,
                        location: location,
                        event: FrameworksBarcodeBatchEvent.anchorForTrackedBarcode.rawValue
                    ).toDictionary()
                }
            )
        }
        return .center
    }

    public func barcodeBatchAdvancedOverlay(
        _ overlay: BarcodeBatchAdvancedOverlay,
        offsetFor trackedBarcode: TrackedBarcode
    ) -> PointWithUnit {
        if emitter.hasListener(for: offsetForTrackedBarcodeEvent) {
            offsetForTrackedBarcodeEvent.emit(
                on: emitter,
                payload: payload(for: trackedBarcode) { full, identifier, location in
                    SchemaTypes.BarcodeBatchAdvancedOverlayListenerOffsetForTrackedBarcode(
                        trackedBarcode: full,
                        identifier: identifier,
                        location: location,
                        event: FrameworksBarcodeBatchEvent.offsetForTrackedBarcode.rawValue
                    ).toDictionary()
                }
            )
        }
        return .zero
    }

    /// Builds the emission payload for a tap on `trackedBarcode`'s view.
    ///
    /// The didTap emission itself does not fire from this delegate's own callbacks (it fires
    /// from `BarcodeBatchModule`'s tap-gesture / legacy view-setting paths instead, since that
    /// is where the module already tracks the tapped `TrackedBarcode`), so the module calls
    /// into this method to share the same full-payload gate as the other three events.
    public func payload(forTappedTrackedBarcode trackedBarcode: TrackedBarcode) -> [String: Any] {
        payload(for: trackedBarcode) { full, identifier, location in
            SchemaTypes.BarcodeBatchAdvancedOverlayListenerDidTapViewForTrackedBarcode(
                trackedBarcode: full,
                identifier: identifier,
                location: location,
                event: FrameworksBarcodeBatchEvent.didTapViewForTrackedBarcode.rawValue
            ).toDictionary()
        }
    }

    /// Resets the full-payload gate, so the next emission for every identifier is full again.
    /// Called whenever the listener registration on the other side of the bridge resets (fresh
    /// JS/Dart subscription, overlay recreation, module teardown/dispose).
    public func reset() {
        fullPayloadGate.reset()
    }

    /// Builds the emission payload for `trackedBarcode`: the full TrackedBarcode JSON the first
    /// time a given identifier is seen, and just `{identifier, location}` on every repeat ask
    /// for an identifier already sent in full - the location is always current-frame, only the
    /// rest of the (unchanging, ~1.1 KB) TrackedBarcode content is elided.
    ///
    /// The four call sites each have their own generated schema type (identical shape:
    /// `trackedBarcode`/`identifier`/`location`, all optional), so `toDictionary()` is supplied
    /// by the caller rather than hardcoded here.
    // `event` is passed explicitly at every call site below, even though the `Event.emit`
    // wrapper re-assigns the same string on iOS (`Event.swift`). That makes a wrong const
    // silently CORRECTED here and observable only on Android, where nothing injects it — so
    // the Kotlin value assertions are the real guard. Do not "simplify" either side by
    // analogy with the other.
    private func payload(
        for trackedBarcode: TrackedBarcode,
        toDictionary: (_ full: String?, _ identifier: Int?, _ location: String?) -> [String: Any]
    ) -> [String: Any] {
        if fullPayloadGate.shouldEmitFull(identifier: trackedBarcode.identifier) {
            return toDictionary(trackedBarcode.jsonString, nil, nil)
        }
        return toDictionary(nil, trackedBarcode.identifier, trackedBarcode.location.jsonString)
    }
}
