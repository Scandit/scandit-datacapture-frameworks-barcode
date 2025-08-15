/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import UIKit
import ScanditFrameworksCore

class FrameworksInfoAnnotationDelegate: NSObject, BarcodeArInfoAnnotationDelegate {

    private let emitter: Emitter

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    private let didTapInfoAnnotationHeader = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationHeader.rawValue
    )

    func barcodeArInfoAnnotationDidTapHeader(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotationHeader.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }

    private let didTapInfoAnnotationFooter = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationFooter.rawValue
    )

    func barcodeArInfoAnnotationDidTapFooter(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotationFooter.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }

    private let didTapInfoAnnotationLeftIcon = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationLeftIcon.rawValue
    )

    func barcodeArInfoAnnotation(
        _ annotation: BarcodeArInfoAnnotation,
        didTapLeftIconFor element: BarcodeArInfoAnnotationBodyComponent,
        at componentIndex: Int
    ) {
        didTapInfoAnnotationLeftIcon.emit(
            on: self.emitter,
            payload: [
                "barcodeId": annotation.barcode.uniqueId,
                "componentIndex": componentIndex
            ]
        )
    }

    private let didTapInfoAnnotationRightIcon = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationRightIcon.rawValue
    )

    func barcodeArInfoAnnotation(
        _ annotation: BarcodeArInfoAnnotation,
        didTapRightIconFor element: BarcodeArInfoAnnotationBodyComponent,
        at componentIndex: Int
    ) {
        didTapInfoAnnotationRightIcon.emit(
            on: self.emitter,
            payload: [
                "barcodeId": annotation.barcode.uniqueId,
                "componentIndex": componentIndex
            ]
        )
    }

    private let didTapInfoAnnotation = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotation.rawValue
    )

    func barcodeArInfoAnnotationDidTap(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotation.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }
}
