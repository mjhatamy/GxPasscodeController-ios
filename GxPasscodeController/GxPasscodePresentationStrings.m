//
//  GxPasscodePresentationStrings.m
//  GxPasscodeController
//
//  Created by Majid Hatami Aghdam on 11/12/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

#import "GxPasscodePresentationStrings.h"

@implementation GxPasscodePresentationStrings

- (instancetype)init
{
    self = [super init];
    if (self) {
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
        self.setPassCodePage_passwordTypeOptions = @[ NSLocalizedString(@"4-Digit Numeric Code", @""),
        NSLocalizedString(@"6-Digit Numeric Code", @""),
        NSLocalizedString(@"Custom Numeric Code", @""),
        NSLocalizedString(@"Custom Alphanumeric Code", @"")];
        
        self.setPassCodePage_FailedPassCodeAttempts = NSLocalizedString(@"%d Failed Passcode Attempts !!!", @"");
    }
    return self;
}
@end
