//
//  BWCStep2ViewController.m
//  BrettoWControl
//
//  Created by Jaime on 03/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCStep2ViewController.h"

@interface BWCStep2ViewController ()

@end

@implementation BWCStep2ViewController

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
    
    self.title = NSLocalizedString(@"WizardStep2", @"");
    
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
    // Field is empty
    if (self.number.text.length == 0) {
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                    message:NSLocalizedString(@"ErrorNumber", @"")
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                          otherButtonTitles:nil]
         show];
        
    // Save
    } else {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.number.text forKey:@"numberAlarm"];
        
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"wizardStep3"];
        [self.navigationController pushViewController:viewController animated:YES];
        
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
    [self.number becomeFirstResponder];
    [self.number setSelected:YES];
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
