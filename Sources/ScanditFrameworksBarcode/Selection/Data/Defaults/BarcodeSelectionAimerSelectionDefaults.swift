/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct BarcodeSelectionAimerSelectionDefaults: DefaultsEncodable {
    let aimerSelection: BarcodeSelectionAimerSelection

    func toEncodable() -> [String: Any?] {
        [
            "defaultSelectionStrategy": aimerSelection.selectionStrategy.jsonString,
            "defaultAimerBehavior": aimerSelection.aimerBehavior.jsonString,
        ]
    }
}

private extension BarcodeSelectionAimerBehavior {
    var jsonString: String {
        switch self {
        case .toggleSelection: return "toggleSelection"
        case .repeatSelection: return "repeatSelection"
        @unknown default: return "repeatSelection"
        }
    }
}
