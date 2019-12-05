//
//  GxPasscodeViewController.h
//
//  Created by Majid Hatami Aghdam on 11/12/19.
//  Copyright 2019 Majid Hatami Aghdam. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "GxPasscodeViewControllerConstants.h"
#import "GxPasscodeView.h"
#import "GxPasscodePresentationData.h"


NS_ASSUME_NONNULL_BEGIN

@class GxPasscodeViewController;

/**
 A delegate object in charge of validating the passcodes that the user has entered into the passcode
 view controller.
 */
@protocol GxPasscodeViewControllerDelegate <NSObject>

/** 
 Return YES if the user entered the expected PIN code. Return NO if it was incorrect.
 (For security reasons, it is safer to fetch the saved PIN code only when this method is called, and
  then discard it immediately. This is why the view controller does not directly store it.)
*/
- (BOOL)passcodeViewController:(GxPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code;

/** The user tapped the 'Cancel' button. Any dismissing of confidential content should be done in here. */
- (void)didTapCancelInPasscodeViewController:(GxPasscodeViewController *)passcodeViewController;

/** The user successfully entered the correct code, as validated by `isCorrectCode:` */
- (void)didInputCorrectPasscodeInPasscodeViewController:(GxPasscodeViewController *)passcodeViewController;

/** When available, the user tapped the 'Touch ID' button, or the view controller itself automatically initiated
    the Touch ID request on display. This method is where you should implement your
    own Touch ID validation logic. For security reasons, this controller does not implement the Touch ID logic itself. */

- (void)didPerformBiometricValidationRequestInPasscodeViewController:(GxPasscodeViewController *)passcodeViewController;


@optional
/** Called when the pin view was resized as a result of the view controller being resized.
    You can use this to resize your custom header view if necessary.
 */
- (void)passcodeViewController:(GxPasscodeViewController *)passcodeViewController didResizePasscodeViewToWidth:(CGFloat)width;

@end


/**
 A view controller that displays an interface for entering a user passcode.
 It may be presented modally over another view controller, requiring the user to enter
 the passcode correctly before they are able to proceed inside the application.
 */
@interface GxPasscodeViewController : UIViewController

/** A delegate object, in charge of verifying the PIN code entered by the user */
@property (nonatomic, weak, nullable) id<GxPasscodeViewControllerDelegate> delegate;

/** The type of passcode that is expected to be entered. */
@property (nonatomic, readonly) GxPasscodeType passcodeType;

/** Will show a 'Touch ID' or 'Face ID' (depending on `biometricType`) button if the user is allowed to log in that way. (Default is NO) */
@property (nonatomic, assign) BOOL allowBiometricValidation;

/** Will show a default 'Cancel' button if rightAccessoryButton is not set. (Default is YES) */
@property (nonatomic, assign) BOOL allowCancel;

- (void)setAllowCancel:(BOOL)allowCancel;

/** Set the type of biometrics for this device to update the title of the biometrics button properly. */
@property (nonatomic, assign) GxPasscodeBiometryType biometryType;

/** If biometrics are available, automatically ask for it upon presentation (Default is NO) */
@property (nonatomic, assign) BOOL automaticallyPromptForBiometricValidation;

/** Optionally change the color of the title text label. */
@property (nonatomic, strong, nullable) UIColor *titleLabelColor;

/** Optionally change the tint color of the UI element that indicates input progress (eg the row of circles) */
@property (nonatomic, strong, nullable) UIColor *inputProgressViewTintColor;

/** Optionally enable or disable showing the lettering label of all keypad circle buttons. **/
@property (nonatomic, assign) BOOL keypadButtonShowLettering;

/** If the style isn't translucent, changes the tint color of the keypad circle button outlines. */
@property (nonatomic, strong, nullable) UIColor *keypadButtonBackgroundTintColor;

/** The color of the text elements in each keypad button */
@property (nonatomic, strong, nullable) UIColor *keypadButtonTextColor;

/** Optionally, the text color of the keypad button text when tapped. Animates back to the base color. */
@property (nonatomic, strong, nullable) UIColor *keypadButtonHighlightedTextColor;

/** The tint button of the accessory button views at the bottom of the keypad (ie 'Cance' etc) */
@property (nonatomic, strong, nullable) UIColor *accessoryButtonTintColor;

/** Controls the transluceny of the PIN background when the style has been set to translucent. */
@property (nonatomic, readonly) UIVisualEffectView *backgroundEffectView;

/** Opaque, background view when the style is opaque */
@property (nonatomic, readonly) UIView *backgroundView;

/** The keypad and accessory views that are displayed in the center of this view */
@property (nonatomic, readonly) GxPasscodeView *passcodeView;

/** The Touch ID button, visible if biometrics is enabled and `leftAccessoryButton` is nil. */
@property (nonatomic, readonly) UIButton *biometricButton;

/** The Cancel, visible if `rightAccessoryButton` is nil. */
@property (nonatomic, readonly) UIButton *cancelButton;

/** The left accessory button. Setting this will override the 'Touch ID' button. */
@property (nonatomic, strong, nullable) UIButton *leftAccessoryButton;

/** The right accessory button. Setting this will override the 'Cancel' button. */
@property (nonatomic, strong, nullable) UIButton *rightAccessoryButton;

/** Whether all of the content views are hidden or not, but the background translucent view remains.
     Useful for obscuring the content while the app is suspended. */
@property (nonatomic, assign) BOOL contentHidden;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString * )nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(nonnull NSCoder * )coder NS_UNAVAILABLE;
/**
 Create a new instance of this view controller with the preset style and passcode type.
 @param type The type of passcode to enter (6-digit/numeric)
 @param presentationStrings Strings used for displaying text objects and messages
 */
- (instancetype)initWithType:(GxPasscodeType)type presentationString:(GxPasscodePresentationData *)presentationStrings NS_DESIGNATED_INITIALIZER;

/**
 Hide everything except the background translucency view.

 @param hidden Whether the content is hidden or not.
 @param animated The content will play a crossfade animation.
 */
- (void)setContentHidden:(BOOL)hidden animated:(BOOL)animated;


- (void) setLogoImage:(nullable UIImage *) image;

@end

NS_ASSUME_NONNULL_END

//! Project version number for GxPasscodeController.
FOUNDATION_EXPORT double GxPasscodeControllerVersionNumber;

//! Project version string for GxPasscodeController.
FOUNDATION_EXPORT const unsigned char GxPasscodeControllerVersionString[];
