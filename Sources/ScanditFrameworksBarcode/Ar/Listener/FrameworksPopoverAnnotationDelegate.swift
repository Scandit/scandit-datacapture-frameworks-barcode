/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture
import ScanditFrameworksCore
import UIKit

class FrameworksPopoverAnnotationDelegate: NSObject, BarcodeArPopoverAnnotationDelegate {
    private let emitter: Emitter
    private let viewId: Int

    // Mutable: cached per threshold slot by the parser and refreshed in place on update.
    var responsiveAnnotationType: ResponsiveAnnotationType?
    var responsiveAnnotationThreshold: Double?

    public init(
        emitter: Emitter,
        viewId: Int,
        responsiveAnnotationType: ResponsiveAnnotationType? = nil,
        responsiveAnnotationThreshold: Double? = nil
    ) {
        self.emitter = emitter
        self.viewId = viewId
        self.responsiveAnnotationType = responsiveAnnotationType
        self.responsiveAnnotationThreshold = responsiveAnnotationThreshold
    }

    private let didTapPopoverButton = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapPopoverButton.rawValue
    )

    func barcodeArPopoverAnnotation(
        _ annotation: BarcodeArPopoverAnnotation,
        didTap button: BarcodeArPopoverAnnotationButton,
        at index: Int
    ) {
        didTapPopoverButton.emit(
            on: self.emitter,
            payload: SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopoverButton(
                barcodeId: annotation.barcode.uniqueId,
                buttonIndex: index,
                viewId: self.viewId,
                responsiveAnnotationType: responsiveAnnotationType?.rawValue,
                responsiveAnnotationThreshold: responsiveAnnotationThreshold
            ).toDictionary()
        )
    }

    private let didTapPopover = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapPopover.rawValue
    )

    func barcodeArPopoverAnnotationDidTap(_ annotation: BarcodeArPopoverAnnotation) {
        didTapPopover.emit(
            on: self.emitter,
            payload: SchemaTypes.BarcodeArPopoverAnnotationListenerDidTapPopover(
                barcodeId: annotation.barcode.uniqueId,
                viewId: self.viewId,
                responsiveAnnotationType: responsiveAnnotationType?.rawValue,
                responsiveAnnotationThreshold: responsiveAnnotationThreshold
            ).toDictionary()
        )
    }
}
