//
//  GxPasscodePresentationStrings.m
//  GxPasscodeController
//
//  Created by Majid Hatami Aghdam on 11/12/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

#import "GxPasscodePresentationData.h"

@implementation GxPasscodePresentationData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.keypadButtonHighlightedTextColor = [UIColor blackColor];
        self.setPassCodePage_PasscodeOptionsButtonTintColor = UIColor.labelColor;
        
        self.cancelButtonTitle = NSLocalizedString(@"Cancel", @"");
        self.deleteButtonTitle = NSLocalizedString(@"Delete", @"");
        self.faceIdButtonTitle = NSLocalizedString(@"Face ID", @"");
        self.touchIdButtonTitle = NSLocalizedString(@"Touch ID", @"");
        self.enterPasscodeViewTitle = NSLocalizedString(@"Enter passcode", @"");
        self.dialpad_letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL", @"MNO", @"PQRS", @"TUV", @"WXYZ"];
        
        
        self.setPassCodePage_Title = NSLocalizedString(@"Set Passcode", @"");
        
        self.setPassCodePage_EnterCurrentPasscode = NSLocalizedString(@"Enter current passcode", @"");
        self.setPassCodePage_EnterNewPasscode = NSLocalizedString(@"Enter new passcode", @"");
        
        self.setPassCodePage_ConfirmNewPasscode = NSLocalizedString(@"Confirm new passcode", @"");
        
        self.setPassCodePage_EnterCurrentPasscodeTitle = NSLocalizedString(@"Enter your current Passcode", @"");
        self.setPassCodePage_DidnotMatch = NSLocalizedString(@"Passcode didn't match.", @"");
        
        self.setPassCodePage_PasscodeOptionsButton = NSLocalizedString(@"Passcode Options", @"");
        self.setPassCodePage_passwordTypeOptions_fourDigitCode = NSLocalizedString(@"4-Digit Numeric Code", @"");
        self.setPassCodePage_passwordTypeOptions_sixDigitCode = NSLocalizedString(@"6-Digit Numeric Code", @"");
        self.setPassCodePage_passwordTypeOptions_customNumeric = NSLocalizedString(@"Custom Numeric Code", @"");
        self.setPassCodePage_passwordTypeOptions_customAlphanumeric = NSLocalizedString(@"Custom Alphanumeric Code", @"");
        
        self.setPassCodePage_FailedPassCodeAttempts = NSLocalizedString(@"%d Failed Passcode Attempts !!!", @"");
    }
    return self;
}

-(void) setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    _keypadButtonHighlightedTextColor = backgroundColor;
}

@end
