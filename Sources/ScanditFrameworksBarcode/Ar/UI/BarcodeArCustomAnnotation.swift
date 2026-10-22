/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditBarcodeCaptureDeserializer
import ScanditFrameworksCore

public enum BarcodeArCustomAnnotationEvents: String, CaseIterable {
    case createCustomAnnotation = "BarcodeArCustomAnnotation.create"
    case updateCustomAnnotation = "BarcodeArCustomAnnotation.update"
    case hideCustomAnnotation = "BarcodeArCustomAnnotation.hide"
    case showCustomAnnotation = "BarcodeArCustomAnnotation.show"
    case disposeCustomAnnotation = "BarcodeArCustomAnnotation.dispose"
}

class BarcodeArCustomAnnotation: UIView, BarcodeArAnnotation {
    var annotationTrigger: BarcodeArAnnotationTrigger
    private var barcode: Barcode
    private var emitter: Emitter
    private var viewId: Int
    private let responsiveAnnotationThreshold: Double?

    private var hasEmittedOnce = false
    private var isShown = false

    init(
        barcode: Barcode,
        emitter: Emitter,
        json: JSONValue,
        viewId: Int,
        responsiveAnnotationThreshold: Double? = nil
    ) {
        self.barcode = barcode
        self.emitter = emitter
        self.viewId = viewId
        self.responsiveAnnotationThreshold = responsiveAnnotationThreshold

        var trigger = BarcodeArAnnotationTrigger.highlightTap
        SDCBarcodeArAnnotationTriggerFromJSONString(json.string(forKey: "annotationTrigger"), &trigger)
        self.annotationTrigger = trigger

        super.init(frame: .zero)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if responsiveAnnotationThreshold != nil { return }
        if superview != nil {
            create()
        } else {
            dispose()
        }
    }

    // A responsive slot stays a subview of its parent when that leaves the screen, so the window is
    // the nested lifecycle signal.
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard responsiveAnnotationThreshold != nil else { return }
        if window != nil {
            create()
            syncShown()
        } else {
            isShown = false
            dispose()
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Sometimes Annotations are hidden before being removed.
    override var isHidden: Bool {
        didSet {
            if isHidden {
                hide()
            } else {
                show()
            }
        }
    }

    // The responsive parent fades its slots with alpha and never touches isHidden.
    override var alpha: CGFloat {
        didSet { syncShown() }
    }

    private func syncShown() {
        guard responsiveAnnotationThreshold != nil, window != nil else { return }
        let nowShown = alpha > 0
        guard nowShown != isShown else { return }
        isShown = nowShown
        if nowShown { show() } else { hide() }
    }

    private func withThreshold(_ payload: [String: Any]) -> [String: Any] {
        guard let threshold = responsiveAnnotationThreshold else { return payload }
        var payload = payload
        payload["responsiveAnnotationThreshold"] = threshold
        return payload
    }

    func hide() {
        self.emitter.emit(
            name: BarcodeArCustomAnnotationEvents.hideCustomAnnotation.rawValue,
            payload: withThreshold([
                "barcodeId": self.barcode.uniqueId,
                "viewId": self.viewId,
            ])
        )
    }

    func show() {
        self.emitter.emit(
            name: BarcodeArCustomAnnotationEvents.showCustomAnnotation.rawValue,
            payload: withThreshold([
                "barcodeId": self.barcode.uniqueId,
                "viewId": self.viewId,
            ])
        )

    }

    func create() {
        self.emitter.emit(
            name: BarcodeArCustomAnnotationEvents.createCustomAnnotation.rawValue,
            payload: withThreshold([
                "barcode": self.barcode.jsonString,
                "barcodeId": self.barcode.uniqueId,
                "viewId": self.viewId,
            ])
        )
    }

    func dispose() {
        self.emitter.emit(
            name: BarcodeArCustomAnnotationEvents.disposeCustomAnnotation.rawValue,
            payload: withThreshold([
                "barcodeId": self.barcode.uniqueId,
                "viewId": self.viewId,
            ])
        )

    }

    func update(with location: Quadrilateral, highlight: (any UIView & BarcodeArHighlight)?) {
        let centerX = (location.bottomLeft.x + location.bottomRight.x + location.topLeft.x + location.topRight.x) / 4
        let centerY = (location.bottomLeft.y + location.bottomRight.y + location.topLeft.y + location.topRight.y) / 4
        // CGPoint.jsonString is internal and this is a direct copy of that implementation
        let centerJson = """
            {"x": \(centerX), "y": \(centerY)}
            """

        let payload = withThreshold([
            "centerPosition": centerJson,
            "barcodeId": self.barcode.uniqueId,
            "viewId": self.viewId,
        ])

        // We emit once immediately to avoid initial lag. Wrap in the same
        // batched shape `{ updates: [...], viewId }` so JS-side consumers
        // (RN controller) that assume a `.updates` array work on first emit.
        if !hasEmittedOnce {
            emitter.emit(
                name: BarcodeArCustomAnnotationEvents.updateCustomAnnotation.rawValue,
                payload: [
                    "updates": [payload],
                    "viewId": self.viewId,
                ]
            )
            hasEmittedOnce = true
            return
        }

        Self.batcher.submit(emitter: emitter, viewId: viewId, payload: payload)
    }

    private static let batcher = BarcodeArEmitBatcher(
        updateEventName: BarcodeArCustomAnnotationEvents.updateCustomAnnotation.rawValue
    )
}
