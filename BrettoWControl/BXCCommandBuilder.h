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
extern NSInteger const BWCCommandClimateOn;
extern NSInteger const BWCCommandClimateOff;
extern NSInteger const BWCCommandEngineOn;
extern NSInteger const BWCCommandEngineOff;
extern NSInteger const BWCCommandIgnitionOn;
extern NSInteger const BWCCommandIgnitionOff;
extern NSInteger const BWCCommandLocationGPRMC;
extern NSInteger const BWCCommandLocationGPSD;
extern NSInteger const BWCCommandLocationDDMMSS;
extern NSInteger const BWCCommandLocationParking;
extern NSInteger const BWCCommandLocationWeb;
extern NSInteger const BWCCommandSensorOn;
extern NSInteger const BWCCommandSensorOff;
extern NSInteger const BWCCommandCall;
extern NSInteger const BWCCommandImei;
extern NSInteger const BWCCommandSetDevices;
extern NSInteger const BWCCommandGetDevices;
extern NSInteger const BWCCommandAutomaticOn;
extern NSInteger const BWCCommandAutomaticOff;
extern NSInteger const BWCCommandSpeedOn;
extern NSInteger const BWCCommandSpeedOff;
extern NSInteger const BWCCommandState;
extern NSInteger const BWCCommandReset;
extern NSInteger const BWCCommandHardReset;
extern NSInteger const BWCCommandPassword;

@interface BXCCommandBuilder : NSObject

/**
 Builds a complete text with a command and its parameters to be send by SMS
 @param command command to send
 @param parameters list of parameter for that command. Fixed positions: 0 alarm password; 1 and following, command parameters.
 */
+ (NSString *)buildCommand:(NSInteger)command withParameters:(NSArray *)parameters;

@end
