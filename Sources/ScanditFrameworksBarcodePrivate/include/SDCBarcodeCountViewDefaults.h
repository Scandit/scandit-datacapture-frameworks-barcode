/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

#import <ScanditBarcodeCapture/ScanditBarcodeCapture.h>

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(BarcodeCountViewDefaults)
SDC_EXPORTED_SYMBOL
@interface SDCBarcodeCountViewDefaults : NSObject

@property (class, nonatomic, readonly) SDCBarcodeCountViewStyle defaultStyle;
@property (class, nonatomic, readonly) BOOL defaultShouldShowScanAreaGuides;
@property (class, nonatomic, readonly) BOOL defaultShouldShowUserGuidanceView;
@property (class, nonatomic, readonly) BOOL defaultShouldShowHints;
@property (class, nonatomic, readonly) BOOL defaultShouldShowListButton;
@property (class, nonatomic, readonly) BOOL defaultShouldShowExitButton;
@property (class, nonatomic, readonly) BOOL defaultShouldShowShutterButton;
@property (class, nonatomic, readonly) BOOL defaultShouldShowClearHighlightsButton;
@property (class, nonatomic, readonly) BOOL defaultShouldShowSingleScanButton;
@property (class, nonatomic, readonly) BOOL defaultShouldShowFloatingShutterButton;
@property (class, nonatomic, readonly) BOOL defaultShouldShowToolbar;
@property (class, nonatomic, readonly) BOOL defaultShouldShowStatusModeButton;
@property (class, nonatomic, readonly) BOOL defaultShouldDisableModeOnExitButtonTapped;
@property (class, nonatomic, readonly) BOOL defaultHardwareTriggerEnabled;
@property (class, nonatomic, readonly) BOOL defaultShouldShowListProgressBar;
@property (class, nonatomic, readonly) BOOL defaultShouldShowTorchControl;
@property (class, nonatomic, readonly) BOOL defaultTapToUncountEnabled;
@property (class, nonatomic, readonly) BOOL defaultShouldShowStatusIconsOnScan;
@property (class, nonatomic, readonly) SDCAnchor defaultTorchControlPosition;
@property (class, nonatomic, readonly) NSString *defaultExitButtonText;
@property (class, nonatomic, readonly) NSString *defaultClearHighlightsButtonText;
@property (class, nonatomic, readonly) NSString *defaultTextForUnrecognizedBarcodesDetectedHint;
@property (class, nonatomic, readonly) NSString *defaultTextForTapShutterToScanHint;
@property (class, nonatomic, readonly) NSString *defaultTextForScanningHint;
@property (class, nonatomic, readonly) NSString *defaultTextForMoveCloserAndRescanHint;
@property (class, nonatomic, readonly) NSString *defaultTextForMoveFurtherAndRescanHint;
@property (class, nonatomic, readonly) NSString *defaultTextForTapToUncountHint;
@property (class, nonatomic, readonly) NSString *defaultTextForClusteringGestureHint;
@property (class, nonatomic, readonly) NSString *defaultTextForUnrecognizedBarcodesInClusterHint;
@property (class, nonatomic, readonly) NSString *defaultListButtonAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultListButtonAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultExitButtonAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultExitButtonAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultShutterButtonAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultShutterButtonAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultFloatingShutterButtonAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultFloatingShutterButtonAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultClearHighlightsButtonAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultClearHighlightsButtonAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultSingleScanButtonAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultSingleScanButtonAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultStatusModeButtonAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultStatusModeButtonAccessibilityLabel;

// Mapping
@property (class, nonatomic, readonly) NSString *defaultMappingScanBarcodesGuidanceText;
@property (class, nonatomic, readonly) NSString *defaultMappingStepBackGuidanceText;
@property (class, nonatomic, readonly) NSString *defaultMappingNextButtonText;
@property (class, nonatomic, readonly) NSString *defaultMappingNextAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultMappingNextAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultMappingRedoScanButtonText;
@property (class, nonatomic, readonly) NSString *defaultMappingRedoScanAccessibilityHint;
@property (class, nonatomic, readonly) NSString *defaultMappingRedoScanAccessibilityLabel;
@property (class, nonatomic, readonly) NSString *defaultMappingFinishButtonText;
@end

NS_ASSUME_NONNULL_END
