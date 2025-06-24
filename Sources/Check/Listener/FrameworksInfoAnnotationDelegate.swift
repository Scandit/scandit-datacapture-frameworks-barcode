/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import UIKit
import ScanditFrameworksCore

class FrameworksInfoAnnotationDelegate: NSObject, BarcodeCheckInfoAnnotationDelegate {

    private let emitter: Emitter

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    private let didTapInfoAnnotationHeader = Event(
        name: FrameworksBarcodeCheckAnnotationEvents.didTapInfoAnnotationHeader.rawValue
    )

    func barcodeCheckInfoAnnotationDidTapHeader(_ annotation: BarcodeCheckInfoAnnotation) {
        didTapInfoAnnotationHeader.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }

    private let didTapInfoAnnotationFooter = Event(
        name: FrameworksBarcodeCheckAnnotationEvents.didTapInfoAnnotationFooter.rawValue
    )

    func barcodeCheckInfoAnnotationDidTapFooter(_ annotation: BarcodeCheckInfoAnnotation) {
        didTapInfoAnnotationFooter.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }

    private let didTapInfoAnnotationLeftIcon = Event(
        name: FrameworksBarcodeCheckAnnotationEvents.didTapInfoAnnotationLeftIcon.rawValue
    )

    func barcodeCheckInfoAnnotation(
        _ annotation: BarcodeCheckInfoAnnotation,
        didTapLeftIconFor element: BarcodeCheckInfoAnnotationBodyComponent,
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
        name: FrameworksBarcodeCheckAnnotationEvents.didTapInfoAnnotationRightIcon.rawValue
    )

    func barcodeCheckInfoAnnotation(
        _ annotation: BarcodeCheckInfoAnnotation,
        didTapRightIconFor element: BarcodeCheckInfoAnnotationBodyComponent,
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
        name: FrameworksBarcodeCheckAnnotationEvents.didTapInfoAnnotation.rawValue
    )

    func barcodeCheckInfoAnnotationDidTap(_ annotation: BarcodeCheckInfoAnnotation) {
        didTapInfoAnnotation.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }
}
