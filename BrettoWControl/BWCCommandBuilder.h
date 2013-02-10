//
//  BWCCommandBuilder.h
//  BrettoWControl
//
//  Created by Jaime on 26/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSInteger const BWCCommandAssembleOn;
extern NSInteger const BWCCommandAssembleOff;
extern NSInteger const BWCCommandImmobilizeOn;
extern NSInteger const BWCCommandImmobilizeOff;
extern NSInteger const BWCCommandSensorOn;
extern NSInteger const BWCCommandSensorOff;
extern NSInteger const BWCCommandLocationWeb;
extern NSInteger const BWCCommandLocationGPRMC;
extern NSInteger const BWCCommandLocationGPSD;
extern NSInteger const BWCCommandSirenOn;
extern NSInteger const BWCCommandSirenOff;
extern NSInteger const BWCCommandSaveOn;
extern NSInteger const BWCCommandSaveOff;
extern NSInteger const BWCCommandCall;
extern NSInteger const BWCCommandImei;
extern NSInteger const BWCCommandReset;
extern NSInteger const BWCCommandHardReset;
extern NSInteger const BWCCommandSetDevices;
extern NSInteger const BWCCommandGetDevices;
extern NSInteger const BWCCommandPassword;
extern NSInteger const BWCCommandSensibility;
extern NSInteger const BWCCommandState;

@interface BWCCommandBuilder : NSObject

/**
 Builds a complete text with a command and its parameters to be send by SMS
 @param command command to send
 @param parameters list of parameter for that command. Fixed positions: 0 alarm password; 1 and following, command parameters.
 */
+ (NSString *)buildCommand:(NSInteger)command withParameters:(NSArray *)parameters;

@end
