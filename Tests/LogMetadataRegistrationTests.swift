/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditFrameworksCore
import XCTest

@testable import ScanditFrameworksBarcode

final class LogMetadataRegistrationTests: XCTestCase {
    func testRegisteringTheGeneratedMetadataLogsPerFrameCallbacksAtTraceUnderTheirLabel() {
        _ = LogMetadata.registered

        let metadata = ScanditLogger.shared.getMethodMetadata("finishBarcodeCaptureDidScan")
        XCTAssertEqual(metadata?.level, .trace)
        XCTAssertEqual(metadata?.category, .events)
    }

    func testAMethodWithoutALogCategoryInTheSchemaHasNoRegistryEntry() {
        _ = LogMetadata.registered

        XCTAssertNil(ScanditLogger.shared.getMethodMetadata("updateBarcodeCaptureMode"))
    }
}
