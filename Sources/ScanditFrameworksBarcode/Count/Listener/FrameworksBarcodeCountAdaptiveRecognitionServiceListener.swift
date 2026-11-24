/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeCountAdaptiveRecognitionEvent: String, CaseIterable {
    case dispatchStarted = "BarcodeCountAdaptiveRecognitionListener.dispatchStarted"
    case response = "BarcodeCountAdaptiveRecognitionListener.response"
    case error = "BarcodeCountAdaptiveRecognitionListener.error"
}

fileprivate extension Event {
    init(_ event: FrameworksBarcodeCountAdaptiveRecognitionEvent) {
        self.init(name: event.rawValue)
    }
}

open class FrameworksBarcodeCountAdaptiveRecognitionServiceListener: NSObject, AdaptiveRecognitionServiceListener {
    private let emitter: Emitter
    private let viewId: Int

    public init(emitter: Emitter, viewId: Int) {
        self.emitter = emitter
        self.viewId = viewId
    }

    public func didStartAdaptiveRecognitionServiceDispatch(
        frameData: FrameData,
        metadata: AdaptiveRecognitionFrameMetadata
    ) {
        guard
            emitter.hasViewSpecificListenersForEvent(
                viewId,
                for: FrameworksBarcodeCountAdaptiveRecognitionEvent.dispatchStarted.rawValue
            )
        else { return }
        // No ack, so not removed here: the cache is best-effort (LRU-evicted), matching the
        // documented "frameData getter may resolve null" contract.
        let frameDataId = LastFrameData.shared.addToCache(frameData: frameData)
        let payload = SchemaTypes.BarcodeCountAdaptiveRecognitionListenerDispatchStarted(
            viewId: viewId,
            frameMetadata: metadata.toSchemaType(),
            frameDataId: frameDataId,
            event: FrameworksBarcodeCountAdaptiveRecognitionEvent.dispatchStarted.rawValue
        ).toDictionary()
        Event(FrameworksBarcodeCountAdaptiveRecognitionEvent.dispatchStarted).emit(on: emitter, payload: payload)
    }

    public func didReceiveAdaptiveRecognitionServiceResponse(
        _ jsonString: String,
        metadata: AdaptiveRecognitionFrameMetadata
    ) {
        guard
            emitter.hasViewSpecificListenersForEvent(
                viewId,
                for: FrameworksBarcodeCountAdaptiveRecognitionEvent.response.rawValue
            )
        else { return }
        let payload = SchemaTypes.BarcodeCountAdaptiveRecognitionListenerResponse(
            viewId: viewId,
            frameMetadata: metadata.toSchemaType(),
            response: jsonString,
            event: FrameworksBarcodeCountAdaptiveRecognitionEvent.response.rawValue
        ).toDictionary()
        Event(FrameworksBarcodeCountAdaptiveRecognitionEvent.response).emit(on: emitter, payload: payload)
    }

    public func didFailAdaptiveRecognitionService(
        error reason: AdaptiveRecognitionErrorReason,
        metadata: AdaptiveRecognitionFrameMetadata
    ) {
        guard
            emitter.hasViewSpecificListenersForEvent(
                viewId,
                for: FrameworksBarcodeCountAdaptiveRecognitionEvent.error.rawValue
            )
        else { return }
        let payload = SchemaTypes.BarcodeCountAdaptiveRecognitionListenerError(
            viewId: viewId,
            frameMetadata: metadata.toSchemaType(),
            reason: reason.toJSONValue(),
            event: FrameworksBarcodeCountAdaptiveRecognitionEvent.error.rawValue
        ).toDictionary()
        Event(FrameworksBarcodeCountAdaptiveRecognitionEvent.error).emit(on: emitter, payload: payload)
    }
}
