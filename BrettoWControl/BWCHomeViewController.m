//
//  BWCHomeViewController.m
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCHomeViewController.h"

@interface BWCHomeViewController ()

@end

@implementation BWCHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.delegate = (BWCAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        
        CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
        
        // iPhone 3G, 3GS, 4, 4S
        if (iOSDeviceScreenSize.height == 480) {            
            self.viewiPhone5.hidden = YES;            
        // iPhone 5
        } else {            
            self.viewiPhone.hidden = YES;            
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // If its first time after installation, show wizard
    if (([[NSUserDefaults standardUserDefaults] objectForKey:@"wizardShown"] == nil) || ([[NSUserDefaults standardUserDefaults] boolForKey:@"wizardShown"] == NO)) {
        [self performSegueWithIdentifier:@"wizard" sender:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    [self.delegate buttonPressed:sender];
}

@end
