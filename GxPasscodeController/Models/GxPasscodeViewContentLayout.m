//
//  GxPasscodeViewContentLayout.m
//
//  Created by Majid Hatami Aghdam on 11/12/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
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

#import "GxPasscodeViewContentLayout.h"

@implementation GxPasscodeViewContentLayout

+ (GxPasscodeViewContentLayout *)defaultScreenContentLayout
{
    GxPasscodeViewContentLayout *contentLayout = [[GxPasscodeViewContentLayout alloc] init];

    /* Width of the PIN View */
    contentLayout.viewWidth = 414.0f;

    /* Bottom Padding */
    contentLayout.bottomPadding = 25.0f;

    /* Title View Constraints */
    contentLayout.titleViewBottomSpacing = 34.0f;

    /* The Title Label Explaining the PIN View */
    contentLayout.titleLabelBottomSpacing = 34.0f;
    contentLayout.titleLabelFont = [UIFont systemFontOfSize: 22.0f];

    /* Horizontal title constraints */
    contentLayout.titleHorizontalLayoutWidth = 250.0f;
    contentLayout.titleHorizontalLayoutSpacing = 35.0f;
    contentLayout.titleViewHorizontalBottomSpacing = 20.0f;
    contentLayout.titleLabelHorizontalBottomSpacing = 20.0f;

    /* Circle Row Configuration */
    contentLayout.circleRowDiameter = 15.5f;
    contentLayout.circleRowSpacing = 30.0f;
    contentLayout.circleRowBottomSpacing = 61.0f;

    /* Text Field Input Configuration */
    contentLayout.textFieldBorderThickness  = 1.5f;
    contentLayout.textFieldBorderRadius     = 5.0f;
    contentLayout.textFieldCircleDiameter   = 10.0f;
    contentLayout.textFieldCircleSpacing    = 6.0f;
    contentLayout.textFieldBorderPadding    = (CGSize){10, 10};
    contentLayout.textFieldNumericCharacterLength  = 10;
    contentLayout.textFieldAlphanumericCharacterLength = 15;
    contentLayout.submitButtonFontSize = 17.0f;
    contentLayout.submitButtonSpacing  = 4.0f;

    /* Circle Button Shape and Layout */
    contentLayout.circleButtonDiameter = 81.0f;
    contentLayout.circleButtonSpacing = (CGSize){25.0f, 20.0f};
    contentLayout.circleButtonStrokeWidth = 1.5f;

    /* Circle Button Label */
    contentLayout.circleButtonTitleLabelFont = [UIFont systemFontOfSize:37.5f weight:UIFontWeightThin];
    contentLayout.circleButtonLetteringLabelFont = [UIFont systemFontOfSize:9.0f weight:UIFontWeightThin];
    contentLayout.circleButtonLabelSpacing = 6.0f;
    contentLayout.circleButtonLetteringSpacing = 3.0f;

    return contentLayout;
}

+ (GxPasscodeViewContentLayout *)mediumScreenContentLayout
{
    GxPasscodeViewContentLayout *contentLayout = [[GxPasscodeViewContentLayout alloc] init];

    /* Width of the PIN View */
    contentLayout.viewWidth = 375.0f;

    /* Bottom Padding */
    contentLayout.bottomPadding = 17.0f;

    /* Title View Constraints */
    contentLayout.titleViewBottomSpacing = 27.0f;

    /* The Title Label Explaining the PIN View */
    contentLayout.titleLabelBottomSpacing = 24.0f;
    contentLayout.titleLabelFont = [UIFont systemFontOfSize: 20.0f];

    /* Horizontal title constraints */
    contentLayout.titleHorizontalLayoutWidth = 185.0f;
    contentLayout.titleHorizontalLayoutSpacing = 16.0f;
    contentLayout.titleViewHorizontalBottomSpacing = 18.0f;
    contentLayout.titleLabelHorizontalBottomSpacing = 18.0f;

    /* Circle Row Configuration */
    contentLayout.circleRowDiameter = 13.5f;
    contentLayout.circleRowSpacing = 26.0f;
    contentLayout.circleRowBottomSpacing = 53.0f;

    /* Submit Button */
    contentLayout.submitButtonFontSize = 16.0f;
    contentLayout.submitButtonSpacing  = 4.0f;
    
    /* Circle Button Shape and Layout */
    contentLayout.circleButtonDiameter = 75.0f;
    contentLayout.circleButtonSpacing = (CGSize){28.0f, 15.0f};
    contentLayout.circleButtonStrokeWidth = 1.5f;

    /* Text Field Input Configuration */
    contentLayout.textFieldBorderThickness  = 1.5f;
    contentLayout.textFieldBorderRadius     = 5.0f;
    contentLayout.textFieldCircleDiameter   = 9.0f;
    contentLayout.textFieldCircleSpacing    = 5.0f;
    contentLayout.textFieldBorderPadding    = (CGSize){10, 10};
    contentLayout.textFieldNumericCharacterLength  = 10;
    contentLayout.textFieldAlphanumericCharacterLength = 15;

    /* Circle Button Label */
    contentLayout.circleButtonTitleLabelFont = [UIFont systemFontOfSize:36.5f weight:UIFontWeightThin];
    contentLayout.circleButtonLetteringLabelFont = [UIFont systemFontOfSize:8.5f weight:UIFontWeightThin];
    contentLayout.circleButtonLabelSpacing = 5.0f;
    contentLayout.circleButtonLetteringSpacing = 2.5f;

    return contentLayout;
}

+ (GxPasscodeViewContentLayout *)smallScreenContentLayout
{
    GxPasscodeViewContentLayout *contentLayout = [[GxPasscodeViewContentLayout alloc] init];

    /* Width of the PIN View */
    contentLayout.viewWidth = 320.0f;

    /* Bottom Padding */
    contentLayout.bottomPadding = 12.0f;

    /* Title View Constraints */
    contentLayout.titleViewBottomSpacing = 23.0f;

    /* The Title Label Explaining the PIN View */
    contentLayout.titleLabelBottomSpacing = 23.0f;
    contentLayout.titleLabelFont = [UIFont systemFontOfSize: 17.0f];

    /* Horizontal title constraints */
    contentLayout.titleHorizontalLayoutWidth = 185.0f;
    contentLayout.titleHorizontalLayoutSpacing = 5.0f;
    contentLayout.titleViewHorizontalBottomSpacing = 18.0f;
    contentLayout.titleLabelHorizontalBottomSpacing = 18.0f;

    /* Circle Row Configuration */
    contentLayout.circleRowDiameter = 12.5f;
    contentLayout.circleRowSpacing = 22.0f;
    contentLayout.circleRowBottomSpacing = 44.0f;

    /* Text Field Input Configuration */
    contentLayout.textFieldBorderThickness  = 1.5f;
    contentLayout.textFieldBorderRadius     = 5.0f;
    contentLayout.textFieldCircleDiameter   = 8.0f;
    contentLayout.textFieldCircleSpacing    = 4.0f;
    contentLayout.textFieldBorderPadding    = (CGSize){8, 8};
    contentLayout.textFieldNumericCharacterLength  = 10;
    contentLayout.textFieldAlphanumericCharacterLength = 15;

    /* Submit Button */
    contentLayout.submitButtonFontSize = 15.0f;
    contentLayout.submitButtonSpacing  = 3.0f;

    /* Circle Button Shape and Layout */
    contentLayout.circleButtonDiameter = 76.0f;
    contentLayout.circleButtonSpacing = (CGSize){20.0f, 12.5f};
    contentLayout.circleButtonStrokeWidth = 1.5f;

    /* Circle Button Label */
    contentLayout.circleButtonTitleLabelFont = [UIFont systemFontOfSize:35.0f weight:UIFontWeightThin];
    contentLayout.circleButtonLetteringLabelFont = [UIFont systemFontOfSize:9.0f weight:UIFontWeightThin];
    contentLayout.circleButtonLabelSpacing = 4.5f;
    contentLayout.circleButtonLetteringSpacing = 2.0f;

    return contentLayout;
}

@end
