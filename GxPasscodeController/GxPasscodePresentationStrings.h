//
//  GxPasscodePresentationStrings.h
//  GxPasscodeController
//
//  Created by Majid Hatami Aghdam on 11/12/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GxPasscodePresentationStrings : NSObject

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
    
@property (nonatomic, strong) NSArray*  setPassCodePage_passwordTypeOptions;
@property (nonatomic, strong) NSString* setPassCodePage_PasscodeOptionsButton; // NSLocalizedString(@"Passcode Options", @"")
@property (nonatomic, strong) NSString* setPassCodePage_FailedPassCodeAttempts;

@end

NS_ASSUME_NONNULL_END
