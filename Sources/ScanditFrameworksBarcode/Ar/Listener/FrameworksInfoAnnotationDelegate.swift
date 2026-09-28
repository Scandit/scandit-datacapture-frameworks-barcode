/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture
import ScanditFrameworksCore
import UIKit

// Since infoannotations can be also inside of a responsive annotation we need to differentiate if they are the closeUp one or the farAway one
enum ResponsiveAnnotationType: String {
    case farAway
    case closeUp
}

class FrameworksInfoAnnotationDelegate: NSObject, BarcodeArInfoAnnotationDelegate {

    private let emitter: Emitter
    private let viewId: Int
    private let responsiveAnnotationType: ResponsiveAnnotationType?

    public init(emitter: Emitter, viewId: Int, responsiveAnnotationType: ResponsiveAnnotationType?) {
        self.emitter = emitter
        self.viewId = viewId
        self.responsiveAnnotationType = responsiveAnnotationType
    }

    private let didTapInfoAnnotationHeader = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationHeader.rawValue
    )

    private func generatePayload(barcodeId: String, mergeWith: [String: Any]? = nil) -> [String: Any] {
        var payload: [String: Any] = [
            "barcodeId": barcodeId,
            "viewId": self.viewId,
        ]

        if let responsiveAnnotationType = responsiveAnnotationType {
            payload["responsiveAnnotationType"] = responsiveAnnotationType.rawValue
        }

        if let mw = mergeWith {
            payload = payload.merging(mw) { (_, new) in new }
        }

        return payload
    }

    func barcodeArInfoAnnotationDidTapHeader(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotationHeader.emit(
            on: self.emitter,
            payload: [
                "barcodeId": annotation.barcode.uniqueId,
                "viewId": self.viewId,
            ]
        )
    }

    private let didTapInfoAnnotationFooter = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationFooter.rawValue
    )

    func barcodeArInfoAnnotationDidTapFooter(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotationFooter.emit(
            on: self.emitter,
            payload: generatePayload(barcodeId: annotation.barcode.uniqueId)
        )
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
            payload: generatePayload(
                barcodeId: annotation.barcode.uniqueId,
                mergeWith: ["componentIndex": componentIndex]
            )
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
            payload: generatePayload(
                barcodeId: annotation.barcode.uniqueId,
                mergeWith: ["componentIndex": componentIndex]
            )
        )
    }

    private let didTapInfoAnnotation = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotation.rawValue
    )

    func barcodeArInfoAnnotationDidTap(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotation.emit(
            on: self.emitter,
            payload: generatePayload(barcodeId: annotation.barcode.uniqueId)
        )
    }
}
