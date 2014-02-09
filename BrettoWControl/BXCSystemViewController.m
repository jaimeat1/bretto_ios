//
//  BWCSystemViewController.m
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BXCSystemViewController.h"

@interface BXCSystemViewController ()

@end

@implementation BXCSystemViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    if (sender == self.stateBtn) {
        [self.delegate commandPressed:@"state"];
    } else if (sender == self.softResetBtn) {
        [self.delegate commandPressed:@"reset"];
    } else if (sender == self.hardResetBtn) {
        [self.delegate commandPressed:@"hardReset"];
    }
}

@end
