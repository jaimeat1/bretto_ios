//
//  BWCConfigureNumbersViewController.m
//  BrettoWControl
//
//  Created by Jaime on 02/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCSetDevicesViewController.h"
#import "BXCCommandBuilder.h"
#import "BXCAppDelegate.h"

@interface BWCSetDevicesViewController ()

@end

@implementation BWCSetDevicesViewController

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
    
    self.title = NSLocalizedString(@"SetDevices", @"");
    
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
    
    // Fields are empty
    if ((self.numberA.text.length == 0) &&
        (self.numberB.text.length == 0) &&
        (self.numberC.text.length == 0)) {
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                    message:NSLocalizedString(@"ErrorDevices", @"")
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                          otherButtonTitles:nil]
         show];
        
    // Send set devices command
    } else {
        
        
        NSMutableArray* param = [NSMutableArray arrayWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"passwordAlarm"]];
        
        if (self.numberA.text.length != 0) {
            [param addObject:self.numberA.text];
        }
        
        if (self.numberB.text.length != 0) {
            [param addObject:self.numberB.text];
        }
        
        if (self.numberC.text.length != 0) {
            [param addObject:self.numberC.text];
        }
        
        [self dismissViewControllerAnimated:YES completion:^(void){
            
            NSString *message = [BXCCommandBuilder buildCommand:BWCCommandSetDevices withParameters:param];
            [(BXCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];
            
        }];
        
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
            [self.numberA becomeFirstResponder];
            [self.numberA setSelected:YES];
            break;
        case 1:
            [self.numberB becomeFirstResponder];
            [self.numberB setSelected:YES];
            break;
        case 2:
            [self.numberC becomeFirstResponder];
            [self.numberC setSelected:YES];
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
