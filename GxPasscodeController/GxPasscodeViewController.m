//
//  GxPasscodeViewController.m
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

#import "GxPasscodeViewController.h"
#import "GxPasscodeView.h"
#import "GxPasscodeViewControllerAnimatedTransitioning.h"
#import "GxPasscodeKeypadView.h"
#import "GxPasscodeInputField.h"



@interface GxPasscodeViewController () <UIViewControllerTransitioningDelegate>

/* State */
@property (nonatomic, assign, readwrite) GxPasscodeType passcodeType;
@property (nonatomic, assign) CGFloat keyboardHeight;
@property (nonatomic, assign) BOOL passcodeSuccess;
@property (nonatomic, readonly) UIView *leftButton;
@property (nonatomic, readonly) UIView *rightButton;

/* Views */
//@property (nonatomic, readonly) TOPasscodeView *passcodeView;
@property (nonatomic, strong, readwrite) UIVisualEffectView *backgroundEffectView;
@property (nonatomic, strong, readwrite) UIView *backgroundView;
@property (nonatomic, strong, readwrite) UIImageView *logoImageView;
@property (nonatomic, strong, readwrite) GxPasscodeView *passcodeView;
@property (nonatomic, strong, readwrite) UIButton *biometricButton;
@property (nonatomic, strong, readwrite) UIButton *cancelButton;
@property (nonatomic, readwrite) GxPasscodePresentationData *presentationData;

@end

@implementation GxPasscodeViewController

#pragma mark - Instance Creation -

- (instancetype)initWithType:(GxPasscodeType)type presentationString:(GxPasscodePresentationData *)presentationStrings
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        
        _presentationData = presentationStrings;
        _passcodeType = type;
        
        _allowCancel = YES;
        /// Fix Missing Values:
        if(_presentationData.enterPasscodeViewTitle == NULL){
            _presentationData.enterPasscodeViewTitle = NSLocalizedString(@"Enter passcode", @"Enter passcode");
        }
        if(_presentationData.cancelButtonTitle == NULL){
            _presentationData.cancelButtonTitle = NSLocalizedString(@"Cancel", @"Cancel");
        }
        if(_presentationData.deleteButtonTitle == NULL){
            _presentationData.deleteButtonTitle = NSLocalizedString(@"Delete", @"Delete");
        }
        
        if(_presentationData.faceIdButtonTitle == NULL){
            _presentationData.faceIdButtonTitle = NSLocalizedString(@"Face ID", @"Face ID");
        }
        
        if(_presentationData. dialpad_letteredTitles == NULL){
            _presentationData. dialpad_letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL", @"MNO", @"PQRS", @"TUV", @"WXYZ"];
        }
        
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        [self setUp];
    }

    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self setUp];
    }

    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - View Setup -

- (void)setUp
{
    self.transitioningDelegate = self;
    self.automaticallyPromptForBiometricValidation = NO;

    _logoImageView = [[UIImageView alloc] init];
    [_logoImageView setContentMode: UIViewContentModeScaleAspectFit];
    [_logoImageView setClipsToBounds:TRUE];
    [self.view addSubview:_logoImageView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:)
                                                     name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setAllowCancel:(BOOL)allowCancel {
    _allowCancel = allowCancel;
    self.cancelButton.hidden = !allowCancel;
}

- (void)setUpBackgroundEffectView
{
    // Create it otherwise
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleDark];
    self.backgroundEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.backgroundEffectView.frame = self.view.bounds;
    self.backgroundEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //[self.view insertSubview:self.backgroundEffectView atIndex:0];
}

- (void)setUpBackgroundView
{
    self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //[self.view insertSubview:self.backgroundView atIndex:0];
}



- (void)setUpAccessoryButtons
{
    UIFont *buttonFont = [UIFont preferredFontForTextStyle: UIFontTextStyleBody];
    BOOL isPad = UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad;

    if (!self.leftAccessoryButton && self.allowBiometricValidation && !self.biometricButton) {
        self.biometricButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        switch (self.biometryType) {
            case GxPasscodeBiometryTypeFaceID: [self.biometricButton setTitle: self.presentationData.faceIdButtonTitle forState:UIControlStateNormal];
            default: [self.biometricButton setTitle: self.presentationData.touchIdButtonTitle forState:UIControlStateNormal];
        }
        
        [self.biometricButton addTarget:self action:@selector(accessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        if (isPad) {
            self.passcodeView.leftButton = self.biometricButton;
        }
        else {
            [self.view addSubview:self.biometricButton];
        }
    }
    else {
        if (self.leftAccessoryButton) {
            [self.biometricButton removeFromSuperview];
            self.biometricButton = nil;
        }
    }

    if (!self.rightAccessoryButton && !self.cancelButton) {
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.cancelButton setTitle:self.presentationData.cancelButtonTitle forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = buttonFont;
        [self.cancelButton addTarget:self action:@selector(accessoryButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        // If cancelling is disabled, we hide the cancel button but we still create it, because it can
        // transition to backspace after user input.
        self.cancelButton.hidden = !self.allowCancel;
        if (isPad) {
            self.passcodeView.rightButton = self.cancelButton;
        }
        else {
            [self.view addSubview:self.cancelButton];
        }
    }
    else {
        if (self.rightAccessoryButton) {
            [self.cancelButton removeFromSuperview];
            self.cancelButton = nil;
        }
    }

    [self updateAccessoryButtonFontsForSize:self.view.bounds.size];
}

- (void) setLogoImage:(nullable UIImage *) image {
    _logoImageView.image = image;
}

#pragma mark - View Management -
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = self.presentationData.backgroundColor;
    self.view.layer.allowsGroupOpacity = NO;
    [self setUpBackgroundEffectView];
    [self setUpBackgroundView];
    [self setUpAccessoryButtons];
    [self applyTheme];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // Automatically trigger biometric validation if available
    if (self.allowBiometricValidation && self.automaticallyPromptForBiometricValidation) {
        [self accessoryButtonTapped:self.biometricButton];
    }
    
    // Show the keyboard if we're entering alphanumeric characters
    if (self.passcodeType == GxPasscodeTypeCustomAlphanumeric) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            //[self.passcodeView.inputField setEnabled:TRUE];
            [self.passcodeView.inputField becomeFirstResponder];
        });
    }
}

- (void)viewDidLayoutSubviews
{
    CGSize bounds = self.view.bounds.size;
    CGSize maxSize = bounds;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
        if (safeAreaInsets.bottom > 0) {
            maxSize.height -= safeAreaInsets.bottom;
        }
        if (safeAreaInsets.left > 0) {
            maxSize.width -= safeAreaInsets.left;
        }
        if (safeAreaInsets.right > 0) {
            maxSize.width -= safeAreaInsets.right;
        }
    }
    
    // Resize the pin view to scale to the new size
    [self.passcodeView sizeToFitSize:maxSize];
    
    // Re-center the pin view
    CGRect frame = self.passcodeView.frame;
    frame.origin.x = (bounds.width - frame.size.width) * 0.5f;
    frame.origin.y = ((bounds.height - self.keyboardHeight) - frame.size.height) * 0.5f;
    self.passcodeView.frame = CGRectIntegral(frame);

    // --------------------------------------------------

    // Update the accessory button sizes
    [self updateAccessoryButtonFontsForSize:maxSize];

    // Re-layout the accessory buttons
    [self layoutAccessoryButtonsForSize:maxSize];
    
    CGFloat mid = (self.view.frame.size.width / 2.0);
    CGFloat safeAreaTop = self.view.safeAreaInsets.top;
    CGRect logoFrame = CGRectZero;
    logoFrame.origin.x = mid;
    logoFrame.origin.y = safeAreaTop + 16;
    logoFrame.size.height = frame.origin.y - logoFrame.origin.y;
    if(logoFrame.size.height > 64){
        logoFrame.size.height = 64;
    }
    logoFrame.size.width = logoFrame.size.height;
    logoFrame.origin.x -= logoFrame.size.width / 2.0f;
    
    _logoImageView.frame = logoFrame;
    [_logoImageView.layer setCornerRadius:8];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];

    // Force an initial layout if the view hasn't been presented yet
    [UIView performWithoutAnimation:^{
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // Dismiss the keyboard if it is visible
    if (self.passcodeView.inputField.isFirstResponder) {
        [self.passcodeView.inputField resignFirstResponder];
    }
}

#pragma mark - View Rotations -
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    // We don't need to do anything special on iPad or if we're using character input
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad || self.passcodeType == GxPasscodeTypeCustomAlphanumeric) { return; }

    // Work out if we need to transition to horizontal
    BOOL horizontalLayout = size.height < size.width;

    // Perform layout animation
    [self.passcodeView setHorizontalLayout:horizontalLayout animated:coordinator.animated duration:coordinator.transitionDuration];
}

#pragma mark - View Styling -
- (void)applyTheme
{
    // Apply the tint color to the accessory buttons
    UIColor *accessoryTintColor = self.accessoryButtonTintColor;
    if (!accessoryTintColor) {
        accessoryTintColor = UIColor.labelColor;
    }

    self.biometricButton.tintColor = accessoryTintColor;
    self.cancelButton.tintColor = accessoryTintColor;
    self.leftAccessoryButton.tintColor = accessoryTintColor;
    self.rightAccessoryButton.tintColor = accessoryTintColor;

    self.backgroundView.backgroundColor = UIColor.systemFillColor;
}

- (void)updateAccessoryButtonFontsForSize:(CGSize)size
{
    CGFloat width = size.width;
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        width = MIN(size.width, size.height);
    }

    CGFloat pointSize = 17.0f;
    if (width < GxPasscodeViewContentSizeMedium) {
        pointSize = 14.0f;
    }
    else if (width < GxPasscodeViewContentSizeDefault) {
        pointSize = 16.0f;
    }

    UIFont *accessoryFont = [UIFont systemFontOfSize:pointSize];

    self.biometricButton.titleLabel.font = accessoryFont;
    self.cancelButton.titleLabel.font = accessoryFont;
    self.leftAccessoryButton.titleLabel.font = accessoryFont;
    self.rightAccessoryButton.titleLabel.font = accessoryFont;
}

- (void)verticalLayoutAccessoryButtonsForSize:(CGSize)size
{
    CGFloat width = MIN(size.width, size.height);

    CGFloat verticalInset = 54.0f;
    if (width < GxPasscodeViewContentSizeMedium) {
        verticalInset = 37.0f;
    }
    else if (width < GxPasscodeViewContentSizeDefault) {
        verticalInset = 43.0f;
    }

    CGFloat inset = self.passcodeView.keypadButtonInset;
    CGPoint point = (CGPoint){0.0f, (self.view.bounds.size.height - self.keyboardHeight) - verticalInset};
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = self.view.safeAreaInsets;
        if (safeAreaInsets.bottom > 0) {
            point.y -= safeAreaInsets.bottom;
        }
    }

    if (self.leftButton) {
        [self.leftButton sizeToFit];
        point.x = self.passcodeView.frame.origin.x + inset;
        self.leftButton.center = point;
    }

    if (self.rightButton) {
        [self.rightButton sizeToFit];
        point.x = CGRectGetMaxX(self.passcodeView.frame) - inset;
        self.rightButton.center = point;
    }
}

- (void)horizontalLayoutAccessoryButtonsForSize:(CGSize)size
{
    CGRect passcodeViewFrame = self.passcodeView.frame;
    CGFloat buttonInset = self.passcodeView.keypadButtonInset;
    CGFloat width = MIN(size.width, size.height);
    CGFloat verticalInset = 35.0f;
    if (width < GxPasscodeViewContentSizeMedium) {
        verticalInset = 30.0f;
    }
    else if (width < GxPasscodeViewContentSizeDefault) {
        verticalInset = 35.0f;
    }

    if (self.leftButton) {
        [self.leftButton sizeToFit];
        CGRect frame = self.leftButton.frame;
        frame.origin.y = (self.view.bounds.size.height - verticalInset) - (frame.size.height * 0.5f);
        frame.origin.x = (CGRectGetMaxX(passcodeViewFrame) - buttonInset) - (frame.size.width * 0.5f);
        self.leftButton.frame = CGRectIntegral(frame);
    }

    if (self.rightButton) {
        [self.rightButton sizeToFit];
        CGRect frame = self.rightButton.frame;
        frame.origin.y = verticalInset - (frame.size.height * 0.5f);
        frame.origin.x = (CGRectGetMaxX(passcodeViewFrame) - buttonInset) - (frame.size.width * 0.5f);
        self.rightButton.frame = CGRectIntegral(frame);
    }

    [self.view bringSubviewToFront:self.rightButton];
    [self.view bringSubviewToFront:self.leftButton];
}

- (void)layoutAccessoryButtonsForSize:(CGSize)size
{
    // The buttons are always embedded in the keypad view on iPad
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) { return; }

    if (self.passcodeView.horizontalLayout && self.passcodeType != GxPasscodeTypeCustomAlphanumeric) {
        [self horizontalLayoutAccessoryButtonsForSize:size];
    }
    else {
        [self verticalLayoutAccessoryButtonsForSize:size];
    }
}

#pragma mark - Interactions -
- (void)accessoryButtonTapped:(id)sender
{
    if (sender == self.cancelButton) {
        // When entering keyboard input, just leave the button as 'cancel'
        if (self.passcodeType != GxPasscodeTypeCustomAlphanumeric && self.passcodeView.passcode.length > 0) {
            [self.passcodeView deleteLastPasscodeCharacterAnimated:YES];
            [self keypadButtonTapped];
            return;
        }

        if ([self.delegate respondsToSelector:@selector(didTapCancelInPasscodeViewController:)]) {
            [self.delegate didTapCancelInPasscodeViewController:self];
        }
    }
    else if (sender == self.biometricButton) {
        if ([self.delegate respondsToSelector:@selector(didPerformBiometricValidationRequestInPasscodeViewController:)]) {
            [self.delegate didPerformBiometricValidationRequestInPasscodeViewController:self];
        }
    }
}

- (void)keypadButtonTapped
{
    NSString *title = nil;
    if (self.passcodeView.passcode.length > 0) {
        title = self.presentationData.deleteButtonTitle;
        //NSLocalizedString(@"Delete", @"Delete");
    } else if (self.allowCancel) {
        title = self.presentationData.cancelButtonTitle;
        //NSLocalizedString(@"Cancel", @"Cancel");
    }
    
    [UIView performWithoutAnimation:^{
        if (title != nil) {
            [self.cancelButton setTitle:title forState:UIControlStateNormal];
        }
        self.cancelButton.hidden = (title == nil);
    }];
}

- (void)didCompleteEnteringPasscode:(NSString *)passcode
{
    if (![self.delegate respondsToSelector:@selector(passcodeViewController:isCorrectCode:)]) {
        return;
    }

    // Validate the code
    BOOL isCorrect = [self.delegate passcodeViewController:self isCorrectCode:passcode];
    if (!isCorrect) {
        [self.passcodeView resetPasscodeAnimated:YES playImpact:YES];
        return;
    }

    // Hang onto the fact the passcode was successful to play a nicer dismissal animation
    self.passcodeSuccess = YES;

    // Perform handler if correctly entered
    if ([self.delegate respondsToSelector:@selector(didInputCorrectPasscodeInPasscodeViewController:)]) {
        [self.delegate didInputCorrectPasscodeInPasscodeViewController:self];
    }
    else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Keyboard Handling -
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // Extract the keyboard information we need from the notification
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationOptions animationCurve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    // Work out the on-screen height of the keyboard
    self.keyboardHeight = self.view.bounds.size.height - keyboardFrame.origin.y;
    self.keyboardHeight = MAX(self.keyboardHeight, 0.0f);

    // Set that the view needs to be laid out
    [self.view setNeedsLayout];

    if (animationDuration < FLT_EPSILON) {
        return;
    }

    // Animate the content sliding up and down with the keyboard
    [UIView animateWithDuration:animationDuration
                          delay:0.0f
                        options:animationCurve
                     animations:^{ [self.view layoutIfNeeded]; }
                     completion:nil];
}

#pragma mark - Transitioning Delegate -
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                            presentingController:(UIViewController *)presenting
                                                                                sourceController:(UIViewController *)source
{
    return [[GxPasscodeViewControllerAnimatedTransitioning alloc] initWithPasscodeViewController:self dismissing:NO success:NO];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[GxPasscodeViewControllerAnimatedTransitioning alloc] initWithPasscodeViewController:self dismissing:YES success:self.passcodeSuccess];
}

#pragma mark - Convenience Accessors -
- (UIView *)leftButton
{
    return self.leftAccessoryButton ? self.leftAccessoryButton : self.biometricButton;
}

- (UIView *)rightButton
{
    return self.rightAccessoryButton ? self.rightAccessoryButton : self.cancelButton;
}

#pragma mark - Public Accessors -
- (GxPasscodeView *)passcodeView
{
    if (_passcodeView) { return _passcodeView; }

    _passcodeView = [[GxPasscodeView alloc] initWithPasscodeType:self.passcodeType presentationString: _presentationData ];
    _passcodeView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [_passcodeView sizeToFit];
    _passcodeView.center = self.view.center;
    [self.view addSubview:_passcodeView];

    __weak typeof(self) weakSelf = self;
    _passcodeView.passcodeCompletedHandler = ^(NSString *passcode) {
        [weakSelf didCompleteEnteringPasscode:passcode];
    };

    _passcodeView.passcodeDigitEnteredHandler = ^{
        [weakSelf keypadButtonTapped];
    };

    // Set initial layout to horizontal if we're rotated on an iPhone
    if (self.passcodeType != GxPasscodeTypeCustomAlphanumeric && UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPad) {
        CGSize boundsSize = self.view.bounds.size;
        _passcodeView.horizontalLayout = boundsSize.width > boundsSize.height;
    }

    return _passcodeView;
}

- (void)setStyle:(GxPasscodeViewStyle)style
{
    //self.passcodeView.style = style;
    [self setUpBackgroundEffectView];
}

- (void)setAllowBiometricValidation:(BOOL)allowBiometricValidation
{
    if (_allowBiometricValidation == allowBiometricValidation) {
        return;
    }

    _allowBiometricValidation = allowBiometricValidation;
    [self setUpAccessoryButtons];
    [self applyTheme];
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    self.passcodeView.titleLabelColor = titleLabelColor;
}

- (UIColor *)titleLabelColor { return self.passcodeView.titleLabelColor; }

- (void)setInputProgressViewTintColor:(UIColor *)inputProgressViewTintColor
{
    self.passcodeView.inputProgressViewTintColor = inputProgressViewTintColor;
}

- (UIColor *)inputProgressViewTintColor { return self.passcodeView.inputProgressViewTintColor; }

- (void)setKeypadButtonBackgroundTintColor:(UIColor *)keypadButtonBackgroundTintColor
{
    self.passcodeView.keypadButtonBackgroundColor = keypadButtonBackgroundTintColor;
}

- (void)setKeypadButtonShowLettering:(BOOL)keypadButtonShowLettering
{
    self.passcodeView.keypadView.showLettering = keypadButtonShowLettering;
}

- (UIColor *)keypadButtonBackgroundTintColor { return self.passcodeView.keypadButtonBackgroundColor; }

- (void)setKeypadButtonTextColor:(UIColor *)keypadButtonTextColor
{
    self.passcodeView.keypadButtonTextColor = keypadButtonTextColor;
}

- (UIColor *)keypadButtonTextColor { return self.passcodeView.keypadButtonTextColor; }

- (void)setKeypadButtonHighlightedTextColor:(UIColor *)keypadButtonHighlightedTextColor
{
    self.passcodeView.keypadButtonHighlightedTextColor = keypadButtonHighlightedTextColor;
}

- (UIColor *)keypadButtonHighlightedTextColor { return self.passcodeView.keypadButtonHighlightedTextColor; }

- (void)setAccessoryButtonTintColor:(UIColor *)accessoryButtonTintColor
{
    if (accessoryButtonTintColor == _accessoryButtonTintColor) { return; }
    _accessoryButtonTintColor = accessoryButtonTintColor;
    [self applyTheme];
}

- (void)setBiometryType:(GxPasscodeBiometryType)biometryType
{
    if (_biometryType == biometryType) { return; }
    
    _biometryType = biometryType;
    
    if (_biometryType) {
        switch (_biometryType) {
            case GxPasscodeBiometryTypeFaceID: [self.biometricButton setTitle: self.presentationData.faceIdButtonTitle forState:UIControlStateNormal];
            default: [self.biometricButton setTitle: self.presentationData.touchIdButtonTitle forState:UIControlStateNormal];
        }
    }
}

- (void)setContentHidden:(BOOL)contentHidden
{
    [self setContentHidden:contentHidden animated:NO];
}

- (void)setContentHidden:(BOOL)hidden animated:(BOOL)animated
{
    if (hidden == _contentHidden) { return; }
    _contentHidden = hidden;

    void (^setViewsHiddenBlock)(BOOL) = ^(BOOL hidden) {
        self.passcodeView.hidden = hidden;
        self.leftButton.hidden = hidden;
        self.rightButton.hidden = hidden;
    };

    void (^completionBlock)(BOOL) = ^(BOOL complete) {
        setViewsHiddenBlock(hidden);
    };

    if (!animated) {
        completionBlock(YES);
        return;
    }

    // Make sure the views are visible before the animation
    setViewsHiddenBlock(NO);

    void (^animationBlock)(void) = ^{
        CGFloat alpha = hidden ? 0.0f : 1.0f;
        self.passcodeView.contentAlpha = alpha;
        self.leftButton.alpha = alpha;
        self.rightButton.alpha = alpha;
    };

    // Animate
    [UIView animateWithDuration:0.4f animations:animationBlock completion:completionBlock];
}

@end
