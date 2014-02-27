//
//  BWCAppDelegate.m
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved. 
//

#import <MessageUI/MessageUI.h>

#import "BXCCommandBuilder.h"
#import "BXCAppDelegate.h"

@interface BXCAppDelegate() <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

/** Main tab bar controller */
@property (nonatomic, strong) UITabBarController *tabBarController;
/** Action sheet used to ask for some options */
@property (nonatomic, strong) UIActionSheet* actionSheetOptions;
/** Action sheet used to ask for confirmation */
@property (nonatomic, strong) UIActionSheet* actionSheetConfirmation;
/** Index pressed in last action sheet */
@property (nonatomic) NSInteger actionIndex;
/** Alert to ask for application password */
@property (nonatomic, strong) UIAlertView *alertPassword;
/** Alert to show message to send, used by debugging */
@property (nonatomic, strong) UIAlertView *alertMessage;
/** Picker view used to select values as time and speed */
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation BXCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Default value for alarm password is 1234
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"1234" forKey:@"passwordAlarm"];
    }
    
    self.tabBarController = (UITabBarController*)self.window.rootViewController;
    self.tabBarController.delegate = self;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"askPassword"]) {
        [self showPasswordAlertWithError:NO];
    }
    
    // SMS can't be send or it's not an iPhone
    if (([MFMessageComposeViewController canSendText] == NO) ||
        ([[[UIDevice currentDevice] model] rangeOfString:@"iPhone"].location == NSNotFound)) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                                        message:NSLocalizedString(@"ErrorSMSconnection", @"")
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Accept", nil];
        [alert show];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 Called when the user presses a button. Prepares the command launching
 */
- (void)commandPressed:(NSString *)command;
{
    self.currentCommand = command;
    NSArray* param = [NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"]];
    DLog(@"%@", self.currentCommand);
    
    if ([self.currentCommand isEqualToString:@"assembleOn"]){
        
        [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandAssembleOn withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"assembleOff"]) {
        
        [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandAssembleOff withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"climate"]) {
        
        [self askForOptions];
        
    } else if ([self.currentCommand isEqualToString:@"engine"]) {
        
        // TODO:
        
    } else if ([self.currentCommand isEqualToString:@"ignition"]) {
        
        // TODO:
        
    } else if ([self.currentCommand isEqualToString:@"location"]) {
        
        // TODO:
        
    } else if ([self.currentCommand isEqualToString:@"sensor"]) {
        
        // [self askForOptions];
        
        // TODO:
        
    } else if ([self.currentCommand isEqualToString:@"bretto"]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.bretto.es"]];
        
        
        
    } else if ([self.currentCommand isEqualToString:@"call"]) {
        
        // segue in storyboard
        
    } else if ([self.currentCommand isEqualToString:@"imei"]) {
        
        [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandImei withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"setDevices"]) {
        
        // segue in storyboard
        
    } else if ([self.currentCommand isEqualToString:@"getDevices"]) {
        
        [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandGetDevices withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"speed"]) {
        
        // segue in storyboard
        
    } else if ([self.currentCommand isEqualToString:@"state"]) {
        
        [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandState withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"reset"]) {
        
        [self askForConfirmation];
        
    } else if ([self.currentCommand isEqualToString:@"hardReset"]) {
        
        [self askForConfirmation];
        
    } else if ([self.currentCommand isEqualToString:@"contact"]) {
        
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *emailComposer = [[MFMailComposeViewController alloc] init];
            [emailComposer setMailComposeDelegate:self];
            [emailComposer setToRecipients:[NSArray arrayWithObject:@"contacto@bretto.es"]];
            [self.tabBarController presentModalViewController:emailComposer animated:YES];
        }
        
    }
}

/**
 Returns a localized title for the action sheet
 */
- (NSString *)getTitleForActionSheet{
    
    NSString* title = @"";
    
    if ([self.currentCommand isEqualToString:@"sensor"]) {
        title = NSLocalizedString(@"Sensor", @"");
    } else if ([self.currentCommand isEqualToString:@"climate"]) {
        title = NSLocalizedString(@"Climate", @"");
    } else if ([self.currentCommand isEqualToString:@"location"]) {
        title = NSLocalizedString(@"Location", @"");
    } else if ([self.currentCommand isEqualToString:@"engine"]) {
        title = NSLocalizedString(@"Engine", @"");
    } else if ([self.currentCommand isEqualToString:@"siren"]) {
        title = NSLocalizedString(@"Siren", @"");
    } else if ([self.currentCommand isEqualToString:@"reset"]) {
        title = NSLocalizedString(@"Reset", @"");
    } else if ([self.currentCommand isEqualToString:@"hardReset"]) {
        title = NSLocalizedString(@"ResetHard", @"");
    }
    
    return title;
}

/**
 Asks the user for a set of options
 */
- (void)askForOptions
{
    self.actionSheetOptions = nil;
    
    // Enable/ Disable options
    if ([self.currentCommand isEqualToString:@"sensor"] ||
        [self.currentCommand isEqualToString:@"climate"] ||
        [self.currentCommand isEqualToString:@"engine"] ||
        [self.currentCommand isEqualToString:@"siren"]) {
        
        self.actionSheetOptions = [[UIActionSheet alloc] initWithTitle:[self getTitleForActionSheet]
                                                                 delegate:self
                                                        cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"Enable", @""), NSLocalizedString(@"Disable", @""), nil];
        
    // Location options
    } else if ([self.currentCommand isEqualToString:@"location"]) {
        
        self.actionSheetOptions = [[UIActionSheet alloc] initWithTitle:[self getTitleForActionSheet]
                                                                 delegate:self
                                                        cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:NSLocalizedString(@"GPRMC", @""), NSLocalizedString(@"GPS", @""), NSLocalizedString(@"Web", @""), nil];

    }
    
    [self.actionSheetOptions showFromTabBar:self.tabBarController.tabBar];
}

/**
 Asks the user for a confirmation YES/NO action
 */
- (void)askForConfirmation
{
    self.actionSheetConfirmation = nil;
    NSString* message = nil;
    
    if ([self.currentCommand isEqualToString:@"engine"]) {
        
        message = [NSString stringWithFormat:@"%@\n\n%@", [self getTitleForActionSheet], NSLocalizedString(@"Confirmation1", @"")];
  
    } else if ([self.currentCommand isEqualToString:@"reset"]) {
        
        message = [NSString stringWithFormat:@"%@\n\n%@", [self getTitleForActionSheet], NSLocalizedString(@"Confirmation2", @"")];
        
    } else if ([self.currentCommand isEqualToString:@"hardReset"]) {
        
        message = [NSString stringWithFormat:@"%@\n\n%@", [self getTitleForActionSheet], NSLocalizedString(@"Confirmation3", @"")];
        
    }
    
    if (message != nil) {
    
        // Don't use destructive button in action sheet
        if ([self.currentCommand isEqualToString:@"engine"]) {
            
            self.actionSheetConfirmation = [[UIActionSheet alloc] initWithTitle:message
                                                                       delegate:self
                                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                         destructiveButtonTitle:nil
                                                              otherButtonTitles:NSLocalizedString(@"Yes", @""),
                                            NSLocalizedString(@"No", @""), nil];
            
        // Use destructive button in action sheet
        } else {
            
            self.actionSheetConfirmation = [[UIActionSheet alloc] initWithTitle:message
                                                                       delegate:self
                                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                                         destructiveButtonTitle:NSLocalizedString(@"Yes", @"")
                                                              otherButtonTitles:NSLocalizedString(@"No", @""), nil];
        }
    
        [self.actionSheetConfirmation showFromTabBar:self.tabBarController.tabBar];
    }

}

/**
 Shows an alert view to ask for the application password.
 @param error YES includes an error message , NO doesn't includes an error message
 */
- (void)showPasswordAlertWithError:(bool)error
{
    NSString *message;
    
    if (error) {
        message = NSLocalizedString(@"AskPasswordError", @"");
    } else {
        message = NSLocalizedString(@"AskPassword", @"");
    }
    
    self.alertPassword = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"PasswordTitle", @"")
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Accept", nil];
    [self.alertPassword setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [self.alertPassword show];
}

/**
 Opens SMS application
 @param message text by default to fill the message composer
 */
- (void)composeMessage:(NSString *)message
{

    // There is no alarm number configuration
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"numberAlarm"] == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                                        message:NSLocalizedString(@"ErrorNoNumberAlarm", @"")
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"Accept", nil];
        [alert show];
        
    // There is alarm number
    } else {
// TODO: uncomment in release
/*
        // SMS can't be send or it's not an iPhone
        if (([MFMessageComposeViewController canSendText] == NO) ||
            ([[[UIDevice currentDevice] model] rangeOfString:@"iPhone"].location == NSNotFound)) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                                            message:NSLocalizedString(@"ErrorSMSconnection", @"")
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Accept", nil];
            [alert show];
            
            // Show wizard again next time
            if ([self.currentCommand isEqualToString:@"wizard"]){
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"wizardShown"];
            }
            
        // Send SMS
        } else {
            
            MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
            messageComposer.messageComposeDelegate = self;
            messageComposer.body = message;
            messageComposer.recipients = [NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"numberAlarm"]];
            
            @try {
                [self.tabBarController presentModalViewController:messageComposer animated:YES];
            }
            @catch (NSException *ex)
            {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                                            message:NSLocalizedString(@"ErrorSMSsending", @"")
                                           delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                                  otherButtonTitles:nil]
                 show];
            }
            
        }
*/
        // TODO: comment in release version
        // Shows pop-up with message to send, used in debbuging version

         NSString* title = [NSString stringWithFormat:@"SMS se enviará a %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"numberAlarm"]];
         
         self.alertMessage = [[UIAlertView alloc] initWithTitle:title
         message:message
         delegate:self
         cancelButtonTitle:NSLocalizedString(@"Accept", @"")
         otherButtonTitles:NSLocalizedString(@"Cancel", @""), nil];
         
         [self.alertMessage show];

    }
}

#pragma mark - MFMessageComposeViewController
 
/** 
 Called when message composer is closed (send success, error or cancel). Some actions must be done after message result
 */
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissModalViewControllerAnimated:YES];
    
    // Command to change alarm password, change it if SMS has been successfuly sent
    if ([self.currentCommand isEqualToString:@"passwordAlarm"] && (result == MessageComposeResultSent)) {
        
        NSString *newPass = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"newPasswordAlarm"];
        [[NSUserDefaults standardUserDefaults] setObject:newPass forKey:@"passwordAlarm"];
        
    // Command to hard reset, reset all values if SMS has been successfuly sent    
    } else if ([self.currentCommand isEqualToString:@"hardReset"] && (result == MessageComposeResultSent)) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1234" forKey:@"passwordAlarm"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"passwordApp"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"numberAlarm"];
        [[NSUserDefaults standardUserDefaults] setObject:NO forKey:@"askPassword"];
        [[NSUserDefaults standardUserDefaults] setObject:NO forKey:@"wizardShown"];
        
        [self.tabBarController setSelectedIndex:0];
        
    // Wizard has just been sent
    } else if ([self.currentCommand isEqualToString:@"wizard"]){
        
        // Wizard successfuly sent
        if (result == MessageComposeResultSent) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wizardShown"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"askPassword"];
        
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention", @"")
                                        message:NSLocalizedString(@"Advice", @"")
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                              otherButtonTitles:nil]
             show];

        // Error in sending wizard
        } else {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"wizardShown"];
        }
    }
    
    // Error sending SMS
    if (result == MessageComposeResultFailed) {
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                                    message:NSLocalizedString(@"ErrorSMSsending", @"")
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                          otherButtonTitles:nil]
         show];
    }
}

/**
 Mock delegate method used to simulate result of message composing in debugging version, where real message composer is not available
 This method must be equal to messageComposeViewController:controller didFinishWithResult:
 */
- (void)mockDelegateMessageComposeViewControllerDidFinishWithResult:(MessageComposeResult)result
{
    // Command to change alarm password, change it if SMS has been successfuly sent
    if ([self.currentCommand isEqualToString:@"passwordAlarm"] && (result == MessageComposeResultSent)) {
        
        NSString *newPass = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:@"newPasswordAlarm"];
        [[NSUserDefaults standardUserDefaults] setObject:newPass forKey:@"passwordAlarm"];
        
    // Command to hard reset, reset all values if SMS has been successfuly sent
    } else if ([self.currentCommand isEqualToString:@"hardReset"] && (result == MessageComposeResultSent)) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1234" forKey:@"passwordAlarm"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"passwordApp"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"numberAlarm"];
        [[NSUserDefaults standardUserDefaults] setObject:NO forKey:@"askPassword"];
        [[NSUserDefaults standardUserDefaults] setObject:NO forKey:@"wizardShown"];
        
        [self.tabBarController setSelectedIndex:0];
        
    // Wizard has just been sent
    } else if ([self.currentCommand isEqualToString:@"wizard"]){
        
        // Wizard successfuly sent
        if (result == MessageComposeResultSent) {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wizardShown"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"askPassword"];
            
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention", @"")
                                        message:NSLocalizedString(@"Advice", @"")
                                       delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                              otherButtonTitles:nil]
             show];
            
        // Error in sending wizard
        } else {
            
            [[NSUserDefaults standardUserDefaults] setObject:NO forKey:@"wizardShown"];
            [[self.tabBarController selectedViewController] viewDidAppear:YES];
        }
    }
    
    // Error sending SMS
    if (result == MessageComposeResultFailed) {
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                                    message:NSLocalizedString(@"ErrorSMSsending", @"")
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                          otherButtonTitles:nil]
         show];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

/**
 Called when user sends or cancels the email composition
 */
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIActionSheetDelgate methods

/**
 Called when user selects a valid option in whatever action sheet.
 If a confirmation is needed, this method launchs a new action sheet. Otherwise, launchs the command builder
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DLog(@"buttonIndex %d", buttonIndex);
    
    NSArray* param = [NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"]];

    // Action sheet to ask for an option
    if (self.actionSheetOptions == actionSheet) {
        
        if ((([self.currentCommand isEqualToString:@"engine"] ||
            [self.currentCommand isEqualToString:@"reset"] ||
            [self.currentCommand isEqualToString:@"hardReset"])) &&
            (buttonIndex != 2)) {
            
            self.actionIndex = buttonIndex;            
            [self askForConfirmation];
            
        } else if ([self.currentCommand isEqualToString:@"sensor"]) {
            
            switch (buttonIndex) {
                case 0:
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandSensorOn withParameters:param]];
                    break;
                case 1:
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandSensorOff withParameters:param]];
                    break;
                default:
                    break;
            }
    
        } else if ([self.currentCommand isEqualToString:@"climate"]) {
            
            switch (buttonIndex) {
                case 0:
                    // TODO: segue to set climate
                    break;
                case 1:
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandClimateOff withParameters:param]];
                    break;
                default:
                    break;
            }
            
        } else if ([self.currentCommand isEqualToString:@"location"]) {
            
            switch (buttonIndex) {
                case 0:
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandLocationGPRMC withParameters:param]];
                    break;
                case 1:
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandLocationGPSD withParameters:param]];
                    break;
                case 2:
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandLocationWeb withParameters:param]];
                    break;
                default:
                    break;
            }
            
        }
        
    // Action sheet to ask for confirmation YES/NO
    } else if (self.actionSheetConfirmation == actionSheet){
        
        if ([self.currentCommand isEqualToString:@"engine"]) {
            
            switch (buttonIndex) {
                case 0:
                    if (self.actionIndex == 0) {
                        [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandImmobilizeOff withParameters:param]];
                    } else {
                        [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandImmobilizeOn withParameters:param]];
                    }
                    break;
                case 1:
                    // NO, do nothing
                    break;
                default:
                    break;
            }
            
        } else if ([self.currentCommand isEqualToString:@"reset"]) {
            
            switch (buttonIndex) {
                case 0:
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandReset withParameters:param]];
                    break;
                case 1:
                    // NO, do nothing
                    break;
                default:
                    break;
            }
            
        } else if ([self.currentCommand isEqualToString:@"hardReset"]) {
            
            switch (buttonIndex) {
                case 0:                
                    [self composeMessage:[BXCCommandBuilder buildCommand:BWCCommandHardReset withParameters:param]];  
                    break;
                case 1:
                    // NO, do nothing
                    break;
                default:
                    break;
            }
            
        }
        
    } // end ask confirmation
    
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Alert to ask for application password
    if (alertView == self.alertPassword) {
        
        UITextField *password = [alertView textFieldAtIndex:0];
    
        NSString* validPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"passwordApp"];
    
        if ((password.text.length == 0) || (![validPassword isEqualToString:password.text])) {
            [self showPasswordAlertWithError:YES];
        }
        
    // Alert to show message to send, used in debugging
    } else if (alertView == self.alertMessage) {

        // Simulate SMS sent successfuly
        if (buttonIndex == 0) {
            [self mockDelegateMessageComposeViewControllerDidFinishWithResult:MessageComposeResultSent];
        // Simulate SMS canceled
        } else {
            [self mockDelegateMessageComposeViewControllerDidFinishWithResult:MessageComposeResultFailed];
        }
        
    }
}

#pragma mark - UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    if ([self.currentCommand isEqualToString:@"climate"] || [self.currentCommand isEqualToString:@"engine"]) {
        return 1;
    } else {
        // TODO: check "speed" command
        return 2;
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.currentCommand isEqualToString:@"climate"] || [self.currentCommand isEqualToString:@"engine"]) {
        return 99;
    } else {
        // TODO: check "speed" command
        if (component == 0) {
            return 279;
        } else {
            return 99;
        }
    }
}

#pragma mark - UIPickerViewDelegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // TODO
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // TODO
    return @"";
}

@end
