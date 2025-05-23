/*
 * This file is part of the Scandit Data Capture SDK
 *
 * Copyright (C) 2023- Scandit AG. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <ScanditCaptureCore/SDCBase.h>
#import <ScanditCaptureCore/SDCAnchor.h>

@protocol SDCBarcodePickViewHighlightStyle;

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(BarcodePickViewSettingsDefaults)
SDC_EXPORTED_SYMBOL
@interface SDCBarcodePickViewSettingsDefaults : NSObject

@property (class, nonatomic, strong, readonly) id<SDCBarcodePickViewHighlightStyle> highlightStyle;

@property (class, nonatomic, assign, readonly) BOOL showLoadingDialog;
@property (class, nonatomic, strong, readonly) NSString *loadingDialogTextForPicking;
@property (class, nonatomic, strong, readonly) NSString *loadingDialogTextForUnpicking;

@property (class, nonatomic, assign, readonly) BOOL showGuidelines;
@property (class, nonatomic, strong, readonly) NSString *initialGuidelineText;
@property (class, nonatomic, strong, readonly) NSString *moveCloserGuidelineText;
@property (class, nonatomic, strong, readonly) NSString *tapShutterToPauseGuidelineText;

@property (class, nonatomic, assign, readonly) BOOL showHints;
@property (class, nonatomic, strong, readonly) NSString *onFirstItemToPickFoundHintText;
@property (class, nonatomic, strong, readonly) NSString *onFirstItemPickCompletedHintText;
@property (class, nonatomic, strong, readonly) NSString *onFirstUnmarkedItemPickCompletedHintText;
@property (class, nonatomic, strong, readonly) NSString *onFirstItemUnpickCompletedHintText;

@property (class, nonatomic, assign, readonly) BOOL showFinishButton;
@property (class, nonatomic, assign, readonly) BOOL showPauseButton;
@property (class, nonatomic, assign, readonly) BOOL showZoomButton;
@property (class, nonatomic, assign, readonly) SDCAnchor zoomButtonPosition;
@property (class, nonatomic, assign, readonly) BOOL showTorchButton;
@property (class, nonatomic, assign, readonly) SDCAnchor torchButtonPosition;

@property (class, nonatomic, assign, nullable, readonly) id<SDCBarcodeFilterHighlightSettings>
    filterHighlightSettings;

@end

NS_ASSUME_NONNULL_END
