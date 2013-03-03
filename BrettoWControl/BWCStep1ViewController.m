//
//  BWCStep1ViewController.m
//  BrettoWControl
//
//  Created by Jaime on 03/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCStep1ViewController.h"
#import "BWCStep2ViewController.h"

@interface BWCStep1ViewController ()

@end

@implementation BWCStep1ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"WizzardStep1", @"");
    
    self.password.secureTextEntry = YES;
    self.repeatPassword.secureTextEntry = YES;
    
    // Save button
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Next", @"") style:UIBarButtonItemStyleDone target:self action:@selector(donePressed:)];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)donePressed:(id)sender
{
    NSString* errorMessage = nil;
    
    // Field are empty
    if (self.password.text.length == 0) {
        
        errorMessage = NSLocalizedString(@"ErrorPassEmpty", @"");
        
    // Check fields before save
    } else {

        if (![self.password.text isEqualToString:self.repeatPassword.text]) {
            
            errorMessage = NSLocalizedString(@"ErrorPassNew", @"");
            
        // Save new password in preferences
        } else {
            
            [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"passwordApp"];

            UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"wizzardStep2"];
            [self.navigationController pushViewController:viewController animated:YES];
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
            [self.password becomeFirstResponder];
            [self.password setSelected:YES];
            break;
        case 1:
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
