//
//  BWCAlarmViewController.h
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BWCAppDelegate.h"

@interface BWCAlarmViewController : UIViewController

@property id <BWCButtonDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *callBtn;
@property (nonatomic, weak) IBOutlet UIButton *imeiBtn;
@property (nonatomic, weak) IBOutlet UIButton *setDevicesBtn;
@property (nonatomic, weak) IBOutlet UIButton *getDevicesBtn;
@property (nonatomic, weak) IBOutlet UIButton *setSensibilityBtn;

- (IBAction)buttonPressed:(id)sender;

@end
