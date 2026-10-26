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
                payload: payload(for: trackedBarcode)
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
                payload: payload(for: trackedBarcode)
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
                payload: payload(for: trackedBarcode)
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
        payload(for: trackedBarcode)
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
    private func payload(for trackedBarcode: TrackedBarcode) -> [String: Any] {
        if fullPayloadGate.shouldEmitFull(identifier: trackedBarcode.identifier) {
            return ["trackedBarcode": trackedBarcode.jsonString]
        }
        return [
            "identifier": trackedBarcode.identifier,
            "location": trackedBarcode.location.jsonString,
        ]
    }
}
