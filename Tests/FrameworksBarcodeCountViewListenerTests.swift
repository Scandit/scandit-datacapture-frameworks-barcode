/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

/// Coverage for `icon(for:event:defaultIcon:)`: it returns the default icon unless the registry
/// holds the view's icon event; the app's reply then supplies the icon.
///
/// A real `BarcodeCountView` cannot be constructed in a unit test (it needs a licensed
/// `DataCaptureContext`), and no other test in this target attempts it, so this drives the
/// `icon(for:event:defaultIcon:)` helper directly - it was made `internal` (see the listener
/// source) specifically to allow this.
final class FrameworksBarcodeCountViewListenerTests: XCTestCase {

    private let viewId = 1

    private let trackedBarcode = TrackedBarcode(
        trackedBarcodeInfo: TrackedBarcodeInfo(symbology: .code128, data: "1234")
    )

    // MARK: - iconForRecognizedBarcode

    func testIconForRecognizedBarcode_platformSubscriberOnly_emitsAndReturnsDefault() {
        assertIcon(
            event: .iconForRecognizedBarcode,
            defaultIcon: BarcodeCountView.defaultRecognizedIcon,
            hasListener: true
        )
    }

    func testIconForRecognizedBarcode_withoutSubscriber_doesNotEmitButReturnsDefault() {
        assertIcon(
            event: .iconForRecognizedBarcode,
            defaultIcon: BarcodeCountView.defaultRecognizedIcon,
            hasListener: false
        )
    }

    // MARK: - iconForRecognizedBarcodeNotInList

    func testIconForRecognizedBarcodeNotInList_platformSubscriberOnly_emitsAndReturnsDefault() {
        assertIcon(
            event: .iconForRecognizedBarcodeNotInList,
            defaultIcon: BarcodeCountView.defaultNotInListIcon,
            hasListener: true
        )
    }

    func testIconForRecognizedBarcodeNotInList_withoutSubscriber_doesNotEmitButReturnsDefault() {
        assertIcon(
            event: .iconForRecognizedBarcodeNotInList,
            defaultIcon: BarcodeCountView.defaultNotInListIcon,
            hasListener: false
        )
    }

    // MARK: - iconForAcceptedBarcode

    func testIconForAcceptedBarcode_platformSubscriberOnly_emitsAndReturnsDefault() {
        assertIcon(
            event: .iconForAcceptedBarcode,
            defaultIcon: BarcodeCountView.defaultAcceptedIcon,
            hasListener: true
        )
    }

    func testIconForAcceptedBarcode_withoutSubscriber_doesNotEmitButReturnsDefault() {
        assertIcon(
            event: .iconForAcceptedBarcode,
            defaultIcon: BarcodeCountView.defaultAcceptedIcon,
            hasListener: false
        )
    }

    // MARK: - iconForRejectedBarcode

    func testIconForRejectedBarcode_platformSubscriberOnly_emitsAndReturnsDefault() {
        assertIcon(
            event: .iconForRejectedBarcode,
            defaultIcon: BarcodeCountView.defaultRejectedIcon,
            hasListener: true
        )
    }

    func testIconForRejectedBarcode_withoutSubscriber_doesNotEmitButReturnsDefault() {
        assertIcon(
            event: .iconForRejectedBarcode,
            defaultIcon: BarcodeCountView.defaultRejectedIcon,
            hasListener: false
        )
    }

    // MARK: - Registered app callback returns nil

    func testIconForRecognizedBarcode_registered_emitsAndReturnsNil() {
        assertRegisteredIconIsNil(.iconForRecognizedBarcode, BarcodeCountView.defaultRecognizedIcon)
    }

    func testIconForRecognizedBarcodeNotInList_registered_emitsAndReturnsNil() {
        assertRegisteredIconIsNil(.iconForRecognizedBarcodeNotInList, BarcodeCountView.defaultNotInListIcon)
    }

    func testIconForAcceptedBarcode_registered_emitsAndReturnsNil() {
        assertRegisteredIconIsNil(.iconForAcceptedBarcode, BarcodeCountView.defaultAcceptedIcon)
    }

    func testIconForRejectedBarcode_registered_emitsAndReturnsNil() {
        assertRegisteredIconIsNil(.iconForRejectedBarcode, BarcodeCountView.defaultRejectedIcon)
    }

    func testIconForRecognizedBarcode_registeredForOtherView_returnsDefault() {
        let event = BarcodeCountViewListenerEvent.iconForRecognizedBarcode
        ListenerRegistry.shared.addListener(eventName: event.rawValue, target: .view(viewId + 1))
        let sut = FrameworksBarcodeCountViewListener(
            emitter: RegistryEmitter(platformEmitter: RecordingEmitter(hasListener: true), registry: .shared),
            viewId: viewId
        )

        let icon = sut.icon(for: trackedBarcode, event: event, defaultIcon: BarcodeCountView.defaultRecognizedIcon)

        XCTAssertTrue(icon === BarcodeCountView.defaultRecognizedIcon)
    }

    func testTakePendingIconRequests_drainsOnlyTheGivenEvent() {
        ListenerRegistry.shared.addListener(
            eventName: BarcodeCountViewListenerEvent.iconForAcceptedBarcode.rawValue,
            target: .view(viewId)
        )
        ListenerRegistry.shared.addListener(
            eventName: BarcodeCountViewListenerEvent.iconForRejectedBarcode.rawValue,
            target: .view(viewId)
        )
        let sut = FrameworksBarcodeCountViewListener(
            emitter: RegistryEmitter(platformEmitter: RecordingEmitter(hasListener: true), registry: .shared),
            viewId: viewId
        )
        _ = sut.icon(
            for: trackedBarcode,
            event: .iconForAcceptedBarcode,
            defaultIcon: BarcodeCountView.defaultAcceptedIcon
        )
        _ = sut.icon(
            for: trackedBarcode,
            event: .iconForRejectedBarcode,
            defaultIcon: BarcodeCountView.defaultRejectedIcon
        )

        XCTAssertEqual(sut.takePendingIconRequests(for: .iconForAcceptedBarcode).count, 1)
        XCTAssertTrue(sut.takePendingIconRequests(for: .iconForAcceptedBarcode).isEmpty)
        XCTAssertNotNil(sut.getTrackedBarcodeForIcon(with: trackedBarcode.identifier, for: .iconForRejectedBarcode))
    }

    func testIcon_replyDuringEmit_findsItsRequest() {
        let platform = RecordingEmitter(hasListener: true)
        let sut = FrameworksBarcodeCountViewListener(emitter: platform, viewId: viewId)
        var replyFound: TrackedBarcode?
        platform.onEmit = { [trackedBarcode] in
            replyFound = sut.getTrackedBarcodeForIcon(with: trackedBarcode.identifier, for: .iconForRecognizedBarcode)
        }

        _ = sut.icon(
            for: trackedBarcode,
            event: .iconForRecognizedBarcode,
            defaultIcon: BarcodeCountView.defaultRecognizedIcon
        )

        XCTAssertTrue(replyFound === trackedBarcode)
    }

    func testIcon_listenerRemovedDuringEmit_returnsDefaultAndKeepsNoRequest() {
        let eventName = BarcodeCountViewListenerEvent.iconForRecognizedBarcode.rawValue
        ListenerRegistry.shared.addListener(eventName: eventName, target: .view(viewId))
        let platform = RecordingEmitter(hasListener: true)
        platform.onEmit = { [viewId] in
            ListenerRegistry.shared.removeListener(eventName: eventName, target: .view(viewId))
        }
        let sut = FrameworksBarcodeCountViewListener(
            emitter: RegistryEmitter(platformEmitter: platform, registry: .shared),
            viewId: viewId
        )

        let icon = sut.icon(
            for: trackedBarcode,
            event: .iconForRecognizedBarcode,
            defaultIcon: BarcodeCountView.defaultRecognizedIcon
        )

        XCTAssertTrue(icon === BarcodeCountView.defaultRecognizedIcon)
        XCTAssertTrue(sut.takePendingIconRequests(for: .iconForRecognizedBarcode).isEmpty)
    }

    // MARK: - Helpers

    override func setUp() {
        super.setUp()
        ListenerRegistry.shared.reset()
    }

    override func tearDown() {
        ListenerRegistry.shared.reset()
        super.tearDown()
    }

    private func assertRegisteredIconIsNil(
        _ event: BarcodeCountViewListenerEvent,
        _ defaultIcon: BarcodeCountIcon
    ) {
        ListenerRegistry.shared.addListener(eventName: event.rawValue, target: .view(viewId))
        let platform = RecordingEmitter(hasListener: true)
        let sut = FrameworksBarcodeCountViewListener(
            emitter: RegistryEmitter(platformEmitter: platform, registry: .shared),
            viewId: viewId
        )

        let icon = sut.icon(for: trackedBarcode, event: event, defaultIcon: defaultIcon)

        XCTAssertNil(icon)
        XCTAssertEqual(platform.emittedEventNames, [event.rawValue])
    }

    private func assertIcon(
        event: BarcodeCountViewListenerEvent,
        defaultIcon: BarcodeCountIcon,
        hasListener: Bool
    ) {
        let emitter = RecordingEmitter(hasListener: hasListener)
        let sut = FrameworksBarcodeCountViewListener(emitter: emitter, viewId: viewId)

        let icon = sut.icon(for: trackedBarcode, event: event, defaultIcon: defaultIcon)

        XCTAssertNotNil(icon, "default icon when no registry listener exists")
        XCTAssertTrue(icon === defaultIcon)
        XCTAssertEqual(
            emitter.emittedEventNames,
            hasListener ? [event.rawValue] : []
        )
    }
}

private class RecordingEmitter: Emitter {
    private let hasListener: Bool
    private(set) var emittedEventNames: [String] = []
    var onEmit: (() -> Void)?

    init(hasListener: Bool) {
        self.hasListener = hasListener
    }

    func emit(name: String, payload: [String: Any?]) {
        emittedEventNames.append(name)
        onEmit?()
    }

    func hasListener(for event: String) -> Bool { hasListener }

    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { hasListener }

    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { hasListener }
}
