//
//  GxPasscodePresentationStrings.h
//  GxPasscodeController
//
//  Created by Majid Hatami Aghdam on 11/12/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface GxPasscodePresentationData : NSObject

@property (nonatomic, strong) UIColor* backgroundColor;
@property (nonatomic, strong) UIColor* transitionBackgroundColor;
@property (nonatomic, strong) UIColor* keypadButtonHighlightedTextColor;

@property (nonatomic, strong) NSString* deleteButtonTitle;
@property (nonatomic, strong) NSString* cancelButtonTitle;
@property (nonatomic, strong) NSString* faceIdButtonTitle;
@property (nonatomic, strong) NSString* touchIdButtonTitle;

@property (nonatomic, strong) NSString* enterPasscodeViewTitle;// = NSLocalizedString(@"Enter Passcode", @"");
@property (nonatomic, strong) NSArray*  dialpad_letteredTitles; //@[@"ABC", @"DEF", @"GHI", @"JKL", @"MNO", @"PQRS", @"TUV", @"WXYZ"];
    
@property (nonatomic, strong) NSString* setPassCodePage_Title;
@property (nonatomic, strong) NSString* setPassCodePage_EnterCurrentPasscode;
@property (nonatomic, strong) NSString* setPassCodePage_EnterNewPasscode;
@property (nonatomic, strong) NSString* setPassCodePage_ConfirmNewPasscode;
@property (nonatomic, strong) NSString* setPassCodePage_EnterCurrentPasscodeTitle;
@property (nonatomic, strong) NSString* setPassCodePage_DidnotMatch;

@property (nonatomic, strong) NSString*  setPassCodePage_passwordTypeOptions_sixDigitCode;
@property (nonatomic, strong) NSString*  setPassCodePage_passwordTypeOptions_fourDigitCode;
@property (nonatomic, strong) NSString*  setPassCodePage_passwordTypeOptions_customNumeric;
@property (nonatomic, strong) NSString*  setPassCodePage_passwordTypeOptions_customAlphanumeric;

@property (nonatomic, strong) NSString* setPassCodePage_PasscodeOptionsButton; // NSLocalizedString(@"Passcode Options", @"")
@property (nonatomic, strong) UIColor*  setPassCodePage_PasscodeOptionsButtonTintColor;
@property (nonatomic, strong) NSString* setPassCodePage_FailedPassCodeAttempts;

@end

NS_ASSUME_NONNULL_END
