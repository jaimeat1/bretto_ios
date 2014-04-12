//
//  BWCAlarmViewController.m
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BXCAlarmViewController.h"

@interface BXCAlarmViewController ()

@end

@implementation BXCAlarmViewController

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

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)buttonPressed:(id)sender
{
    if (sender == self.callBtn) {
        [self.delegate commandPressed:@"call"];
    } else if (sender == self.imeiBtn) {
        [self.delegate commandPressed:@"imei"];
    } else if (sender == self.setDevicesBtn) {
        [self.delegate commandPressed:@"setDevices"];
    } else if (sender == self.getDevicesBtn) {
        [self.delegate commandPressed:@"getDevices"];
    } else if (sender == self.automaticBtn) {
        [self.delegate commandPressed:@"automatic"];
    }else if (sender == self.speedBtn) {
        [self.delegate commandPressed:@"speed"];
    }
}

@end
