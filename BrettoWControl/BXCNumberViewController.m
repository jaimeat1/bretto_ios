//
//  BWCNumberViewController.m
//  BrettoWControl
//
//  Created by Jaime on 17/02/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BXCNumberViewController.h"

@interface BXCNumberViewController ()

@end

@implementation BXCNumberViewController

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
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"PasswordAlarm", @"");
    
    // Show current number
    self.numberFld.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"numberAlarm"];
    
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)savePressed:(id)sender
{
    // Field is empty
    if (self.numberFld.text.length == 0) {
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                    message:NSLocalizedString(@"ErrorNumber", @"")
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                          otherButtonTitles:nil]
         show];
        
    // Save
    } else {

        [[NSUserDefaults standardUserDefaults] setObject:self.numberFld.text forKey:@"numberAlarm"];
        [self dismissViewControllerAnimated:YES completion:nil];

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
    [self.numberFld becomeFirstResponder];
    [self.numberFld setSelected:YES];
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
