//
//  BWCSettingsViewController.h
//  BrettoWControl
//
//  Created by Jaime on 03/02/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BWCAppDelegate.h"

@interface BWCSettingsViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UITableViewCell *numberCell;
@property (nonatomic, weak) IBOutlet UIButton *contactMe;
@property id <BWCButtonDelegate> delegate;

- (IBAction)buttonPressed:(id)sender;

@end
