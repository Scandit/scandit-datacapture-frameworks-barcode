/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2026- Scandit AG. All rights reserved.
 */

import XCTest

@testable import ScanditFrameworksBarcode

/// `BarcodeModule.getDynamicDefaults()` narrows each per-mode payload by calling each producer's
/// own `toDynamicEncodable()` directly. A key that stops being emitted is therefore not a
/// native error — it surfaces as a `null` where the Flutter `initializeDefaults` expects a map,
/// i.e. a hard plugin-load failure discovered only on device.
///
/// Referencing the producers' own `Keys` makes a rename a compile error; these tests are the other
/// half of the guard: they assert each producer actually emits the key its `Keys` enum names, so
/// the two cannot drift apart silently. The Android mirror lives in `BarcodeModuleTest.kt`.
final class DynamicDefaultsKeysTests: XCTestCase {

    func testBarcodeCaptureEmitsItsSelectedKeys() {
        assertEmits(
            BarcodeCaptureDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeCaptureDefaults.Keys.recommendedCameraSettings]
        )
    }

    func testBarcodeBatchEmitsItsSelectedKeys() {
        assertEmits(
            BarcodeBatchDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeBatchDefaults.Keys.recommendedCameraSettings]
        )
    }

    func testBarcodeSelectionEmitsItsSelectedKeys() {
        assertEmits(
            BarcodeSelectionDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeSelectionDefaults.Keys.recommendedCameraSettings]
        )
    }

    func testBarcodeCountEmitsItsSelectedKeys() {
        assertEmits(
            BarcodeCountDefaults.shared.toDynamicEncodable(),
            keys: [
                BarcodeCountDefaults.Keys.recommendedCameraSettings,
                BarcodeCountDefaults.Keys.barcodeCountView,
            ]
        )
    }

    func testBarcodeFindEmitsItsSelectedKeys() {
        assertEmits(
            BarcodeFindDefaults.shared.toDynamicEncodable(),
            keys: [
                BarcodeFindDefaults.Keys.recommendedCameraSettings,
                BarcodeFindDefaults.Keys.barcodeFindView,
            ]
        )
    }

    func testBarcodePickEmitsItsSelectedKeys() {
        assertEmits(
            BarcodePickDefaults.shared.toDynamicEncodable(),
            keys: [
                BarcodePickDefaults.Keys.recommendedCameraSettings,
                BarcodePickDefaults.Keys.viewSettings,
                BarcodePickDefaults.Keys.barcodePickViewHighlightStyle,
                BarcodePickDefaults.Keys.symbologySettings,
            ]
        )
    }

    func testSparkScanEmitsItsSelectedKeys() {
        assertEmits(
            SparkScanDefaults.shared.toDynamicEncodable(),
            keys: [SparkScanDefaults.Keys.sparkScanView]
        )
    }

    func testBarcodeArEmitsItsSelectedKeys() {
        assertEmits(
            BarcodeArDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeArDefaults.Keys.recommendedCameraSettings, BarcodeArDefaults.Keys.barcodeArView]
        )
    }

    func testBarcodeBlockEmitsTheEngineOwnedKeysFlutterReads() {
        // The Barcode block is passed through whole rather than narrowed, so it has no `Keys`
        // enum — but Flutter reads these three off it at plugin load just the same.
        assertEmits(
            BarcodeDefaults.shared.toEncodable(),
            keys: ["SymbologySettings", "SymbologyDescriptions", "CompositeTypeDescriptions"]
        )
    }

    /// SDC-32178: every residual key must be deep-equal to the same key in the wide blob, across
    /// every mode. The wide side is the eight `*WideDefaults` test types, which re-derive their
    /// values; the drift test is what pins them to the SoT.
    func testDynamicPayloadsMatchTheWideDefaultsForEveryResidualKey() {
        assertDynamicIsSubsetOfWide(
            wide: BarcodeCaptureWideDefaults.shared.toEncodable(),
            dynamic: BarcodeCaptureDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeCaptureDefaults.Keys.recommendedCameraSettings]
        )
        assertDynamicIsSubsetOfWide(
            wide: BarcodeBatchWideDefaults.shared.toEncodable(),
            dynamic: BarcodeBatchDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeBatchDefaults.Keys.recommendedCameraSettings]
        )
        assertDynamicIsSubsetOfWide(
            wide: BarcodeSelectionWideDefaults.shared.toEncodable(),
            dynamic: BarcodeSelectionDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeSelectionDefaults.Keys.recommendedCameraSettings]
        )
        assertDynamicIsSubsetOfWide(
            wide: BarcodeCountWideDefaults.shared.toEncodable(),
            dynamic: BarcodeCountDefaults.shared.toDynamicEncodable(),
            keys: [
                BarcodeCountDefaults.Keys.recommendedCameraSettings,
                BarcodeCountDefaults.Keys.barcodeCountView,
            ]
        )
        assertDynamicIsSubsetOfWide(
            wide: BarcodeFindWideDefaults.shared.toEncodable(),
            dynamic: BarcodeFindDefaults.shared.toDynamicEncodable(),
            keys: [
                BarcodeFindDefaults.Keys.recommendedCameraSettings,
                BarcodeFindDefaults.Keys.barcodeFindView,
            ]
        )
        assertDynamicIsSubsetOfWide(
            wide: BarcodePickWideDefaults.shared.toEncodable(),
            dynamic: BarcodePickDefaults.shared.toDynamicEncodable(),
            keys: [
                BarcodePickDefaults.Keys.recommendedCameraSettings,
                BarcodePickDefaults.Keys.viewSettings,
                BarcodePickDefaults.Keys.barcodePickViewHighlightStyle,
                BarcodePickDefaults.Keys.symbologySettings,
            ]
        )
        assertDynamicIsSubsetOfWide(
            wide: SparkScanWideDefaults.shared.toEncodable(),
            dynamic: SparkScanDefaults.shared.toDynamicEncodable(),
            keys: [SparkScanDefaults.Keys.sparkScanView]
        )
        assertDynamicIsSubsetOfWide(
            wide: BarcodeArWideDefaults.shared.toEncodable(),
            dynamic: BarcodeArDefaults.shared.toDynamicEncodable(),
            keys: [BarcodeArDefaults.Keys.recommendedCameraSettings, BarcodeArDefaults.Keys.barcodeArView]
        )
    }

    private func assertDynamicIsSubsetOfWide(
        wide: [String: Any?],
        dynamic: [String: Any?],
        keys: [String],
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            Set(dynamic.keys),
            Set(keys),
            "the dynamic payload carries an unexpected key set",
            file: file,
            line: line
        )
        for key in keys {
            let wideValue = wide[key] ?? nil
            let dynamicValue = dynamic[key] ?? nil
            XCTAssertTrue(
                isDeepEqual(wideValue, dynamicValue),
                """
                dynamic['\(key)'] differs from the wide defaults' value for the same key
                wide:    \(describeForFailure(wideValue))
                dynamic: \(describeForFailure(dynamicValue))
                """,
                file: file,
                line: line
            )
        }
    }

    /// Structural equality for the `Any?` trees `toEncodable()`/`toDynamicEncodable()` produce
    /// (nested `[String: Any?]` / `[Any?]` of strings, numbers, bools).
    ///
    /// Leaves are compared with `isEqual:` when they are Objective-C objects, and only then by
    /// `String(describing:)` — the boxed `NSNumber`/`NSString` values under `properties` compare
    /// correctly either way, but identity-bearing descriptions do not.
    ///
    /// Array order is significant here on purpose: it is what caught `zoomLevels` being emitted
    /// straight out of a `Set`, so the same settings serialized in a different order on each call
    /// (SDC-32178). The producer now sorts it.
    private func isDeepEqual(_ lhs: Any?, _ rhs: Any?) -> Bool {
        if isNilLike(lhs) || isNilLike(rhs) {
            return isNilLike(lhs) && isNilLike(rhs)
        }
        if let lDict = lhs as? [String: Any?], let rDict = rhs as? [String: Any?] {
            guard Set(lDict.keys) == Set(rDict.keys) else { return false }
            return lDict.keys.allSatisfy { isDeepEqual(lDict[$0] ?? nil, rDict[$0] ?? nil) }
        }
        if let lArr = lhs as? [Any?], let rArr = rhs as? [Any?] {
            guard lArr.count == rArr.count else { return false }
            return zip(lArr, rArr).allSatisfy { isDeepEqual($0, $1) }
        }
        let lObject = lhs! as AnyObject
        let rObject = rhs! as AnyObject
        if lObject === rObject || lObject.isEqual(rObject) {
            return true
        }
        return String(describing: lhs!) == String(describing: rhs!)
    }

    /// Renders a value for an assertion message so a failure says which leaf differs, instead of
    /// only naming the top-level key.
    private func describeForFailure(_ value: Any?) -> String {
        guard let value, !isNilLike(value) else { return "nil" }
        if let dict = value as? [String: Any?] {
            let body = dict.keys.sorted()
                .map { "\($0): \(describeForFailure(dict[$0] ?? nil))" }
                .joined(separator: ", ")
            return "[\(body)]"
        }
        if let array = value as? [Any?] {
            return "[\(array.map { describeForFailure($0) }.joined(separator: ", "))]"
        }
        return "\(String(describing: value)) (\(type(of: value)))"
    }

    private func isNilLike(_ value: Any?) -> Bool {
        guard let value else { return true }
        if case Optional<Any>.none = value { return true }
        return false
    }

    private func assertEmits(
        _ encodable: [String: Any?],
        keys: [String],
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        for key in keys {
            XCTAssertNotNil(
                encodable[key] ?? nil,
                "the dynamic defaults select '\(key)', but the producer does not emit it - "
                    + "Flutter's initializeDefaults would read null at plugin load",
                file: file,
                line: line
            )
        }
    }
}
