//
//  BWCAppDelegate.m
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <MessageUI/MessageUI.h>

#import "BWCCommandBuilder.h"
#import "BWCAppDelegate.h"

@interface BWCAppDelegate() <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

/** Main tab bar controller */
@property (nonatomic, strong) UITabBarController *tabBarController;
/** Command in process */
@property (nonatomic, copy) NSString* currentCommand;
/** Button in interface that has launched the action */
@property (nonatomic, strong) UIButton* currentSender;
/** Action sheet used to ask for some options */
@property (nonatomic, strong) UIActionSheet* actionSheetOptions;
/** Action sheet used to ask for confirmation */
@property (nonatomic, strong) UIActionSheet* actionSheetConfirmation;
/** Index pressed in last action sheet */
@property (nonatomic) NSInteger actionIndex;


@end

@implementation BWCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // TODO: delete
    [[NSUserDefaults standardUserDefaults] setObject:@"1234" forKey:@"parsswordAlarm"];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 Called when the user presses a button. Prepares the command launching
 */
- (void)buttonPressed:(id)sender
{
    self.currentCommand = [(UIButton *)sender accessibilityLabel];
    self.currentSender = (UIButton *)sender;
    NSArray* param = [NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"parsswordAlarm"]];
    DLog(@"%@", self.currentCommand);
    
    if ([self.currentCommand isEqualToString:@"assembleOn"]){
        
        [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandAssembleOn withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"assembleOff"]) {
        
        [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandAssembleOff withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"sensor"]) {
        
        [self askForOptions];
        
    } else if ([self.currentCommand isEqualToString:@"save"]) {
        
        [self askForOptions];
        
    } else if ([self.currentCommand isEqualToString:@"location"]) {
        
        [self askForOptions];
        
    } else if ([self.currentCommand isEqualToString:@"engine"]) {
        
        [self askForOptions];
        
    } else if ([self.currentCommand isEqualToString:@"siren"]) {
        
        [self askForOptions];
        
    } else if ([self.currentCommand isEqualToString:@"bretto"]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.bretto.es"]];
        
    } else if ([self.currentCommand isEqualToString:@"call"]) {
        
        // segue in storyboard
        
    } else if ([self.currentCommand isEqualToString:@"imei"]) {
        
        [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandImei withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"setDevices"]) {
        
        // segue in storyboard
        
    } else if ([self.currentCommand isEqualToString:@"getDevices"]) {
        
        [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandGetDevices withParameters:param]];
        
    } else if ([self.currentCommand isEqualToString:@"sensibility"]) {
        
        // segue in storyboard
        
    } else if ([self.currentCommand isEqualToString:@"state"]) {
        
        [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandState withParameters:param]];
        
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
        title = NSLocalizedString(@"Sensibility", @"");
    } else if ([self.currentCommand isEqualToString:@"save"]) {
        title = NSLocalizedString(@"Save", @"");
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
        [self.currentCommand isEqualToString:@"save"] ||
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
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"PasswordTitle", @"")
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Accept", nil];
    [alert setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [alert show];
}

/**
 Opens SMS application
 */
- (void)composeMessage:(NSString *)message
{

    MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
    messageComposer.messageComposeDelegate = self;
    messageComposer.body = message;
    messageComposer.recipients = [NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"numberAlarm"]];
    [self.tabBarController presentModalViewController:messageComposer animated:YES];
 
    // Shows pop-up with message to send
/*
     NSString* title = [NSString stringWithFormat:@"SMS se enviará a %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"numberAlarm"]];
     
     [[[UIAlertView alloc] initWithTitle:title
     message:message
     delegate:nil
     cancelButtonTitle:NSLocalizedString(@"Accept", @"")
     otherButtonTitles:nil]
     show];
*/
}

#pragma mark - MFMessageComposeViewController

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissModalViewControllerAnimated:YES];
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
    
    NSArray* param = [NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"parsswordAlarm"]];

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
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandSensorOn withParameters:param]];
                    break;
                case 1:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandSensorOff withParameters:param]];
                    break;
                default:
                    break;
            }
    
        } else if ([self.currentCommand isEqualToString:@"save"]) {
            
            switch (buttonIndex) {
                case 0:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandSaveOn withParameters:param]];
                    break;
                case 1:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandSaveOff withParameters:param]];
                    break;
                default:
                    break;
            }
            
        } else if ([self.currentCommand isEqualToString:@"location"]) {
            
            switch (buttonIndex) {
                case 0:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandLocationGPRMC withParameters:param]];
                    break;
                case 1:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandLocationGPSD withParameters:param]];
                    break;
                case 2:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandLocationWeb withParameters:param]];
                    break;
                default:
                    break;
            }
            
        } else if ([self.currentCommand isEqualToString:@"siren"]) {
            
            switch (buttonIndex) {
                case 0:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandSirenOn withParameters:param]];
                    break;
                case 1:
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandSirenOff withParameters:param]];
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
                        [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandImmobilizeOff withParameters:param]];
                    } else {
                        [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandImmobilizeOn withParameters:param]];
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
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandReset withParameters:param]];
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
                    
                    [self composeMessage:[BWCCommandBuilder buildCommand:BWCCommandHardReset withParameters:param]];  
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"1234" forKey:@"parsswordAlarm"];
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"passwordApp"];
                    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"numberAlarm"];
                    [[NSUserDefaults standardUserDefaults] setObject:NO forKey:@"askPassword"];
                    [[NSUserDefaults standardUserDefaults] setObject:NO forKey:@"wizzardShown"];
                                                    
                    [self.tabBarController setSelectedIndex:0];
                    
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
    UITextField *password = [alertView textFieldAtIndex:0];
    
    NSString* validPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"passwordApp"];
    
    if ((password.text.length == 0) || (![validPassword isEqualToString:password.text])) {
        [self showPasswordAlertWithError:YES];
    }
}

@end