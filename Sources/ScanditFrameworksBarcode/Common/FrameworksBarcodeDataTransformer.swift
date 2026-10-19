/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeDataTransformerEvent: String, CaseIterable {
    case transformBarcodeData = "BarcodeDataTransformer.transformBarcodeData"
}

extension Event {
    init(_ event: FrameworksBarcodeDataTransformerEvent) {
        self.init(name: event.rawValue)
    }
}

open class FrameworksBarcodeDataTransformer: NSObject, BarcodeDataTransformer {

    private let emitter: Emitter

    private let onTransformBarcodeData = EventWithResult<String?>(
        event: Event(FrameworksBarcodeDataTransformerEvent.transformBarcodeData)
    )

    private let viewId: Int

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
        // Increase timeout to wait for result
        onTransformBarcodeData.timeout = 100
    }

    public func transformBarcodeData(_ data: String) -> String? {
        onTransformBarcodeData.emit(on: emitter, payload: ["data": data, "viewId": self.viewId]) ?? nil
    }

    public func submitResult(result: String?) {
        onTransformBarcodeData.unlock(value: result)
    }

    public func cancel() {
        onTransformBarcodeData.reset()
    }
}
