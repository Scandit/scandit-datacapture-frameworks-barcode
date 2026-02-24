/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

open class FrameworksBarcodePickViewHighlightStyleCustomViewProvider: NSObject, BarcodePickViewHighlightStyleCustomViewDelegate {
    
    private let emitter: Emitter
    private let cache: ConcurrentDictionary<Int, (BarcodePickHighlightCustomViewResponse?) -> Void> = ConcurrentDictionary()

    public init(emitter: Emitter) {
        self.emitter = emitter
    }
    
    public func customView(
        for request: BarcodePickHighlightStyleRequest,
        completionHandler: @escaping (BarcodePickHighlightCustomViewResponse?) -> Void
    ) {
        let requestId = request.hashValue
        emitter.emit(name: "BarcodePickViewHighlightStyleCustomViewProvider.viewForRequest", payload: [
            "requestId": requestId,
            "request": request.jsonString
        ])
        
        cache.setValue(completionHandler, for: requestId)
     
    }
    
    public func finishViewForRequest(requestId: Int, view: UIView?, statusIconStyle: BarcodePickStatusIconStyle?) {
        guard let completionHandler = cache.getValue(for: requestId) else {
            return
        }
        
        guard let view = view else {
            completionHandler(nil)
            return
        }
        
        completionHandler(BarcodePickHighlightCustomViewResponse(view: view, statusIconStyle: statusIconStyle))
    }
        
}
