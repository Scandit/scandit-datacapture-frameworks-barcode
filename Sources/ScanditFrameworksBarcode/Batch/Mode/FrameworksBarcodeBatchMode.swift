/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2025- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

public class FrameworksBarcodeBatchMode: FrameworksBaseMode {
    private let listener: FrameworksBarcodeBatchListener
    private let captureContext: DefaultFrameworksCaptureContext
    private let deserializer: BarcodeBatchDeserializer

    private var internalModeId: Int = -1
    private var internalParentId: Int? = nil

    public var modeId: Int {
        internalModeId
    }

    public var parentId: Int? {
        internalParentId
    }

    public private(set) var mode: BarcodeBatch!

    public var isEnabled: Bool {
        get {
            mode.isEnabled
        }
        set {
            mode.isEnabled = newValue
        }
    }

    public init(
        listener: FrameworksBarcodeBatchListener,
        captureContext: DefaultFrameworksCaptureContext,
        deserializer: BarcodeBatchDeserializer = BarcodeBatchDeserializer()
    ) {
        self.listener = listener
        self.captureContext = captureContext
        self.deserializer = deserializer
    }

    private func deserializeMode(
        dataCaptureContext: DataCaptureContext,
        creationData: BarcodeBatchModeCreationData
    ) throws {
        mode = try deserializer.mode(fromJSONString: creationData.modeJson, with: dataCaptureContext)
        captureContext.addMode(mode: mode)
        mode.addListener(listener)
        listener.setEnabled(enabled: creationData.hasListener)

        mode.isEnabled = creationData.isEnabled
        internalModeId = creationData.modeId
        internalParentId = creationData.parentId
    }

    public func dispose() {
        listener.reset()
        mode.removeListener(listener)
        captureContext.removeMode(mode: mode)
    }

    public func addListener() {
        listener.setEnabled(enabled: true)
    }

    public func removeListener() {
        listener.setEnabled(enabled: false)
    }

    public func finishDidUpdateSession(enabled: Bool) {
        listener.finishDidUpdateSession(enabled: enabled)
    }

    public func applySettings(modeSettingsJson: String) throws {
        let settings = try deserializer.settings(fromJSONString: modeSettingsJson)
        mode.apply(settings)
    }

    public func updateModeFromJson(modeJson: String) throws {
        try deserializer.updateMode(mode, fromJSONString: modeJson)
    }

    // MARK: - Factory Method

    public static func create(
        emitter: Emitter,
        captureContext: DefaultFrameworksCaptureContext,
        creationData: BarcodeBatchModeCreationData,
        dataCaptureContext: DataCaptureContext,
        cachedBatchSession: AtomicValue<FrameworksBarcodeBatchSession?>
    ) throws -> FrameworksBarcodeBatchMode {
        let listener = FrameworksBarcodeBatchListener(
            emitter: emitter,
            modeId: creationData.modeId,
            cachedBatchSession: cachedBatchSession
        )
        let mode = FrameworksBarcodeBatchMode(
            listener: listener,
            captureContext: captureContext
        )

        try mode.deserializeMode(dataCaptureContext: dataCaptureContext, creationData: creationData)
        return mode
    }
}
