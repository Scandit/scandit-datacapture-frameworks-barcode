/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

import ScanditBarcodeCapture
import ScanditFrameworksCore

private protocol DeprecatedBarcodeCountToolbarDefaultsAccessor {
    var colorSchemeOnButtonText: String { get }
    var colorSchemeOffButtonText: String { get }
    var colorSchemeButtonAccessibilityHint: String { get }
    var colorSchemeButtonAccessibilityLabel: String { get }
}

extension BarcodeCountToolbarSettingsDefaults: DeprecatedBarcodeCountToolbarDefaultsAccessor {
    // Suppress deprecation warnings — the colorScheme* defaults are still serialized for backward compatibility
    @available(*, deprecated)
    fileprivate var colorSchemeOnButtonText: String {
        BarcodeCountToolbarDefaults.colorSchemeOnButtonText
    }

    @available(*, deprecated)
    fileprivate var colorSchemeOffButtonText: String {
        BarcodeCountToolbarDefaults.colorSchemeOffButtonText
    }

    @available(*, deprecated)
    fileprivate var colorSchemeButtonAccessibilityHint: String {
        BarcodeCountToolbarDefaults.colorSchemeButtonAccessibilityHint
    }

    @available(*, deprecated)
    fileprivate var colorSchemeButtonAccessibilityLabel: String {
        BarcodeCountToolbarDefaults.colorSchemeButtonAccessibilityLabel
    }
}

struct BarcodeCountToolbarSettingsDefaults: DefaultsEncodable {
    func toEncodable() -> [String: Any?] {
        [
            "audioOnButtonText": BarcodeCountToolbarDefaults.audioOnButtonText,
            "audioOffButtonText": BarcodeCountToolbarDefaults.audioOffButtonText,
            "audioButtonAccessibilityHint": BarcodeCountToolbarDefaults.audioButtonAccessibilityHint,
            "audioButtonAccessibilityLabel": BarcodeCountToolbarDefaults.audioButtonAccessibilityLabel,
            "vibrationOnButtonText": BarcodeCountToolbarDefaults.vibrationOnButtonText,
            "vibrationOffButtonText": BarcodeCountToolbarDefaults.vibrationOffButtonText,
            "vibrationButtonAccessibilityHint": BarcodeCountToolbarDefaults.vibrationButtonAccessibilityHint,
            "vibrationButtonAccessibilityLabel": BarcodeCountToolbarDefaults.vibrationButtonAccessibilityLabel,
            "strapModeOnButtonText": BarcodeCountToolbarDefaults.strapModeOnButtonText,
            "strapModeOffButtonText": BarcodeCountToolbarDefaults.strapModeOffButtonText,
            "strapModeButtonAccessibilityHint": BarcodeCountToolbarDefaults.strapModeButtonAccessibilityHint,
            "strapModeButtonAccessibilityLabel": BarcodeCountToolbarDefaults.strapModeButtonAccessibilityLabel,
            "colorSchemeOnButtonText":
                (self as DeprecatedBarcodeCountToolbarDefaultsAccessor).colorSchemeOnButtonText,
            "colorSchemeOffButtonText":
                (self as DeprecatedBarcodeCountToolbarDefaultsAccessor).colorSchemeOffButtonText,
            "colorSchemeButtonAccessibilityHint":
                (self as DeprecatedBarcodeCountToolbarDefaultsAccessor).colorSchemeButtonAccessibilityHint,
            "colorSchemeButtonAccessibilityLabel":
                (self as DeprecatedBarcodeCountToolbarDefaultsAccessor).colorSchemeButtonAccessibilityLabel,
        ]
    }
}
