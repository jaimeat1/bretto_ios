//
//  BWCPasswordViewController.h
//  BrettoWControl
//
//  Created by Jaime on 17/02/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXCPasswordViewController : UITableViewController

@property (nonatomic) bool isAppPassword;

@property (nonatomic, weak) IBOutlet UITextField* oldPassword;
@property (nonatomic, weak) IBOutlet UITextField* theNewPassword;
@property (nonatomic, weak) IBOutlet UITextField* repeatPassword;

@end
