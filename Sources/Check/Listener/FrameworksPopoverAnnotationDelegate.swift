/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import UIKit
import ScanditFrameworksCore

class FrameworksPopoverAnnotationDelegate: NSObject, BarcodeCheckPopoverAnnotationDelegate {
    private let emitter: Emitter

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    private let didTapPopoverButton = Event(
        name: FrameworksBarcodeCheckAnnotationEvents.didTapPopoverButton.rawValue
    )

    func barcodeCheckPopoverAnnotation(
        _ annotation: BarcodeCheckPopoverAnnotation, didTap button: BarcodeCheckPopoverAnnotationButton, at index: Int
    ) {
        didTapPopoverButton.emit(on: self.emitter, payload: [
            "barcodeId": annotation.barcode.uniqueId,
            "buttonIndex": index
        ])
    }

    private let didTapPopover = Event(
        name: FrameworksBarcodeCheckAnnotationEvents.didTapPopover.rawValue
    )

    func barcodeCheckPopoverAnnotationDidTap(_ annotation: BarcodeCheckPopoverAnnotation) {
        didTapPopover.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }
}
