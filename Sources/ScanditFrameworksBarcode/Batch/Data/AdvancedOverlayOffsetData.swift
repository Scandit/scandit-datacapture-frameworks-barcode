/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditCaptureCore
import ScanditFrameworksCore

struct AdvancedOverlayOffsetData {
    let offset: PointWithUnit
    let trackedBarcodeId: Int
    let sessionFrameSequenceId: Int?

    init(offset: PointWithUnit, trackedBarcodeId: Int, sessionFrameSequenceId: Int?) {
        self.offset = offset
        self.trackedBarcodeId = trackedBarcodeId
        self.sessionFrameSequenceId = sessionFrameSequenceId
    }

    init(dictionary: [String: Any?]) {
        var offset: PointWithUnit = .zero
        if let offsetString = dictionary["offsetJson"] as? String {
            SDCPointWithUnitFromJSONString(offsetString, &offset)
        }
        self.init(
            offset: offset,
            trackedBarcodeId: dictionary["trackedBarcodeIdentifier"] as? Int ?? 0,
            sessionFrameSequenceId: dictionary["sessionFrameSequenceID"] as? Int
        )
    }
}
