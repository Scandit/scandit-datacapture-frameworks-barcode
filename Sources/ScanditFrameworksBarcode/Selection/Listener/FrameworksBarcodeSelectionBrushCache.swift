/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditBarcodeCapture

final class FrameworksBarcodeSelectionBrushCache {
    private enum Entry {
        case pending
        case answered(Brush?)
    }

    private let lock = NSLock()
    private var entries: [String: Entry] = [:]

    /// `onMiss` runs once per identifier; the barcode stays transparent until `finish` answers.
    func brush(for selectionIdentifier: String, onMiss: () -> Void) -> Brush? {
        lock.lock()
        let existing = entries[selectionIdentifier]
        if existing == nil {
            entries[selectionIdentifier] = .pending
        }
        lock.unlock()

        switch existing {
        case .none:
            onMiss()
            return .transparent
        case .pending:
            return .transparent
        case .answered(let brush):
            return brush
        }
    }

    func finish(brushJson: String?, selectionIdentifier: String?) {
        guard let selectionIdentifier = selectionIdentifier, !selectionIdentifier.isEmpty else { return }
        let brush = brushJson.flatMap { Brush(jsonString: $0) }
        lock.lock()
        entries[selectionIdentifier] = .answered(brush)
        lock.unlock()
    }

    func clear() {
        lock.lock()
        entries.removeAll()
        lock.unlock()
    }
}
