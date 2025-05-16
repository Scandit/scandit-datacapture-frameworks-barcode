/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import Foundation
import UIKit
import ScanditFrameworksCore

class FrameworksPopoverAnnotationDelegate: NSObject, BarcodeArPopoverAnnotationDelegate {
    private let emitter: Emitter

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    private let didTapPopoverButton = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapPopoverButton.rawValue
    )

    func barcodeArPopoverAnnotation(
        _ annotation: BarcodeArPopoverAnnotation, didTap button: BarcodeArPopoverAnnotationButton, at index: Int
    ) {
        didTapPopoverButton.emit(on: self.emitter, payload: [
            "barcodeId": annotation.barcode.uniqueId,
            "buttonIndex": index
        ])
    }

    private let didTapPopover = Event(
        name: FrameworksBarcodeArAnnotationEvents.didTapPopover.rawValue
    )

    func barcodeArPopoverAnnotationDidTap(_ annotation: BarcodeArPopoverAnnotation) {
        didTapPopover.emit(on: self.emitter, payload: ["barcodeId": annotation.barcode.uniqueId])
    }
}
