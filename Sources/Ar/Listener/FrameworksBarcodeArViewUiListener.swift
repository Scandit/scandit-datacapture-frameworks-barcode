/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2024- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import UIKit
import ScanditFrameworksCore

public enum BarcodeArViewUiDelegateEvents: String, CaseIterable {
    case didTapHighlightForBarcodeEvent = "BarcodeArViewUiListener.didTapHighlightForBarcode"
}

open class FrameworksBarcodeArViewUiListener: NSObject, BarcodeArViewUIDelegate {
    private let emitter: Emitter

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    private let didTapHighlightForBarcode = Event(
        name: BarcodeArViewUiDelegateEvents.didTapHighlightForBarcodeEvent.rawValue
    )

    public func barcodeArView(
        _ barcodeArView: BarcodeArView, didTapHighlightFor barcode: Barcode, highlight: any UIView & BarcodeArHighlight
    ) {
        didTapHighlightForBarcode.emit(on: emitter, payload: [
            "barcode": barcode.jsonString,
            "barcodeId": barcode.uniqueId
        ])
    }
}
