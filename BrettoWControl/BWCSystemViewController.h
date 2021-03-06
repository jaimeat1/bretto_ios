//
//  BWCSystemViewController.h
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BWCAppDelegate.h"

@interface BWCSystemViewController : UIViewController

@property id <BWCButtonDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIButton *stateBtn;
@property (nonatomic, weak) IBOutlet UIButton *softResetBtn;
@property (nonatomic, weak) IBOutlet UIButton *hardResetBtn;

- (IBAction)buttonPressed:(id)sender;

@end
