/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

/// Regression coverage for SDC-33376: `icon(for:event:defaultIcon:)` must always return the
/// caller-supplied default icon, whether or not a subscriber is listening for the corresponding
/// event. Returning nil is what caused the highlight to disappear entirely, because the SDK
/// treats a set view delegate as authoritative and never falls back to its own defaults.
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

    func testIconForRecognizedBarcode_withSubscriber_emitsAndReturnsDefault() {
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

    func testIconForRecognizedBarcodeNotInList_withSubscriber_emitsAndReturnsDefault() {
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

    func testIconForAcceptedBarcode_withSubscriber_emitsAndReturnsDefault() {
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

    func testIconForRejectedBarcode_withSubscriber_emitsAndReturnsDefault() {
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

    // MARK: - Helpers

    private func assertIcon(
        event: BarcodeCountViewListenerEvent,
        defaultIcon: BarcodeCountIcon,
        hasListener: Bool
    ) {
        let emitter = RecordingEmitter(hasListener: hasListener)
        let sut = FrameworksBarcodeCountViewListener(emitter: emitter, viewId: viewId)

        let icon = sut.icon(for: trackedBarcode, event: event, defaultIcon: defaultIcon)

        XCTAssertNotNil(icon, "icon(for:event:defaultIcon:) must never return nil (SDC-33376)")
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

    init(hasListener: Bool) {
        self.hasListener = hasListener
    }

    func emit(name: String, payload: [String: Any?]) {
        emittedEventNames.append(name)
    }

    func hasListener(for event: String) -> Bool { hasListener }

    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { hasListener }

    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { hasListener }
}
