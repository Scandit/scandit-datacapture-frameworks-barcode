/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import XCTest

@testable import ScanditFrameworksBarcode

/// Layer-2 defaults-drift test for the Barcode module (SDC-33331, DESIGN.md section 4)
/// - the iOS mirror of `BarcodeDefaultsDriftTest.kt`
/// (`frameworks/shared/android/scandit-datacapture-frameworks-barcode/src/androidTest/.../defaults/BarcodeDefaultsDriftTest.kt`).
/// Mirrors the native aggregation: every barcode sub-mode's flat dump lives under its own
/// top-level key ("Barcode", "BarcodeCapture", "BarcodeAr", ...) inside the overall payload,
/// hence one combined dump here, flattened under the single "Barcode" module prefix the SoT
/// uses for all of them (`runtime_paths.py`: module `barcode` -> prefix `Barcode`).
///
/// The comparator (`DefaultsDriftComparator.swift`) and fixture
/// (`Fixtures/expected_defaults_ios.json`) are committed symlinks to Core's real files - see
/// `CoreDefaultsDriftTests.swift` for the rationale (comparator lives in Core's test target,
/// which is not an exported product, so it cannot be depended on; symlinking avoids a
/// second copy that could silently diverge, per SDC-32173).
final class BarcodeDefaultsDriftTests: XCTestCase {

    private static func expectedDefaultsURL() throws -> URL {
        try XCTUnwrap(
            Bundle.module.url(forResource: "expected_defaults_ios", withExtension: "json"),
            "could not locate expected_defaults_ios.json in the test bundle - "
                + "run scripts/defaults_generator/generate.py, then check "
                + "Tests/Fixtures/expected_defaults_ios.json is still a valid symlink"
        )
    }

    func testBarcodeDefaultsMatchTheSotGeneratedExpectedSnapshot() throws {
        let url = try Self.expectedDefaultsURL()
        let data = try XCTUnwrap(
            try? Data(contentsOf: url),
            "could not read expected-defaults fixture at \(url.path) - "
                + "run scripts/defaults_generator/generate.py"
        )
        let enrolledModules = try DefaultsDriftComparator.loadEnrolledModules(data: data)
        XCTAssertTrue(
            enrolledModules.contains("barcode"),
            "'barcode' is missing from the snapshot's enrolledModules \(enrolledModules) - "
                + "see scripts/defaults_generator/enrollment.py. This test asserts Barcode "
                + "defaults; if Barcode is no longer enrolled, this test must be updated too."
        )

        // SDC-33331: runtime subtrees the SoT knowingly does not model (declared in the
        // SoT via a group-level runtimeOnlyPrefix, stamped into the snapshot by the
        // generator). Read from the snapshot, never hardcoded here - that is exactly what
        // distinguishes this from the outOfScope set SDC-32173 review F1 removed.
        let runtimeOnlyPrefixes = try DefaultsDriftComparator.loadRuntimeOnlyPrefixes(data: data)

        let expected = try DefaultsDriftComparator.loadExpected(data: data)

        let dump: [String: Any?] = [
            "Barcode": BarcodeDefaults.shared.toEncodable(),
            "BarcodeCapture": BarcodeCaptureWideDefaults.shared.toEncodable(),
            "BarcodeAr": BarcodeArWideDefaults.shared.toEncodable(),
            "BarcodeCount": BarcodeCountWideDefaults.shared.toEncodable(),
            "BarcodeFind": BarcodeFindWideDefaults.shared.toEncodable(),
            "BarcodePick": BarcodePickWideDefaults.shared.toEncodable(),
            "BarcodeSelection": BarcodeSelectionWideDefaults.shared.toEncodable(),
            "SparkScan": SparkScanWideDefaults.shared.toEncodable(),
            "BarcodeBatch": BarcodeBatchWideDefaults.shared.toEncodable(),
        ]
        // Barcode has no single full-`getDefaults()` producer, so the dump above is
        // hand-assembled from the per-sub-mode producers. That makes the sub-module key set a
        // hardcoded list, and a tenth sub-module would silently never reach the comparator -
        // not even as EXTRA. Pin it to the real emitter: `BarcodeModule.getDynamicDefaults()`
        // carries the authoritative set of top-level keys the plugins receive.
        XCTAssertEqual(
            Set(BarcodeModule().getDynamicDefaults().keys),
            Set(dump.keys),
            "The sub-module keys asserted by this test have drifted from "
                + "BarcodeModule.getDynamicDefaults(). Add the missing key(s) to the dump below "
                + "(with the sub-mode's full `toEncodable()` producer, not the dynamic one) so "
                + "they are compared against the SoT."
        )

        let actual = DefaultsDriftComparator.flatten(
            dump: dump,
            modulePrefix: "Barcode",
            expectedPaths: Set(expected.keys)
        )

        let failures = DefaultsDriftComparator.compare(
            actual: actual,
            expected: expected,
            scopePrefixes: ["Barcode"],
            runtimeOnlyPrefixes: runtimeOnlyPrefixes
        )

        XCTAssertTrue(
            failures.isEmpty,
            "Barcode defaults drifted from the SoT:\n" + failures.joined(separator: "\n")
        )
    }
}
