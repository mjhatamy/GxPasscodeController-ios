//
//  GxPasscodeView.m
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

#import "GxPasscodeView.h"
#import "GxPasscodeViewContentLayout.h"
#import "GxPasscodeCircleButton.h"
#import "GxPasscodeInputField.h"
#import "GxPasscodeKeypadView.h"

@interface GxPasscodeView ()

/* The current layout object used to configure this view */
@property (nonatomic, weak) GxPasscodeViewContentLayout *currentLayout;

/* The main views */
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) GxPasscodeInputField *inputField;
@property (nonatomic, strong, readwrite) GxPasscodeKeypadView *keypadView;

/* The type of passcode we're displaying */
@property (nonatomic, assign, readwrite) GxPasscodeType passcodeType;
@property (nonatomic, readwrite) GxPasscodePresentationStrings *presentationStrings;

@end

@implementation GxPasscodeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [self initWithFrame:frame]) {
        [self setUp];
    }

    return self;
}

- (instancetype)initWithPasscodeType:(GxPasscodeType)type presentationString:(GxPasscodePresentationStrings *)presentationStrings
{
    if (self = [super initWithFrame:CGRectMake(0,0,320,393)]) {
        _presentationStrings = presentationStrings;
        _passcodeType = type;
        [self setUp];
    }

    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self initWithCoder:aDecoder]) {
        [self setUp];
    }

    return self;
}

- (void)setUp
{
    // Set up default properties
    self.userInteractionEnabled = YES;
    _defaultContentLayout = [GxPasscodeViewContentLayout defaultScreenContentLayout];
    _currentLayout = _defaultContentLayout;
    _contentLayouts = @[[GxPasscodeViewContentLayout mediumScreenContentLayout],
                        [GxPasscodeViewContentLayout smallScreenContentLayout]];
    _titleText = self.presentationStrings.enterPasscodeViewTitle;
    //NSLocalizedString(@"Enter Passcode", @"");

    // Start configuring views
    [self setUpViewForType:self.passcodeType];

    // Set the default layout for the views
    [self updateSubviewsForContentLayout:_defaultContentLayout];

    // Configure the theme of all of the views
    [self applyTheme];
}

#pragma mark - View Layout -
- (void)verticallyLayoutSubviews
{
    CGSize viewSize = self.frame.size;
    CGSize midViewSize = (CGSize){self.frame.size.width * 0.5f, self.frame.size.height * 0.5f};

    CGRect frame = CGRectZero;
    CGFloat y = 0.0f;

    // Title View
    if (self.titleView) {
        frame = self.titleView.frame;
        frame.origin.y = y;
        frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
        self.titleView.frame = CGRectIntegral(frame);

        y = CGRectGetMaxY(frame) + self.currentLayout.titleViewBottomSpacing;
    }

    // Title Label
    frame = self.titleLabel.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.titleLabel.frame = CGRectIntegral(frame);

    y = CGRectGetMaxY(frame) + self.currentLayout.titleLabelBottomSpacing;

    // Circle Row View
    [self.inputField sizeToFit];
    frame = self.inputField.frame;
    frame.origin.y = y;
    frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
    self.inputField.frame = CGRectIntegral(frame);

    y = CGRectGetMaxY(frame) + self.currentLayout.circleRowBottomSpacing;

    // PIN Pad View
    if (self.keypadView) {
        frame = self.keypadView.frame;
        frame.origin.y = y;
        frame.origin.x = midViewSize.width - (CGRectGetWidth(frame) * 0.5f);
        self.keypadView.frame = CGRectIntegral(frame);
    }

    // If the keypad view is hidden, lay out the left button manually
    if (!self.keypadView && self.leftButton) {
        frame = self.leftButton.frame;
        frame.origin.x = 0.0f;
        frame.origin.y = y;
        self.leftButton.frame = frame;
    }

    // If the keypad view is hidden, lay out the right button manually
    if (!self.keypadView && self.rightButton) {
        frame = self.rightButton.frame;
        frame.origin.x = viewSize.width - frame.size.width;
        frame.origin.y = y;
        self.rightButton.frame = frame;
    }
}

- (void)horizontallyLayoutSubviews
{
    CGSize midViewSize = (CGSize){self.frame.size.width * 0.5f, self.frame.size.height * 0.5f};
    CGRect frame = CGRectZero;

    // Work out the y offset, assuming the input field is in the middle
    frame.origin.y = midViewSize.height - (self.inputField.frame.size.height * 0.5f);
    frame.origin.y -= (self.titleLabel.frame.size.height + self.currentLayout.titleLabelHorizontalBottomSpacing);

    // Include offset for title view if present
    if (self.titleView) {
        frame.origin.y -= (self.titleView.frame.size.height + self.currentLayout.titleViewHorizontalBottomSpacing);
    }

    // Set initial Y offset
    frame.origin.y = MAX(frame.origin.y, 0.0f);

    // Set frame of title view
    if (self.titleView) {
        frame.size = self.titleView.frame.size;
        frame.origin.x = (self.currentLayout.titleHorizontalLayoutWidth - frame.size.width) * 0.5f;
        self.titleView.frame = CGRectIntegral(frame);

        frame.origin.y += (frame.size.height + self.currentLayout.titleViewHorizontalBottomSpacing);
    }

    // Set frame of title label
    frame.size = self.titleLabel.frame.size;
    frame.origin.x = (self.currentLayout.titleHorizontalLayoutWidth - frame.size.width) * 0.5f;
    self.titleLabel.frame = CGRectIntegral(frame);

    frame.origin.y += (frame.size.height + self.currentLayout.titleLabelHorizontalBottomSpacing);

    // Set frame of the input field
    frame.size = self.inputField.frame.size;
    frame.origin.x = (self.currentLayout.titleHorizontalLayoutWidth - frame.size.width) * 0.5f;
    self.inputField.frame = CGRectIntegral(frame);

    // Set the frame of the keypad view
    frame.size = self.keypadView.frame.size;
    frame.origin.y = 0.0f;
    frame.origin.x = self.currentLayout.titleHorizontalLayoutWidth + self.currentLayout.titleHorizontalLayoutSpacing;
    self.keypadView.frame = CGRectIntegral(frame);
}

- (void)layoutSubviews
{
    if (self.horizontalLayout) {
        [self horizontallyLayoutSubviews];
    }
    else {
        [self verticallyLayoutSubviews];
    }
}

- (void)sizeToFitSize:(CGSize)size
{
    CGFloat width = size.width;
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        width = MIN(size.width, size.height);
    }

    NSMutableArray *layouts = [NSMutableArray array];
    [layouts addObject:self.defaultContentLayout];
    [layouts addObjectsFromArray:self.contentLayouts];

    // Loop through each layout (in ascending order) and pick the best one to fit this view
    GxPasscodeViewContentLayout *contentLayout = self.defaultContentLayout;
    for (GxPasscodeViewContentLayout *layout in layouts) {
        if (width >= layout.viewWidth) {
            contentLayout = layout;
            break;
        }
    }

    // Set the new layout
    self.currentLayout = contentLayout;

    // Resize the views to fit
    [self sizeToFit];
}

- (void)verticalSizeToFit
{
    CGRect frame = self.frame;
    frame.size.width = 0.0f;
    frame.size.height = 0.0f;

    [self.keypadView sizeToFit];
    [self.inputField sizeToFit];

    if (self.keypadView) {
        frame.size.width = self.keypadView.frame.size.width;
    }
    else {
        frame.size.width = self.inputField.frame.size.width;
    }

    // Add height for the title view
    if (self.titleView) {
        frame.size.height += self.titleView.frame.size.height;
        frame.size.height += self.currentLayout.titleViewBottomSpacing;
    }

    // Add height for the title label
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.size = [self.titleLabel sizeThatFits:(CGSize){frame.size.width, CGFLOAT_MAX}];
    self.titleLabel.frame = titleFrame;

    frame.size.height += titleFrame.size.height;
    frame.size.height += self.currentLayout.titleLabelBottomSpacing;

    // Add height for the circle rows
    frame.size.height += self.inputField.frame.size.height;
    frame.size.height += self.currentLayout.circleRowBottomSpacing;

    // Add height for the keypad
    if (self.keypadView) {
        frame.size.height += self.keypadView.frame.size.height;
    }
    else { // If no keypad, just factor in the accessory buttons
        [self.leftButton sizeToFit];
        [self.rightButton sizeToFit];

        CGFloat maxHeight = 0.0f;
        maxHeight = MAX(self.leftButton.frame.size.height, 0.0f);
        maxHeight = MAX(self.rightButton.frame.size.height, maxHeight);

        frame.size.height += maxHeight;
    }

    // Add extra padding at the bottom
    frame.size.height += self.currentLayout.bottomPadding;

    // Set the frame back
    self.frame = CGRectIntegral(frame);
}

- (void)horizontalSizeToFit
{
    CGRect frame = self.frame;

    [self.keypadView sizeToFit];
    [self.inputField sizeToFit];

    frame.size.width = self.currentLayout.titleHorizontalLayoutWidth;
    frame.size.width += self.currentLayout.titleHorizontalLayoutSpacing;
    frame.size.width += self.keypadView.frame.size.width;

    frame.size.height = self.keypadView.frame.size.height;

    self.frame = CGRectIntegral(frame);
}

- (void)sizeToFit
{
    if (self.horizontalLayout && self.passcodeType != GxPasscodeTypeCustomAlphanumeric) {
        [self horizontalSizeToFit];
    }
    else {
        [self verticalSizeToFit];
    }
}

#pragma mark - View Setup -
- (void)setUpViewForType:(GxPasscodeType)type
{
    __weak typeof(self) weakSelf = self;

    self.backgroundColor = [UIColor clearColor];

    // Set up title label
    if (self.titleLabel == nil) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    self.titleLabel.text = self.titleText;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    [self addSubview:self.titleLabel];

    // Set up the passcode style
    TOPasscodeInputFieldStyle style = TOPasscodeInputFieldStyleFixed;
    if (type >= GxPasscodeTypeCustomNumeric) {
        style = TOPasscodeInputFieldStyleVariable;
    }

    // Set up input field
    if (self.inputField == nil) {
        self.inputField = [[GxPasscodeInputField alloc] initWithStyle:style];
    }
    self.inputField.passcodeCompletedHandler = ^(NSString *passcode) {
        if (weakSelf.passcodeCompletedHandler) {
            weakSelf.passcodeCompletedHandler(passcode);
        }
    };

    // Configure the input field based on the exact passcode type
    if (style == TOPasscodeInputFieldStyleFixed) {
        self.inputField.fixedInputView.length = (self.passcodeType == GxPasscodeTypeSixDigits) ? 6 : 4;
    }
    else {
        self.inputField.showSubmitButton = (self.passcodeType == GxPasscodeTypeCustomNumeric);
        self.inputField.enabled = (self.passcodeType == GxPasscodeTypeCustomAlphanumeric);
    }

    [self addSubview:self.inputField];

    // Set up pad row
    if (type != GxPasscodeTypeCustomAlphanumeric) {
        if (self.keypadView == nil) {
            self.keypadView = [[GxPasscodeKeypadView alloc] init:(self.presentationStrings)];
        }
        self.keypadView.buttonTappedHandler = ^(NSInteger button) {
            NSString *numberString = [NSString stringWithFormat:@"%ld", (long)button];
            [weakSelf.inputField appendPasscodeCharacters:numberString animated:NO];

            if (weakSelf.passcodeDigitEnteredHandler) {
                weakSelf.passcodeDigitEnteredHandler();
            }
        };
        [self addSubview:self.keypadView];
    }
    else {
        [self.keypadView removeFromSuperview];
        self.keypadView = nil;
    }
}

- (void)updateSubviewsForContentLayout:(GxPasscodeViewContentLayout *)contentLayout
{
    // Title View
    self.titleLabel.font = contentLayout.titleLabelFont;

    // Circle Row View
    self.inputField.fixedInputView.circleDiameter = contentLayout.circleRowDiameter;
    self.inputField.fixedInputView.circleSpacing = contentLayout.circleRowSpacing;

    // Text Field Input Row
    NSInteger maximumInputLength = (self.passcodeType == GxPasscodeTypeCustomAlphanumeric) ?
                                            contentLayout.textFieldAlphanumericCharacterLength :
                                            contentLayout.textFieldNumericCharacterLength;

    self.inputField.variableInputView.outlineThickness = contentLayout.textFieldBorderThickness;
    self.inputField.variableInputView.outlineCornerRadius = contentLayout.textFieldBorderRadius;
    self.inputField.variableInputView.circleDiameter = contentLayout.textFieldCircleDiameter;
    self.inputField.variableInputView.circleSpacing = contentLayout.textFieldCircleSpacing;
    self.inputField.variableInputView.outlinePadding = contentLayout.textFieldBorderPadding;
    self.inputField.variableInputView.maximumVisibleLength = maximumInputLength;

    // Submit button
    self.inputField.submitButtonSpacing = contentLayout.submitButtonSpacing;
    self.inputField.submitButtonFontSize = contentLayout.submitButtonFontSize;

    // Keypad
    self.keypadView.buttonNumberFont = contentLayout.circleButtonTitleLabelFont;
    self.keypadView.buttonLetteringFont = contentLayout.circleButtonLetteringLabelFont;
    self.keypadView.buttonLetteringSpacing = contentLayout.circleButtonLetteringSpacing;
    self.keypadView.buttonLabelSpacing = contentLayout.circleButtonLabelSpacing;
    self.keypadView.buttonSpacing = contentLayout.circleButtonSpacing;
    self.keypadView.buttonDiameter = contentLayout.circleButtonDiameter;
}

- (void)applyTheme
{
    // Set title label color
    UIColor *titleLabelColor = self.titleLabelColor;
    if (titleLabelColor == nil) {
        titleLabelColor = UIColor.labelColor;
    }
    self.titleLabel.textColor = titleLabelColor;

    // Add/remove the translucency effect to the buttons
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    self.inputField.visualEffectView.effect = vibrancyEffect;
    self.keypadView.vibrancyEffect = vibrancyEffect;

    // Set keyboard style of the input field
    //self.inputField.keyboardAppearance = isDark ? UIKeyboardAppearanceDark : UIKeyboardAppearanceDefault;

    UIColor *defaultTintColor = UIColor.secondaryLabelColor;
    
    // Set the tint color of the circle row view
    UIColor *circleRowColor = self.inputProgressViewTintColor;
    if (circleRowColor == nil) {
        circleRowColor = defaultTintColor;
    }
    self.inputField.tintColor = defaultTintColor;

    // Set the tint color of the keypad buttons
    UIColor *keypadButtonBackgroundColor = self.keypadButtonBackgroundColor;
    if (keypadButtonBackgroundColor == nil) {
        keypadButtonBackgroundColor = defaultTintColor;
    }
    self.keypadView.buttonBackgroundColor = keypadButtonBackgroundColor;

    // Set the color of the keypad button labels
    UIColor *buttonTextColor = self.keypadButtonTextColor;
    if (buttonTextColor == nil) {
        buttonTextColor = UIColor.labelColor;
    }
    self.keypadView.buttonTextColor = buttonTextColor;

    // Set the highlight color of the keypad button
    //UIColor *buttonHighlightedTextColor = self.keypadButtonHighlightedTextColor;
    //self.keypadView.buttonHighlightedTextColor = buttonHighlightedTextColor;
}

#pragma mark - Passcode Management -
- (void)resetPasscodeAnimated:(BOOL)animated playImpact:(BOOL)impact
{
    [self.inputField resetPasscodeAnimated:animated playImpact:impact];
}

- (void)deleteLastPasscodeCharacterAnimated:(BOOL)animated
{
    [self.inputField deletePasscodeCharactersOfCount:1 animated:animated];
}

#pragma mark - Accessors -
- (void)setHorizontalLayout:(BOOL)horizontalLayout
{
    [self setHorizontalLayout:horizontalLayout animated:NO duration:0.0f];
}

- (void)setHorizontalLayout:(BOOL)horizontalLayout animated:(BOOL)animated duration:(CGFloat)duration
{
    if (horizontalLayout == _horizontalLayout) { return; }
    _horizontalLayout = horizontalLayout;
    [self.keypadView setHorizontalLayout:horizontalLayout animated:animated duration:duration];
    [self.inputField setHorizontalLayout:horizontalLayout animated:animated duration:duration];
}

- (void)setDefaultContentLayout:(GxPasscodeViewContentLayout *)defaultContentLayout
{
    if (defaultContentLayout == _defaultContentLayout) { return; }
    _defaultContentLayout = defaultContentLayout;

    if (!_defaultContentLayout) {
        _defaultContentLayout = [GxPasscodeViewContentLayout defaultScreenContentLayout];
    }
}

- (void)setCurrentLayout:(GxPasscodeViewContentLayout *)currentLayout
{
    if (_currentLayout == currentLayout) { return; }
    _currentLayout = currentLayout;

    // Update the views
    [self updateSubviewsForContentLayout:currentLayout];
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    if (titleLabelColor == _titleLabelColor) { return; }
    _titleLabelColor = titleLabelColor;
    self.titleLabel.textColor = titleLabelColor;
}

- (void)setInputProgressViewTintColor:(UIColor *)inputProgressViewTintColor
{
    if (inputProgressViewTintColor == _inputProgressViewTintColor) { return; }
    _inputProgressViewTintColor = inputProgressViewTintColor;
    self.inputField.tintColor = inputProgressViewTintColor;
}

- (void)setKeypadButtonBackgroundColor:(UIColor *)keypadButtonBackgroundColor
{
    if (keypadButtonBackgroundColor == _keypadButtonBackgroundColor) { return; }
    _keypadButtonBackgroundColor = keypadButtonBackgroundColor;
    self.keypadView.buttonBackgroundColor = keypadButtonBackgroundColor;
}

- (void)setKeypadButtonTextColor:(UIColor *)keypadButtonTextColor
{
    if (keypadButtonTextColor == _keypadButtonTextColor) { return; }
    _keypadButtonTextColor = keypadButtonTextColor;
    self.keypadView.buttonTextColor = keypadButtonTextColor;
}

- (void)setKeypadButtonHighlightedTextColor:(UIColor *)keypadButtonHighlightedTextColor
{
    if (keypadButtonHighlightedTextColor == _keypadButtonHighlightedTextColor) { return; }
    _keypadButtonHighlightedTextColor = keypadButtonHighlightedTextColor;
    self.keypadView.buttonHighlightedTextColor = keypadButtonHighlightedTextColor;
}

- (void)setLeftButton:(UIButton *)leftButton
{
    if (leftButton == _leftButton) { return; }
    _leftButton = leftButton;

    if (self.keypadView) {
        self.keypadView.leftAccessoryView = leftButton;
    }
    else {
        [self addSubview:_leftButton];
    }
}

- (void)setRightButton:(UIButton *)rightButton
{
    if (rightButton == _rightButton) { return; }
    _rightButton = rightButton;

    if (self.keypadView) {
        self.keypadView.rightAccessoryView = rightButton;
    }
    else {
        [self addSubview:_rightButton];
    }
}

- (CGFloat)keypadButtonInset
{
    UIView *button = self.keypadView.keypadButtons.firstObject;
    return CGRectGetMidX(button.frame);
}

- (void)setContentAlpha:(CGFloat)contentAlpha
{
    _contentAlpha = contentAlpha;

    self.titleView.alpha = contentAlpha;
    self.titleLabel.alpha = contentAlpha;
    self.inputField.contentAlpha = contentAlpha;
    self.keypadView.contentAlpha = contentAlpha;
    self.leftButton.alpha = contentAlpha;
    self.rightButton.alpha = contentAlpha;
}

- (void)setPasscode:(NSString *)passcode
{
    [self.inputField setPasscode:passcode];
}

- (NSString *)passcode
{
    return self.inputField.passcode;
}

@end
