/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore
import UIKit
import XCTest

@testable import ScanditFrameworksBarcode

final class BarcodeArCustomAnnotationTests: XCTestCase {
    private let barcode = Barcode(barcodeInfo: BarcodeInfo(symbology: .code128, data: "1234"))
    private var emitter: BarcodeArRecordingEmitter!
    private var window: UIWindow!

    override func setUp() {
        super.setUp()
        emitter = BarcodeArRecordingEmitter()
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    private var names: [String] { emitter.emissions.map(\.name) }

    private func annotation(threshold: Double?) -> BarcodeArCustomAnnotation {
        BarcodeArCustomAnnotation(
            barcode: barcode,
            emitter: emitter,
            json: JSONValue(string: #"{"annotationTrigger": "highlightTap"}"#),
            viewId: 1,
            responsiveAnnotationThreshold: threshold
        )
    }

    func testNestedWindowAdd_emitsCreateWithExactThreshold() {
        let sut = annotation(threshold: 0.3)
        sut.alpha = 0

        window.addSubview(sut)

        XCTAssertEqual(names, [BarcodeArCustomAnnotationEvents.createCustomAnnotation.rawValue])
        XCTAssertEqual(emitter.emissions[0].payload["responsiveAnnotationThreshold"] as? Double, 0.3)
    }

    func testNestedAlphaChanges_emitOneShowAndOneHide() {
        let sut = annotation(threshold: 0.3)
        sut.alpha = 0
        window.addSubview(sut)

        sut.alpha = 1
        sut.alpha = 0.5
        sut.alpha = 0
        sut.alpha = 0

        XCTAssertEqual(
            names,
            [
                BarcodeArCustomAnnotationEvents.createCustomAnnotation.rawValue,
                BarcodeArCustomAnnotationEvents.showCustomAnnotation.rawValue,
                BarcodeArCustomAnnotationEvents.hideCustomAnnotation.rawValue,
            ]
        )
        XCTAssertEqual(emitter.emissions.last?.payload["responsiveAnnotationThreshold"] as? Double, 0.3)
    }

    func testNestedWindowRemoval_emitsDispose() {
        let sut = annotation(threshold: 0.3)
        sut.alpha = 0
        window.addSubview(sut)

        sut.removeFromSuperview()

        XCTAssertEqual(
            names,
            [
                BarcodeArCustomAnnotationEvents.createCustomAnnotation.rawValue,
                BarcodeArCustomAnnotationEvents.disposeCustomAnnotation.rawValue,
            ]
        )
    }

    func testNestedSurvivesParentLeavingScreen_disposesOnWindowRemoval() {
        let parent = UIView()
        let sut = annotation(threshold: 0.3)
        parent.addSubview(sut)
        window.addSubview(parent)

        parent.removeFromSuperview()

        XCTAssertEqual(names.last, BarcodeArCustomAnnotationEvents.disposeCustomAnnotation.rawValue)
    }

    func testTopLevel_alphaChangesEmitNothingAndPayloadHasNoThreshold() {
        let sut = annotation(threshold: nil)

        window.addSubview(sut)
        sut.alpha = 0
        sut.alpha = 1

        XCTAssertEqual(names, [BarcodeArCustomAnnotationEvents.createCustomAnnotation.rawValue])
        XCTAssertFalse(emitter.emissions[0].payload.keys.contains("responsiveAnnotationThreshold"))
    }
}
