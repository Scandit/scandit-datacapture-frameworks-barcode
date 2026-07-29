/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

struct AdvancedOverlayAnchorData {
    let anchor: Anchor
    let trackedBarcodeId: Int
    let sessionFrameSequenceId: Int?

    init(anchor: Anchor, trackedBarcodeId: Int, sessionFrameSequenceId: Int?) {
        self.anchor = anchor
        self.trackedBarcodeId = trackedBarcodeId
        self.sessionFrameSequenceId = sessionFrameSequenceId
    }

    init(dictionary: [String: Any?]) {
        var anchor: Anchor = .center
        if let anchorString = dictionary["anchor"] as? String {
            SDCAnchorFromJSONString(anchorString, &anchor)
        }
        self.init(
            anchor: anchor,
            trackedBarcodeId: dictionary["trackedBarcodeIdentifier"] as? Int ?? 0,
            sessionFrameSequenceId: dictionary["sessionFrameSequenceID"] as? Int
        )
    }
}
