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
