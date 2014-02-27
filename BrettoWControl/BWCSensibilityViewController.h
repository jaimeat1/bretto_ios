//
//  BWCSensibilityViewController.h
//  BrettoWControl
//
//  Created by Jaime on 02/03/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWCSensibilityViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UISlider *slider;

- (IBAction)sliderValueChanged:(UISlider *)slider;

@end
