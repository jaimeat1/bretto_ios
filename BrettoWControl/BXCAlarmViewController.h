//
//  BWCAlarmViewController.h
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BXCAppDelegate.h"

@interface BXCAlarmViewController : UIViewController

@property id <BXCButtonDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *callBtn;
@property (nonatomic, weak) IBOutlet UIButton *imeiBtn;
@property (nonatomic, weak) IBOutlet UIButton *setDevicesBtn;
@property (nonatomic, weak) IBOutlet UIButton *getDevicesBtn;
@property (nonatomic, weak) IBOutlet UIButton *automaticBtn;
@property (nonatomic, weak) IBOutlet UIButton *speedBtn;

- (IBAction)buttonPressed:(id)sender;

@end
