//
//  BWCAppDelegate.h
//  BrettoWControl
//
//  Created by Jaime on 13/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BWCButtonDelegate <NSObject>

@required
- (void)buttonPressed:(id)sender;

@end

@interface BWCAppDelegate : UIResponder <UIApplicationDelegate, BWCButtonDelegate, UIActionSheetDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
/** Command in process */
@property (nonatomic, copy) NSString* currentCommand;

- (void)composeMessage:(NSString *)message;

@end
