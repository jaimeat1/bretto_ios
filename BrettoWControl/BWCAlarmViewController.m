//
//  BWCAlarmViewController.m
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BWCAlarmViewController.h"

@interface BWCAlarmViewController ()

@end

@implementation BWCAlarmViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    } else if (sender == self.setSensibilityBtn) {
        [self.delegate commandPressed:@"sensibility"];
    }
}

@end
