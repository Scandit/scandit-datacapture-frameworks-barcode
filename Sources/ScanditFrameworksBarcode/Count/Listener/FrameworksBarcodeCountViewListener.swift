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

    private var brushRequests: [String: TrackedBarcode] = [:]
    private var iconRequests: [String: TrackedBarcode] = [:]

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

    private func brush(for trackedBarcode: TrackedBarcode, event: BarcodeCountViewListenerEvent) -> Brush? {
        if !emitter.hasViewSpecificListenersForEvent(viewId, for: event) {
            return nil
        }
        eventDescriptor(for: event).emit(
            on: emitter,
            payload: ["trackedBarcode": trackedBarcode.jsonString, "viewId": self.viewId]
        )
        let key = trackedBarcode.identifier.key(for: event)
        brushRequests[key] = trackedBarcode
        return nil
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
        if emitter.hasViewSpecificListenersForEvent(viewId, for: event) {
            eventDescriptor(for: event).emit(
                on: emitter,
                payload: ["trackedBarcode": trackedBarcode.jsonString, "viewId": self.viewId]
            )
            let key = trackedBarcode.identifier.key(for: event)
            iconRequests[key] = trackedBarcode
        }

        // Never return nil here. The SDK treats a set view delegate as authoritative and does not
        // fall back to its own defaults, so nil means "draw no highlight at all" instead of "use
        // the default icon". Returning the default keeps the overlay visible; a later
        // finishIconFor* reply from the app still replaces it via setIcon(_:for:).
        return defaultIcon
    }

    private func emit(event: BarcodeCountViewListenerEvent, for trackedBarcode: TrackedBarcode) {
        if emitter.hasViewSpecificListenersForEvent(viewId, for: event) {
            eventDescriptor(for: event).emit(
                on: emitter,
                payload: ["trackedBarcode": trackedBarcode.jsonString, "viewId": self.viewId]
            )
        }
    }

    func getTrackedBarcodeForBrush(
        with trackedBarcodeId: Int,
        for event: BarcodeCountViewListenerEvent
    ) -> TrackedBarcode? {
        let key = trackedBarcodeId.key(for: event)
        let trackedBarcode = brushRequests[key]
        if trackedBarcode != nil {
            brushRequests.removeValue(forKey: key)
        }
        return trackedBarcode
    }

    func getTrackedBarcodeForIcon(
        with trackedBarcodeId: Int,
        for event: BarcodeCountViewListenerEvent
    ) -> TrackedBarcode? {
        let key = trackedBarcodeId.key(for: event)
        let trackedBarcode = iconRequests[key]
        if trackedBarcode != nil {
            iconRequests.removeValue(forKey: key)
        }
        return trackedBarcode
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForRecognizedBarcode trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForRecognizedBarcode)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForRecognizedBarcodeNotInList trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForRecognizedBarcodeNotInList)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForAcceptedBarcode trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForAcceptedBarcode)
    }

    public func barcodeCountView(
        _ view: BarcodeCountView,
        brushForRejectedBarcode trackedBarcode: TrackedBarcode
    ) -> Brush? {
        brush(for: trackedBarcode, event: .brushForRejectedBarcode)
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
            eventDescriptor(for: .didTapCluster).emit(
                on: emitter,
                payload: ["barcodes": cluster.barcodes.map { $0.jsonString }, "viewId": self.viewId]
            )
        }
    }

    public func didCompleteCaptureList(for view: BarcodeCountView) {
        if emitter.hasViewSpecificListenersForEvent(viewId, for: .didCompleteCaptureList) {
            eventDescriptor(for: .didCompleteCaptureList).emit(
                on: emitter,
                payload: ["viewId": self.viewId]
            )
        }
    }

    public func clearCache() {
        brushRequests.removeAll()
        iconRequests.removeAll()
    }
}
