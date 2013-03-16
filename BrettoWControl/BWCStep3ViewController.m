//
//  BWCStep3ViewController.m
//  BrettoWControl
//
//  Created by Jaime on 03/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCStep3ViewController.h"
#import "BWCCommandBuilder.h"
#import "BWCAppDelegate.h"

@interface BWCStep3ViewController ()

@end

@implementation BWCStep3ViewController

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
    
    self.title = NSLocalizedString(@"WizzardStep3", @"");

    // Save button
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Finish", @"") style:UIBarButtonItemStyleDone target:self action:@selector(donePressed:)];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)donePressed:(id)sender
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
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wizzardShown"];
        
        [self dismissViewControllerAnimated:YES completion:^(void){

            NSString *message = [BWCCommandBuilder buildCommand:BWCCommandSetDevices withParameters:param];
            [(BWCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];
            
            [(BWCAppDelegate *)[[UIApplication sharedApplication] delegate] setCurrentCommand:@"wizzard"];
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
