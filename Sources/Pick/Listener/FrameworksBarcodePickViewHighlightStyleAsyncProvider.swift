/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class FrameworksBarcodePickViewHighlightStyleAsyncProvider: NSObject, BarcodePickViewHighlightStyleDelegate {
    private let emitter: Emitter
    private let cache: ConcurrentDictionary<Int, (BarcodePickViewHighlightStyleResponse?) -> Void> = ConcurrentDictionary()

    public init(emitter: Emitter) {
        self.emitter = emitter
    }

    public func style(for request: BarcodePickHighlightStyleRequest, completionHandler: @escaping (BarcodePickViewHighlightStyleResponse?) -> Void) {
        let requestId = request.hashValue
        emitter.emit(name: "BarcodePickViewHighlightStyleAsyncProvider.styleForRequest", payload: [
            "requestId": requestId,
            "request": request.jsonString
        ])
        cache.setValue(completionHandler, for: requestId)
    }

    public func finishStyleForRequest(requestId: Int, responseJson: String?) {
        guard let completionHandler = cache.getValue(for: requestId) else {
            return
        }

        guard let responseJson = responseJson else {
            completionHandler(nil)
            return
        }

        completionHandler(BarcodePickViewHighlightStyleResponse(jsonString: responseJson))
    }

}
