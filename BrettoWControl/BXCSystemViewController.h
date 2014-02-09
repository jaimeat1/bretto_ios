//
//  BWCSystemViewController.h
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BXCAppDelegate.h"

@interface BXCSystemViewController : UIViewController

@property id <BXCButtonDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *stateBtn;
@property (nonatomic, weak) IBOutlet UIButton *softResetBtn;
@property (nonatomic, weak) IBOutlet UIButton *hardResetBtn;

- (IBAction)buttonPressed:(id)sender;

@end
