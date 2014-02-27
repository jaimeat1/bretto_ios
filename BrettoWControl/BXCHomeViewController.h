//
//  BWCHomeViewController.h
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BXCAppDelegate.h"

@interface BXCHomeViewController : UIViewController

@property id <BXCButtonDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *assembleOnBtn;
@property (nonatomic, weak) IBOutlet UIButton *assembleOffBtn;
@property (nonatomic, weak) IBOutlet UIButton *climateBtn;
@property (nonatomic, weak) IBOutlet UIButton *engineBtn;
@property (nonatomic, weak) IBOutlet UIButton *ignitionBtn;
@property (nonatomic, weak) IBOutlet UIButton *locationBtn;
@property (nonatomic, weak) IBOutlet UIButton *sensorBtn;
@property (nonatomic, weak) IBOutlet UIButton *bannerBtn;

@property (nonatomic, weak) IBOutlet UIButton *assembleOnBtniPhone5;
@property (nonatomic, weak) IBOutlet UIButton *assembleOffBtniPhone5;
@property (nonatomic, weak) IBOutlet UIButton *climateBtniPhone5;
@property (nonatomic, weak) IBOutlet UIButton *engineBtniPhone5;
@property (nonatomic, weak) IBOutlet UIButton *ignitionBtniPhone5;
@property (nonatomic, weak) IBOutlet UIButton *locationBtniPhone5;
@property (nonatomic, weak) IBOutlet UIButton *sensorBtniPhone5;
@property (nonatomic, weak) IBOutlet UIButton *bannerBtniPhone5;

@property (nonatomic, weak) IBOutlet UIView *viewiPhone;
@property (nonatomic, weak) IBOutlet UIView *viewiPhone5;

- (IBAction)buttonPressed:(id)sender;

@end
