//
//  GxPasscodeViewControllerConstants.h
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

/* The visual style of the asscode view controller */
typedef NS_ENUM(NSInteger, GxPasscodeViewStyle) {
    GxPasscodeViewStyleTranslucentDark,
    GxPasscodeViewStyleTranslucentLight,
    GxPasscodeViewStyleOpaqueDark,
    GxPasscodeViewStyleOpaqueLight
};

/* The visual style of the passcode settings view controller. */
typedef NS_ENUM(NSInteger, GxPasscodeSettingsViewStyle) {
    TOPasscodeSettingsViewStyleLight,
    TOPasscodeSettingsViewStyleDark
};

/* Depending on the amount of horizontal space, the sizing of the elements */
typedef NS_ENUM(NSInteger, GxPasscodeViewContentSize) {
    GxPasscodeViewContentSizeDefault = 414, // Default, 414 points and above (6 Plus, all remaining iPad sizes)
    GxPasscodeViewContentSizeMedium = 375, // Greater or equal to 375 points: iPhone 6 / iPad Pro 1/4 split mode
    GxPasscodeViewContentSizeSmall  = 320  // Greater or equal to 320 points: iPhone SE / iPad 1/4 split mode
};

/* The types of passcodes that may be used. */
typedef NS_ENUM(NSInteger, GxPasscodeType) {
    GxPasscodeTypeFourDigits,           // 4 Numbers
    GxPasscodeTypeSixDigits,            // 6 Numbers
    GxPasscodeTypeCustomNumeric,        // Any length of numbers
    GxPasscodeTypeCustomAlphanumeric    // Any length of characters
};

/* The type of biometrics this controller can handle */
typedef NS_ENUM(NSInteger, GxPasscodeBiometryType) {
    GxPasscodeBiometryTypeTouchID,
    GxPasscodeBiometryTypeFaceID
};

