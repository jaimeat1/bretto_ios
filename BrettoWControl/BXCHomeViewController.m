//
//  BWCHomeViewController.m
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BXCHomeViewController.h"

@interface BXCHomeViewController ()

@end

@implementation BXCHomeViewController

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
	
    self.delegate = (BXCAppDelegate*)[[UIApplication sharedApplication] delegate];
    
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
    if ((sender == self.assembleOnBtn) || (sender == self.assembleOnBtniPhone5)) {
        [self.delegate commandPressed:@"assembleOn"];
    } else if ((sender == self.assembleOffBtn) || (sender == self.assembleOffBtniPhone5)) {
        [self.delegate commandPressed:@"assembleOff"];
    } else if ((sender == self.sensorBtn) || (sender == self.sensorBtniPhone5)) {
        [self.delegate commandPressed:@"sensor"];
    } else if ((sender == self.saveBtn) || (sender == self.saveBtniPhone5)) {
        [self.delegate commandPressed:@"save"];
    } else if ((sender == self.locationBtn) || (sender == self.locationBtniPhone5)) {
        [self.delegate commandPressed:@"location"];
    } else if ((sender == self.engineBtn) || (sender == self.engineBtniPhone5)) {
        [self.delegate commandPressed:@"engine"];
    } else if ((sender == self.sirenBtn) || (sender == self.sirenBtniPhone5)) {
        [self.delegate commandPressed:@"siren"];
    } else if ((sender == self.bannerBtn) || (sender == self.bannerBtniPhone5)) {
        [self.delegate commandPressed:@"bretto"];
    }
}

@end
