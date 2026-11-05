/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public enum FrameworksBarcodeCaptureAdaptiveRecognitionEvent: String, CaseIterable {
    case dispatchStarted = "BarcodeCaptureAdaptiveRecognitionListener.dispatchStarted"
    case response = "BarcodeCaptureAdaptiveRecognitionListener.response"
    case error = "BarcodeCaptureAdaptiveRecognitionListener.error"
}

fileprivate extension Event {
    init(_ event: FrameworksBarcodeCaptureAdaptiveRecognitionEvent) {
        self.init(name: event.rawValue)
    }
}

open class FrameworksBarcodeCaptureAdaptiveRecognitionServiceListener: NSObject, AdaptiveRecognitionServiceListener {
    private let emitter: Emitter
    private let modeId: Int

    public init(emitter: Emitter, modeId: Int) {
        self.emitter = emitter
        self.modeId = modeId
    }

    public func didStartAdaptiveRecognitionServiceDispatch(
        frameData: FrameData,
        metadata: AdaptiveRecognitionFrameMetadata
    ) {
        guard
            emitter.hasModeSpecificListenersForEvent(
                modeId,
                for: FrameworksBarcodeCaptureAdaptiveRecognitionEvent.dispatchStarted.rawValue
            )
        else { return }
        // No ack, so not removed here: the cache is best-effort (LRU-evicted), matching the
        // documented "frameData getter may resolve null" contract.
        let frameDataId = LastFrameData.shared.addToCache(frameData: frameData)
        let payload = SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerDispatchStarted(
            modeId: modeId,
            frameMetadata: metadata.toSchemaType(),
            frameDataId: frameDataId,
            event: FrameworksBarcodeCaptureAdaptiveRecognitionEvent.dispatchStarted.rawValue
        ).toDictionary()
        Event(FrameworksBarcodeCaptureAdaptiveRecognitionEvent.dispatchStarted).emit(on: emitter, payload: payload)
    }

    public func didReceiveAdaptiveRecognitionServiceResponse(
        _ jsonString: String,
        metadata: AdaptiveRecognitionFrameMetadata
    ) {
        guard
            emitter.hasModeSpecificListenersForEvent(
                modeId,
                for: FrameworksBarcodeCaptureAdaptiveRecognitionEvent.response.rawValue
            )
        else { return }
        let payload = SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerResponse(
            modeId: modeId,
            frameMetadata: metadata.toSchemaType(),
            response: jsonString,
            event: FrameworksBarcodeCaptureAdaptiveRecognitionEvent.response.rawValue
        ).toDictionary()
        Event(FrameworksBarcodeCaptureAdaptiveRecognitionEvent.response).emit(on: emitter, payload: payload)
    }

    public func didFailAdaptiveRecognitionService(
        error reason: AdaptiveRecognitionErrorReason,
        metadata: AdaptiveRecognitionFrameMetadata
    ) {
        guard
            emitter.hasModeSpecificListenersForEvent(
                modeId,
                for: FrameworksBarcodeCaptureAdaptiveRecognitionEvent.error.rawValue
            )
        else { return }
        let payload = SchemaTypes.BarcodeCaptureAdaptiveRecognitionListenerError(
            modeId: modeId,
            frameMetadata: metadata.toSchemaType(),
            reason: reason.toJSONValue(),
            event: FrameworksBarcodeCaptureAdaptiveRecognitionEvent.error.rawValue
        ).toDictionary()
        Event(FrameworksBarcodeCaptureAdaptiveRecognitionEvent.error).emit(on: emitter, payload: payload)
    }
}
