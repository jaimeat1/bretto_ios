//
//  BWCPasswordViewController.m
//  BrettoWControl
//
//  Created by Jaime on 17/02/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCPasswordViewController.h"
#import "BWCAppDelegate.h"
#import "BWCCommandBuilder.h"

@interface BWCPasswordViewController ()

@property (nonatomic, copy) NSString* passwordKey;

@end

@implementation BWCPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.oldPassword.secureTextEntry = YES;
    self.theNewPassword.secureTextEntry = YES;
    self.repeatPassword.secureTextEntry = YES;
    
    // Password for application or for alarm
    if (self.isAppPassword) {
        self.passwordKey = @"passwordApp";
        self.navigationItem.title = NSLocalizedString(@"PasswordApp", @"");
    } else {
        self.passwordKey = @"parsswordAlarm";
        self.navigationItem.title = NSLocalizedString(@"PasswordAlarm", @"");
    }
    // Cancel button
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    // Save button
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = save;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)savePressed:(id)sender
{
    NSString* errorMessage = nil;
    
    // Fields are empty
    if ((self.oldPassword.text.length == 0) &&
        (self.theNewPassword.text.length == 0) &&
        (self.repeatPassword.text.length == 0)) {
        
        errorMessage = NSLocalizedString(@"ErrorPassEmpty", @"");

    // Check fields before save
    } else {
        
        NSString* currentPassword = [[NSUserDefaults standardUserDefaults] stringForKey:self.passwordKey];
        
        // Current password is wrong
        if (![currentPassword isEqualToString:self.oldPassword.text]) {
            
            errorMessage = NSLocalizedString(@"ErrorPassOld", @"");
            
        // New password is empty
        } else if (self.theNewPassword.text.length == 0) {

            errorMessage = NSLocalizedString(@"ErrorPassEmpty", @"");

        // New password doesn't match
        } else if (![self.theNewPassword.text isEqualToString:self.repeatPassword.text]) {

            errorMessage = NSLocalizedString(@"ErrorPassNew", @"");
            
        // Save new password in preferences
        } else {
         
            [[NSUserDefaults standardUserDefaults] setObject:self.theNewPassword.text forKey:self.passwordKey];
            
            [self dismissModalViewControllerAnimated:YES];
            
            // It's alarm password, send command
            if (!self.isAppPassword) {
                NSMutableArray* params = [NSMutableArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"parsswordAlarm"], self.theNewPassword.text, nil];
                NSString *message = [BWCCommandBuilder buildCommand:BWCCommandPassword withParameters:params];
                [(BWCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];
            }         
        }
    
    }
    
    // Show error alert
    if (errorMessage.length != 0){
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                    message:errorMessage
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                          otherButtonTitles:nil]
         show];
    }
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    switch (indexPath.row) {
        case 0:
            [self.oldPassword becomeFirstResponder];
            [self.oldPassword setSelected:YES];
            break;
        case 1:
            [self.theNewPassword becomeFirstResponder];
            [self.theNewPassword setSelected:YES];
            break;
        case 2:
            [self.repeatPassword becomeFirstResponder];
            [self.repeatPassword setSelected:YES];
            break;
        default:
            break;
    }
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
