/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import Foundation
import ScanditFrameworksCore

/// A handle to one scheduled deletion, cancellable before it fires.
internal protocol ScheduledDeletion {
    func cancel()
}

extension Timer: ScheduledDeletion {
    func cancel() {
        invalidate()
    }
}

/// Seam over "run on main, later" so tests can fire deletions deterministically.
internal protocol BarcodeArDeletionScheduler {
    func onMain(_ block: @escaping () -> Void)
    func schedule(after delay: TimeInterval, _ block: @escaping () -> Void) -> ScheduledDeletion
}

internal class MainRunLoopDeletionScheduler: BarcodeArDeletionScheduler {
    func onMain(_ block: @escaping () -> Void) {
        dispatchMain(block)
    }

    func schedule(after delay: TimeInterval, _ block: @escaping () -> Void) -> ScheduledDeletion {
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in block() }
    }
}
