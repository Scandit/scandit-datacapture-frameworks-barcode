/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeArAnnotationParserTests: XCTestCase {

    private let barcode = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "1234"))

    /// Held for the lifetime of the test: `BarcodeArInfoAnnotation.delegate` is a weak property,
    /// and the parser is what owns the per-slot delegates. A parser that goes out of scope takes
    /// every child annotation's delegate with it.
    private var parser: BarcodeArAnnotationParser!

    override func setUp() {
        super.setUp()
        parser = BarcodeArAnnotationParser(viewId: 1, emitter: NoopEmitter())
    }

    override func tearDown() {
        parser = nil
        super.tearDown()
    }

    // MARK: - annotationsByThreshold parsing

    func testResponsiveAnnotationWithNThresholds() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.3": \(infoAnnotationJson(headerText: "far")),
                    "0.6": \(infoAnnotationJson(headerText: "mid")),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.3, 0.6, 1.0])
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far")
        XCTAssertEqual(try slot(annotation, 0.6).header?.text, "mid")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")

        // the lowest threshold is the far-away slot, 1.0 the close-up one, in-between slots carry
        // no type - but every slot reports its own threshold
        XCTAssertEqual(try delegate(annotation, 0.3).responsiveAnnotationType, .farAway)
        XCTAssertNil(try delegate(annotation, 0.6).responsiveAnnotationType)
        XCTAssertEqual(try delegate(annotation, 1.0).responsiveAnnotationType, .closeUp)
        XCTAssertEqual(try delegate(annotation, 0.3).responsiveAnnotationThreshold, 0.3)
        XCTAssertEqual(try delegate(annotation, 0.6).responsiveAnnotationThreshold, 0.6)
        XCTAssertEqual(try delegate(annotation, 1.0).responsiveAnnotationThreshold, 1.0)

        // each slot gets its own delegate instance, so an emit can be attributed to one slot
        let farAwayDelegate = try delegate(annotation, 0.3)
        let midDelegate = try delegate(annotation, 0.6)
        XCTAssertFalse(farAwayDelegate === midDelegate)
    }

    func testResponsiveAnnotationKeepsNullSlots() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "0.5": null,
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        // the threshold slot still exists, with no annotation in it
        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.5, 1.0])
        XCTAssertNil(annotation.annotationsByThreshold[0.5] ?? nil)
        XCTAssertNotNil(annotation.annotationsByThreshold[1.0] ?? nil)
    }

    func testResponsiveAnnotationSkipsInvalidThresholdKey() throws {
        let json = responsiveAnnotationJson(
            annotationsByThreshold: """
                {
                    "not-a-number": \(infoAnnotationJson(headerText: "bogus")),
                    "1.0": \(infoAnnotationJson(headerText: "close"))
                }
                """
        )

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        // the unparseable key is dropped, the good one survives
        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [1.0])
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")
    }

    func testResponsiveAnnotationFallsBackToLegacyJson() throws {
        // the pre-N-state JSON shape, with no annotationsByThreshold key
        let json = """
            {
                "type": "barcodeArResponsiveAnnotation",
                "annotationTrigger": "highlightTap",
                "threshold": 0.4,
                "closeUpAnnotation": \(infoAnnotationJson(headerText: "close")),
                "farAwayAnnotation": \(infoAnnotationJson(headerText: "far"))
            }
            """

        let annotation = try XCTUnwrap(parse(json) as? BarcodeArResponsiveAnnotation)

        // it maps onto two slots: the threshold one (far away) and 1.0 (close up)
        XCTAssertEqual(Set(annotation.annotationsByThreshold.keys), [0.4, 1.0])
        XCTAssertEqual(try slot(annotation, 0.4).header?.text, "far")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close")
        XCTAssertEqual(try delegate(annotation, 0.4).responsiveAnnotationType, .farAway)
        XCTAssertEqual(try delegate(annotation, 1.0).responsiveAnnotationType, .closeUp)
    }

    // MARK: - updates

    func testUpdateResponsiveAnnotationUpdatesMatchingThresholds() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.3": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // each slot's own annotation is updated, no cross-talk
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far updated")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close updated")
    }

    func testUpdateResponsiveAnnotationPairsByOrderWhenThresholdsChanged() throws {
        // an annotation built with thresholds that the update no longer uses - this is what the
        // deprecated `threshold` setter does, since the native thresholds are fixed at
        // construction time
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.7": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // the slots are paired by ascending threshold order, so the configuration still reaches
        // the right annotation instead of being dropped
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far updated")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "close updated")
    }

    func testUpdateResponsiveAnnotationIgnoresExtraSlots() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        // three non-matching slots against a two-slot annotation
        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.4": \(infoAnnotationJson(headerText: "far updated")),
                        "0.6": \(infoAnnotationJson(headerText: "mid updated")),
                        "0.8": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // the slots that pair up are updated, the extra one is dropped rather than crashing or
        // overwriting an unrelated slot
        XCTAssertEqual(try slot(annotation, 0.3).header?.text, "far updated")
        XCTAssertEqual(try slot(annotation, 1.0).header?.text, "mid updated")
    }

    func testUpdateResponsiveAnnotationReusesDelegatePerSlot() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )
        let delegateBeforeUpdate = try delegate(annotation, 0.3)

        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.3": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // the cached delegate is refreshed in place, so a delegate already set on a still-live
        // child annotation keeps working
        let delegateAfterUpdate = try delegate(annotation, 0.3)
        XCTAssertTrue(delegateAfterUpdate === delegateBeforeUpdate)
    }

    func testUpdateResponsiveAnnotationAttachesTheRemappedDelegate() throws {
        let annotation = try XCTUnwrap(
            parse(
                responsiveAnnotationJson(
                    annotationsByThreshold: """
                        {
                            "0.3": \(infoAnnotationJson(headerText: "far")),
                            "1.0": \(infoAnnotationJson(headerText: "close"))
                        }
                        """
                )
            ) as? BarcodeArResponsiveAnnotation
        )

        // the deprecated threshold setter makes Dart resend the slot under a new key
        update(
            annotation,
            responsiveAnnotationJson(
                annotationsByThreshold: """
                    {
                        "0.7": \(infoAnnotationJson(headerText: "far updated")),
                        "1.0": \(infoAnnotationJson(headerText: "close updated"))
                    }
                    """
            )
        )

        // The remapped slot must end up with the delegate carrying the NEW threshold. Keeping the
        // stale delegate would emit taps under 0.3, which the framework no longer has a key for,
        // and the tap would be dropped.
        XCTAssertEqual(try delegate(annotation, 0.3).responsiveAnnotationThreshold, 0.7)
    }

    // MARK: - helpers

    private func parse(_ json: String) -> BarcodeArAnnotation? {
        parser.get(json: JSONValue(string: json), barcode: barcode, emitter: NoopEmitter())
    }

    private func update(_ annotation: BarcodeArAnnotation, _ json: String) {
        parser.updateAnnotation(annotation, json: JSONValue(string: json))
    }

    private func slot(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> BarcodeArInfoAnnotation {
        try XCTUnwrap(annotation.annotationsByThreshold[threshold] ?? nil)
    }

    private func delegate(
        _ annotation: BarcodeArResponsiveAnnotation,
        _ threshold: CGFloat
    ) throws -> FrameworksInfoAnnotationDelegate {
        try XCTUnwrap(slot(annotation, threshold).delegate as? FrameworksInfoAnnotationDelegate)
    }

    private func responsiveAnnotationJson(annotationsByThreshold: String) -> String {
        """
        {
            "type": "barcodeArResponsiveAnnotation",
            "annotationTrigger": "highlightTap",
            "annotationsByThreshold": \(annotationsByThreshold)
        }
        """
    }

    private func infoAnnotationJson(headerText: String) -> String {
        """
        {
            "anchor": "bottom",
            "width": "medium",
            "annotationTrigger": "highlightTapAndBarcodeScan",
            "hasListener": true,
            "body": [],
            "header": {
                "text": "\(headerText)",
                "fontFamily": "modernMono",
                "textSize": 14.0
            }
        }
        """
    }
}

private class NoopEmitter: Emitter {
    func emit(name: String, payload: [String: Any?]) {}
    func hasListener(for event: String) -> Bool { false }
    func hasViewSpecificListenersForEvent(_ viewId: Int, for event: String) -> Bool { false }
    func hasModeSpecificListenersForEvent(_ modeId: Int, for event: String) -> Bool { false }
}
