/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

#if SWIFT_PACKAGE
private import _ScanditFrameworksBarcodePrivate
#endif

struct BarcodeCountMappingFlowSettingsDefaults: DefaultsEncodable {
    func toEncodable() -> [String: Any?] {
        [
            "scanBarcodesGuidanceText": BarcodeCountViewDefaults.defaultMappingScanBarcodesGuidanceText,
            "nextButtonText": BarcodeCountViewDefaults.defaultMappingNextButtonText,
            "stepBackGuidanceText": BarcodeCountViewDefaults.defaultMappingStepBackGuidanceText,
            "redoScanButtonText": BarcodeCountViewDefaults.defaultMappingRedoScanButtonText,
            "restartButtonText": "restart",  // option not avaialbe in ios
            "finishButtonText": BarcodeCountViewDefaults.defaultMappingFinishButtonText,
        ]
    }
}
