/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

extension AdaptiveRecognitionFrameMetadata {
    func toSchemaType() -> SchemaTypes.AdaptiveRecognitionFrameMetadata {
        SchemaTypes.AdaptiveRecognitionFrameMetadata(
            frameId: frameId,
            barcodes: barcodes.map { $0.jsonString }
        )
    }
}

extension AdaptiveRecognitionErrorReason {
    // A reason the native SDK adds later raises an exhaustiveness warning here; until it is
    // mapped it reports as "unknown".
    func toJSONValue() -> String {
        switch self {
        case .unknown: return "unknown"
        case .timeout: return "timeout"
        @unknown default: return "unknown"
        }
    }
}
