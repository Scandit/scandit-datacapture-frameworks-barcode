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

    // Mutable: this delegate instance is cached and reused across parser updates for a given
    // threshold slot (see BarcodeArAnnotationParser.responsiveDelegate), so both fields are
    // refreshed in place rather than requiring a new delegate per update.
    var responsiveAnnotationType: ResponsiveAnnotationType?
    var responsiveAnnotationThreshold: Double?

    public init(
        emitter: Emitter,
        viewId: Int,
        responsiveAnnotationType: ResponsiveAnnotationType?,
        responsiveAnnotationThreshold: Double? = nil
    ) {
        self.emitter = emitter
        self.viewId = viewId
        self.responsiveAnnotationType = responsiveAnnotationType
        self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
    }

    private let didTapInfoAnnotationHeader = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationHeader.rawValue
    )

    func barcodeArInfoAnnotationDidTapHeader(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotationHeader.emit(
            on: self.emitter,
            payload: SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationHeader(
                barcodeId: annotation.barcode.uniqueId,
                viewId: self.viewId,
                responsiveAnnotationType: responsiveAnnotationType?.rawValue,
                responsiveAnnotationThreshold: responsiveAnnotationThreshold
            ).toDictionary()
        )
    }

    private let didTapInfoAnnotationFooter = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotationFooter.rawValue
    )

    func barcodeArInfoAnnotationDidTapFooter(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotationFooter.emit(
            on: self.emitter,
            payload: SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationFooter(
                barcodeId: annotation.barcode.uniqueId,
                viewId: self.viewId,
                responsiveAnnotationType: responsiveAnnotationType?.rawValue,
                responsiveAnnotationThreshold: responsiveAnnotationThreshold
            ).toDictionary()
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
            payload: SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationLeftIcon(
                barcodeId: annotation.barcode.uniqueId,
                componentIndex: componentIndex,
                viewId: self.viewId,
                responsiveAnnotationType: responsiveAnnotationType?.rawValue,
                responsiveAnnotationThreshold: responsiveAnnotationThreshold
            ).toDictionary()
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
            payload: SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotationRightIcon(
                barcodeId: annotation.barcode.uniqueId,
                componentIndex: componentIndex,
                viewId: self.viewId,
                responsiveAnnotationType: responsiveAnnotationType?.rawValue,
                responsiveAnnotationThreshold: responsiveAnnotationThreshold
            ).toDictionary()
        )
    }

    private let didTapInfoAnnotation = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapInfoAnnotation.rawValue
    )

    func barcodeArInfoAnnotationDidTap(_ annotation: BarcodeArInfoAnnotation) {
        didTapInfoAnnotation.emit(
            on: self.emitter,
            payload: SchemaTypes.BarcodeArInfoAnnotationListenerDidTapInfoAnnotation(
                barcodeId: annotation.barcode.uniqueId,
                viewId: self.viewId,
                responsiveAnnotationType: responsiveAnnotationType?.rawValue,
                responsiveAnnotationThreshold: responsiveAnnotationThreshold
            ).toDictionary()
        )
    }
}
