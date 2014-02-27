//
//  BWCAppDelegate.h
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BXCButtonDelegate <NSObject>

@required
- (void)commandPressed:(NSString *)command;

@end

@interface BXCAppDelegate : UIResponder <UIApplicationDelegate, BXCButtonDelegate, UIActionSheetDelegate, UITabBarControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIWindow *window;
/** Command in process */
@property (nonatomic, copy) NSString* currentCommand;

- (void)composeMessage:(NSString *)message;

@end
