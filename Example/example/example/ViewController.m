//
//  ViewController.m
//  example
//
//  Created by Majid Hatami Aghdam on 11/12/19.
//  Copyright © 2019 Majid Hatami Aghdam. All rights reserved.
//

#import "ViewController.h"

#import <GxPasscodeController/GxPasscodeController.h>

@interface ViewController ()<GxPasscodeViewControllerDelegate, GxPasscodeSettingsViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onCodeViewPressed:(UIButton *)sender {
    
    GxPasscodePresentationStrings *presentationString = [[GxPasscodePresentationStrings alloc] init];
    presentationString.enterPasscodeViewTitle = @"Enter PASS";
    presentationString. dialpad_letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL", @"MNO", @"PQRS", @"TUV", @"WXYZ"];
    presentationString.setPassCodePage_FailedPassCodeAttempts = NSLocalizedString(@"%d Failed Passcode Attempts !!!", @"");
    
    GxPasscodeViewController *passcodeViewController = [[GxPasscodeViewController alloc] initWithType:TOPasscodeTypeFourDigits presentationString:presentationString];
    passcodeViewController.delegate = self;
    passcodeViewController.allowCancel = false;
    passcodeViewController.allowBiometricValidation = false; //self.biometricsAvailable;
    //passcodeViewController.biometryType = self.faceIDAvailable ? TOPasscodeBiometryTypeFaceID : TOPasscodeBiometryTypeTouchID;
    //passcodeViewController.keypadButtonShowLettering = self.showButtonLettering;
    
    passcodeViewController.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}
- (IBAction)onSettingBtnPressed:(UIButton *)sender {
    GxPasscodePresentationStrings *presentationString = [[GxPasscodePresentationStrings alloc] init];
    presentationString.cancelButtonTitle = @"Cancel";
    presentationString.enterPasscodeViewTitle = @"Enter PASS";
    presentationString.dialpad_letteredTitles = @[@"ABC", @"DEF", @"GHI", @"JKL", @"MNO", @"PQRS", @"TUV", @"WXYZ"];
    presentationString.setPassCodePage_Title = @"Set Passcode";
    presentationString.setPassCodePage_DidnotMatch = @"Passcode didn't match.";
    presentationString.setPassCodePage_EnterCurrentPasscode = @"Enter current passcode";
    presentationString.setPassCodePage_EnterNewPasscode = @"Enter new passcode";
    presentationString.setPassCodePage_ConfirmNewPasscode = @"Confirm new passcode";
    presentationString.setPassCodePage_FailedPassCodeAttempts = NSLocalizedString(@"%d Failed Passcode Attempts !!!", @"");
    GxPasscodeSettingsViewController *settingsController = [[GxPasscodeSettingsViewController alloc] initWithPresentationString: presentationString];
    
    settingsController.passcodeType = TOPasscodeTypeFourDigits;
    settingsController.delegate = self;
    settingsController.requireCurrentPasscode = YES;
    settingsController.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    //[self.navigationController pushViewController:settingsController animated:YES];
    [self presentViewController:settingsController animated:YES completion:nil];
}

- (BOOL)passcodeViewController:(GxPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code {
    return [code  isEqual: @"1234"];
}

- (void)didInputCorrectPasscodeInPasscodeViewController:(GxPasscodeViewController *)passcodeViewController {
    NSLog(@"correct code entered");
    [passcodeViewController dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)passcodeSettingsViewController:(GxPasscodeSettingsViewController *)passcodeSettingsViewController
             didAttemptCurrentPasscode:(NSString *)passcode {
    return [passcode  isEqual: @"1234"];
}

- (void)passcodeSettingsViewController:(GxPasscodeSettingsViewController *)passcodeSettingsViewController
                didChangeToNewPasscode:(NSString *)passcode ofType:(GxPasscodeType)type {
    NSLog(@"passcode: %@ -- type: %ld\n", passcode,  (long)type);
    [passcodeSettingsViewController dismissViewControllerAnimated:true completion:nil];
}
@end
