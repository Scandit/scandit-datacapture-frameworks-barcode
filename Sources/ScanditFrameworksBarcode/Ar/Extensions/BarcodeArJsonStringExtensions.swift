/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditBarcodeCaptureDeserializer

extension BarcodeArAnnotationTrigger {
    var jsonString: String { NSStringFromBarcodeArAnnotationTrigger(self) }
}

extension BarcodeArCircleHighlightPreset {
    var jsonString: String { NSStringFromBarcodeArCircleHighlightPreset(self) }
}

extension BarcodeArInfoAnnotationWidthPreset {
    var jsonString: String { NSStringFromBarcodeArInfoAnnotationWidthPreset(self) }
}

extension BarcodeArInfoAnnotationAnchor {
    var jsonString: String { NSStringFromBarcodeArInfoAnnotationAnchor(self) }
}

extension BarcodeArPopoverAnnotationAnchor {
    var jsonString: String {
        switch self {
        case .top: return "top"
        case .bottom: return "bottom"
        case .left: return "left"
        case .right: return "right"
        @unknown default: return "bottom"
        }
    }
}
