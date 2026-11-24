/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

fileprivate extension Int {
    func key(for event: BarcodeCountViewListenerEvent) -> String {
        "\(event.rawValue)-\(self)"
    }
}

fileprivate extension Event {
    init(_ event: BarcodeCountViewListenerEvent) {
        self.init(name: event.rawValue)
    }
}

fileprivate extension Emitter {
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: BarcodeCountViewListenerEvent) -> Bool {
        hasViewSpecificListenersForEvent(viewId, for: event.rawValue)
    }
}

public enum BarcodeCountViewListenerEvent: String, CaseIterable {
    case brushForRecognizedBarcode = "BarcodeCountViewListener.brushForRecognizedBarcode"
    case brushForRecognizedBarcodeNotInList = "BarcodeCountViewListener.brushForRecognizedBarcodeNotInList"
    case brushForAcceptedBarcode = "BarcodeCountViewListener.brushForAcceptedBarcode"
    case brushForRejectedBarcode = "BarcodeCountViewListener.brushForRejectedBarcode"
    case iconForRecognizedBarcode = "BarcodeCountViewListener.iconForRecognizedBarcode"
    case iconForRecognizedBarcodeNotInList = "BarcodeCountViewListener.iconForRecognizedBarcodeNotInList"
    case iconForAcceptedBarcode = "BarcodeCountViewListener.iconForAcceptedBarcode"
    case iconForRejectedBarcode = "BarcodeCountViewListener.iconForRejectedBarcode"
    case didCompleteCaptureList = "BarcodeCountViewListener.didCompleteCaptureList"
    case didTapCluster = "BarcodeCountViewListener.didTapCluster"

    case didTapRecognizedBarcode = "BarcodeCountViewListener.didTapRecognizedBarcode"
    case didTapFilteredBarcode = "BarcodeCountViewListener.didTapFilteredBarcode"
    case didTapRecognizedBarcodeNotInList = "BarcodeCountViewListener.didTapRecognizedBarcodeNotInList"
    case didTapAcceptedBarcode = "BarcodeCountViewListener.didTapAcceptedBarcode"
    case didTapRejectedBarcode = "BarcodeCountViewListener.didTapRejectedBarcode"
}

open class FrameworksBarcodeCountViewListener: NSObject, BarcodeCountViewDelegate {
    private let emitter: Emitter
    private let viewId: Int

    private let brushForRecognizedBarcodeEvent = Event(.brushForRecognizedBarcode)
    private let brushForRecognizedBarcodeNotInListEvent = Event(.brushForRecognizedBarcodeNotInList)
    private let brushForAcceptedBarcodeEvent = Event(.brushForAcceptedBarcode)
    private let brushForRejectedBarcodeEvent = Event(.brushForRejectedBarcode)

    private let iconForRecognizedBarcodeEvent = Event(.iconForRecognizedBarcode)
    private let iconForRecognizedBarcodeNotInListEvent = Event(.iconForRecognizedBarcodeNotInList)
    private let iconForAcceptedBarcodeEvent = Event(.iconForAcceptedBarcode)
    private let iconForRejectedBarcodeEvent = Event(.iconForRejectedBarcode)

    private let didTapRecognizedBarcodeEvent = Event(.didTapRecognizedBarcode)
    private let didTapFilteredBarcodeEvent = Event(.didTapFilteredBarcode)
    private let didTapRecognizedBarcodeNotInListEvent = Event(.didTapRecognizedBarcodeNotInList)
    private let didTapAcceptedBarcodeEvent = Event(.didTapAcceptedBarcode)
    private let didTapRejectedBarcodeEvent = Event(.didTapRejectedBarcode)
    private let didCompleteCaptureList = Event(.didCompleteCaptureList)
    private let didTapCluster = Event(.didTapCluster)

    // Written on the rendering thread, answered and cleared on the main thread.
    private let brushRequests = ConcurrentDictionary<String, TrackedBarcode>()
    private let iconRequests = ConcurrentDictionary<String, TrackedBarcode>()

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    private func eventDescriptor(for event: BarcodeCountViewListenerEvent) -> Event {
        switch event {
        case .brushForRecognizedBarcode:
            return brushForRecognizedBarcodeEvent
        case .brushForRecognizedBarcodeNotInList:
            return brushForRecognizedBarcodeNotInListEvent
        case .brushForAcceptedBarcode:
            return brushForAcceptedBarcodeEvent
        case .brushForRejectedBarcode:
            return brushForRejectedBarcodeEvent
        case .iconForRecognizedBarcode:
            return iconForRecognizedBarcodeEvent
        case .iconForRecognizedBarcodeNotInList:
            return iconForRecognizedBarcodeNotInListEvent
        case .iconForAcceptedBarcode:
            return iconForAcceptedBarcodeEvent
        case .iconForRejectedBarcode:
            return iconForRejectedBarcodeEvent
        case .didTapRecognizedBarcode:
            return didTapRecognizedBarcodeEvent
        case .didTapFilteredBarcode:
            return didTapFilteredBarcodeEvent
        case .didTapRecognizedBarcodeNotInList:
            return didTapRecognizedBarcodeNotInListEvent
        case .didTapAcceptedBarcode:
            return didTapAcceptedBarcodeEvent
        case .didTapRejectedBarcode:
            return didTapRejectedBarcodeEvent
        case .didCompleteCaptureList:
            return didCompleteCaptureList
        case .didTapCluster:
            return didTapCluster
        }
    }

    // Builds the generated per-event payload for the 13 events shaped `{trackedBarcode, viewId}`
    // (brush x4, icon x4, didTap x5). `didCompleteCaptureList`/`didTapCluster` carry a different
    // shape and are built inline at their own call sites below.
    private func trackedBarcodePayload(
        for event: BarcodeCountViewListenerEvent,
        trackedBarcode: TrackedBarcode
    ) -> [String: Any] {
        let jsonString = trackedBarcode.jsonString
        switch event {
        case .brushForRecognizedBarcode:
            return SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .brushForRecognizedBarcodeNotInList:
            return SchemaTypes.BarcodeCountViewListenerBrushForRecognizedBarcodeNotInList(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .brushForAcceptedBarcode:
            return SchemaTypes.BarcodeCountViewListenerBrushForAcceptedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .brushForRejectedBarcode:
            return SchemaTypes.BarcodeCountViewListenerBrushForRejectedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .iconForRecognizedBarcode:
            return SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .iconForRecognizedBarcodeNotInList:
            return SchemaTypes.BarcodeCountViewListenerIconForRecognizedBarcodeNotInList(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .iconForAcceptedBarcode:
            return SchemaTypes.BarcodeCountViewListenerIconForAcceptedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .iconForRejectedBarcode:
            return SchemaTypes.BarcodeCountViewListenerIconForRejectedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .didTapRecognizedBarcode:
            return SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .didTapFilteredBarcode:
            return SchemaTypes.BarcodeCountViewListenerDidTapFilteredBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .didTapRecognizedBarcodeNotInList:
            return SchemaTypes.BarcodeCountViewListenerDidTapRecognizedBarcodeNotInList(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .didTapAcceptedBarcode:
            return SchemaTypes.BarcodeCountViewListenerDidTapAcceptedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .didTapRejectedBarcode:
            return SchemaTypes.BarcodeCountViewListenerDidTapRejectedBarcode(
                trackedBarcode: jsonString,
                viewId: viewId,
                event: nil
            ).toDictionary()
        case .didCompleteCaptureList, .didTapCluster:
            preconditionFailure("\(event) does not carry a trackedBarcode payload")
        }
    }

    // Internal so FrameworksBarcodeCountViewListenerTests can drive it; the delegate methods pass
    // the view's own brush for the state.
    func brush(
        for trackedBarcode: TrackedBarcode,
        event: BarcodeCountViewListenerEvent,
        viewBrush: Brush?
    ) -> Brush? {
        // The placeholder (never nil) hides the default flash until the registered app callback
        // replies via setBrush(_:for:); stored before the emit, re-checked after it.
        let registered = emitter.hasRegisteredViewListenersForEvent(viewId, for: event.rawValue)
        if registered || emitter.hasViewSpecificListenersForEvent(viewId, for: event) {
            let key = trackedBarcode.identifier.key(for: event)
            brushRequests.setValue(trackedBarcode, for: key)
            eventDescriptor(for: event).emit(
                on: emitter,
                payload: trackedBarcodePayload(for: event, trackedBarcode: trackedBarcode)
            )
            if registered,
                !emitter.hasRegisteredViewListenersForEvent(viewId, for: event.rawValue),
                brushRequests.removeValue(for: key) != nil
            {
                return viewBrush
            }
        }
        return registered ? Brush.transparent : viewBrush
    }

    // Internal (not private) so it is reachable via @testable import from
    // FrameworksBarcodeCountViewListenerTests — a real BarcodeCountView cannot be constructed in
    // a unit test (it needs a licensed DataCaptureContext), so the regression test drives this
    // helper directly with the same default icons the public delegate methods pass.
    func icon(
        for trackedBarcode: TrackedBarcode,
        event: BarcodeCountViewListenerEvent,
        defaultIcon: BarcodeCountIcon
    ) -> BarcodeCountIcon? {
        // nil (no default flash) only when a registered app callback will reply via setIcon(_:for:).
        // Stored before the emit for fast replies; re-checked after it for a listener removed meanwhile.
        let registered = emitter.hasRegisteredViewListenersForEvent(viewId, for: event.rawValue)
        if registered || emitter.hasViewSpecificListenersForEvent(viewId, for: event) {
            let key = trackedBarcode.identifier.key(for: event)
            iconRequests.setValue(trackedBarcode, for: key)
            eventDescriptor(for: event).emit(
                on: emitter,
                payload: trackedBarcodePayload(for: event, trackedBarcode: trackedBarcode)
            )
            if registered,
                !emitter.hasRegisteredViewListenersForEvent(viewId, for: event.rawValue),
                iconRequests.removeValue(for: key) != nil
            {
                return defaultIcon
            }
        }
        return registered ? nil : defaultIcon
    }

    private func emit(event: BarcodeCountViewListenerEvent, for trackedBarcode: TrackedBarcode) {
        if emitter.hasViewSpecificListenersForEvent(viewId, for: event) {
            eventDescriptor(for: event).emit(
                on: emitter,
                payload: trackedBarcodePayload(for: event, trackedBarcode: trackedBarcode)
            )
        }
    }

    func getTrackedBarcodeForBrush(
        with trackedBarcodeId: Int,
        for event: BarcodeCountViewListenerEvent
    ) -> TrackedBarcode? {
        brushRequests.removeValue(for: trackedBarcodeId.key(for: event))
    }

    func takePendingBrushRequests(for event: BarcodeCountViewListenerEvent) -> [TrackedBarcode] {
        let prefix = "\(event.rawValue)-"
        let keys = brushRequests.getAllValues().keys.filter { $0.hasPrefix(prefix) }
        return keys.compactMap { brushRequests.removeValue(for: $0) }
    }

    func takePendingIconRequests(for event: BarcodeCountViewListenerEvent) -> [TrackedBarcode] {
        let prefix = "\(event.rawValue)-"
        let keys = iconRequests.getAllValues().keys.filter { $0.hasPrefix(prefix) }
        return keys.compactMap { iconRequests.removeValue(for: $0) }
    }

    func getTrackedBarcodeForIcon(
        with trackedBarcodeId: Int,
        for event: BarcodeCountViewListenerEvent
    ) -> TrackedBarcode? {
        iconRequests.removeValue(for: trackedBarcodeId.key(for: event))
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForRecognizedBarcode trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForRecognizedBarcode, viewBrush: view.recognizedBrush)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForRecognizedBarcodeNotInList trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForRecognizedBarcodeNotInList, viewBrush: view.notInListBrush)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForAcceptedBarcode trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForAcceptedBarcode, viewBrush: view.acceptedBrush)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForRejectedBarcode trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForRejectedBarcode, viewBrush: view.rejectedBrush)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        iconForRecognizedBarcode trackedBarcode: TrackedBarcode
    ) -> BarcodeCountIcon? {
        icon(
            for: trackedBarcode,
            event: .iconForRecognizedBarcode,
            defaultIcon: BarcodeCountView.defaultRecognizedIcon
        )
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        iconForRecognizedBarcodeNotInList trackedBarcode: TrackedBarcode
    ) -> BarcodeCountIcon? {
        icon(
            for: trackedBarcode,
            event: .iconForRecognizedBarcodeNotInList,
            defaultIcon: BarcodeCountView.defaultNotInListIcon
        )
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        iconForAcceptedBarcode trackedBarcode: TrackedBarcode
    ) -> BarcodeCountIcon? {
        icon(
            for: trackedBarcode,
            event: .iconForAcceptedBarcode,
            defaultIcon: BarcodeCountView.defaultAcceptedIcon
        )
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        iconForRejectedBarcode trackedBarcode: TrackedBarcode
    ) -> BarcodeCountIcon? {
        icon(
            for: trackedBarcode,
            event: .iconForRejectedBarcode,
            defaultIcon: BarcodeCountView.defaultRejectedIcon
        )
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        didTapRecognizedBarcode trackedBarcode: TrackedBarcode
    ) {
        emit(event: .didTapRecognizedBarcode, for: trackedBarcode)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        didTapFilteredBarcode trackedBarcode: TrackedBarcode
    ) {
        emit(event: .didTapFilteredBarcode, for: trackedBarcode)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        didTapRecognizedBarcodeNotInList trackedBarcode: TrackedBarcode
    ) {
        emit(event: .didTapRecognizedBarcodeNotInList, for: trackedBarcode)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        didTapAcceptedBarcode trackedBarcode: TrackedBarcode
    ) {
        emit(event: .didTapAcceptedBarcode, for: trackedBarcode)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        didTapRejectedBarcode trackedBarcode: TrackedBarcode
    ) {
        emit(event: .didTapRejectedBarcode, for: trackedBarcode)
    }

    public func barcodeCountView(_ view: BarcodeCountView, didTap cluster: Cluster) {
        if emitter.hasViewSpecificListenersForEvent(viewId, for: .didTapCluster) {
            let payload = SchemaTypes.BarcodeCountViewListenerDidTapCluster(
                barcodes: cluster.barcodes.map { $0.jsonString },
                viewId: viewId,
                event: nil
            )
            eventDescriptor(for: .didTapCluster).emit(
                on: emitter,
                payload: payload.toDictionary()
            )
        }
    }

    public func didCompleteCaptureList(for view: BarcodeCountView) {
        if emitter.hasViewSpecificListenersForEvent(viewId, for: .didCompleteCaptureList) {
            let payload = SchemaTypes.BarcodeCountViewListenerDidCompleteCaptureList(
                viewId: viewId,
                event: nil
            )
            eventDescriptor(for: .didCompleteCaptureList).emit(
                on: emitter,
                payload: payload.toDictionary()
            )
        }
    }

    public func clearCache() {
        brushRequests.removeAllValues()
        iconRequests.removeAllValues()
    }
}
