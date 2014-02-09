//
//  BWCSettingsViewController.h
//  BrettoWControl
//
//  Created by Jaime on 03/02/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BXCAppDelegate.h"

@interface BXCSettingsViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UITableViewCell *numberCell;
@property (nonatomic, weak) IBOutlet UIButton *contactMe;
@property id <BXCButtonDelegate> delegate;

- (IBAction)buttonPressed:(id)sender;

@end
