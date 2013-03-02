//
//  BWCCallViewController.m
//  BrettoWControl
//
//  Created by Jaime on 02/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCCallViewController.h"
#import "BWCCommandBuilder.h"
#import "BWCAppDelegate.h"

@interface BWCCallViewController ()

@end

@implementation BWCCallViewController

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

    self.title = NSLocalizedString(@"Call", @"");
    
    // Cancel button
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed:)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    // Call button
    UIBarButtonItem *callBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Call", @"") style:UIBarButtonSystemItemAction target:self action:@selector(callPressed:)];
    
    self.navigationItem.rightBarButtonItem = callBtn;
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

- (void)callPressed:(id)sender
{
    
    // Field is empty
    if (self.numberFld.text.length == 0) {
        
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ErrorTitle", @"")
                                    message:NSLocalizedString(@"ErrorNumber", @"")
                                   delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Accept", @"")
                          otherButtonTitles:nil]
         show];
        
    // Send call command
    } else {

        NSArray* param = [NSArray arrayWithObjects:[[NSUserDefaults standardUserDefaults] objectForKey:@"parsswordAlarm"], self.numberFld.text, nil];
        
        NSString *message = [BWCCommandBuilder buildCommand:BWCCommandCall withParameters:param];
        [(BWCAppDelegate *)[[UIApplication sharedApplication] delegate] composeMessage:message];
        [self dismissModalViewControllerAnimated:YES];
        
    }
    
    // Comprobar no está vacío
    
    // Enviar comando
    
    // Dismiss view
    
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

@end
