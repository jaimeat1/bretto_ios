//
//  BWCCommandBuilder.m
//  BrettoWControl
//
//  Created by Jaime on 26/01/13.
//  Copyright (c) 2013 MobiOak. All rights reserved.
//

#import "BXCCommandBuilder.h"

NSInteger const BWCCommandAssembleOn = 0;
NSInteger const BWCCommandAssembleOff = 1;
NSInteger const BWCCommandClimateOn = 2;
NSInteger const BWCCommandClimateOff = 3;
NSInteger const BWCCommandEngineOn = 4;
NSInteger const BWCCommandEngineOff = 5;
NSInteger const BWCCommandIgnitionOn = 6;
NSInteger const BWCCommandIgnitionOff = 7;
NSInteger const BWCCommandLocationGPRMC = 8;
NSInteger const BWCCommandLocationGPSD = 9;
NSInteger const BWCCommandLocationDDMMSS = 10;
NSInteger const BWCCommandLocationParking = 11;
NSInteger const BWCCommandLocationWeb = 12;
NSInteger const BWCCommandSensorOn = 13;
NSInteger const BWCCommandSensorOff = 14;
NSInteger const BWCCommandCall = 15;
NSInteger const BWCCommandImei = 16;
NSInteger const BWCCommandSetDevices = 17;
NSInteger const BWCCommandGetDevices = 18;
NSInteger const BWCCommandAutomaticOn= 19;
NSInteger const BWCCommandAutomaticOff= 20;
NSInteger const BWCCommandSpeedOn = 21;
NSInteger const BWCCommandSpeedOff = 22;
NSInteger const BWCCommandState = 23;
NSInteger const BWCCommandReset = 24;
NSInteger const BWCCommandHardReset = 25;
NSInteger const BWCCommandPassword = 26;

@implementation BXCCommandBuilder

+ (NSString *)buildCommand:(NSInteger)command withParameters:(NSArray *)parameters
{
    DLog(@"command %d", command);
    
    // Concat 
    NSString* message = [NSString stringWithFormat:@"*%@*", [parameters objectAtIndex:0]];

    // Concat command code and its parameters
    switch (command) {
        case BWCCommandAssembleOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"S#"];
            break;
        case BWCCommandAssembleOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"C#"];
            break;
        case BWCCommandClimateOn:
            message = [NSString stringWithFormat:@"%@%@ %@#", message, @"air start", [parameters objectAtIndex:1]];
            break;
        case BWCCommandClimateOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"air off#"];
            break;
        case BWCCommandEngineOn:
            message = [NSString stringWithFormat:@"%@%@ %@#", message, @"engine start", [parameters objectAtIndex:1]];
            break;
        case BWCCommandEngineOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"engine off#"];
            break;
        case BWCCommandIgnitionOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"K#"];
            // TODO: right?
            break;
        case BWCCommandIgnitionOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"STOP#"];
            // TODO: right?
            break;
        case BWCCommandLocationGPRMC:
            message = [NSString stringWithFormat:@"%@%@", message, @"GPS#"];
            break;
        case BWCCommandLocationGPSD:
            message = [NSString stringWithFormat:@"%@%@", message, @"GPSD#"];
            break;
        case BWCCommandLocationDDMMSS:
            message = [NSString stringWithFormat:@"%@%@", message, @"GPSM#"];
            break;
        case BWCCommandLocationParking:
            message = [NSString stringWithFormat:@"%@%@", message, @"T#"];
            break;
        case BWCCommandLocationWeb:
            message = [NSString stringWithFormat:@"%@%@", message, @"GPSW#"];
            break;
        case BWCCommandSensorOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"H#"];
            break;
        case BWCCommandSensorOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"N#"];
            break;
        case BWCCommandCall:
            message = [NSString stringWithFormat:@"%@%@%@#", message, @"VM", [parameters objectAtIndex:1]];
            break;
        case BWCCommandImei:
            message = [NSString stringWithFormat:@"%@%@", message, @"IMEI#"];
            break;
        case BWCCommandSetDevices:
            // Concat add parameters
            switch (parameters.count) {
                case 2:
                    message = [NSString stringWithFormat:@"%@A%@#", message,
                               [parameters objectAtIndex:1]];
                    break;
                case 3:
                    message = [NSString stringWithFormat:@"%@A%@*B%@#", message,
                               [parameters objectAtIndex:1],
                               [parameters objectAtIndex:2]];
                    break;
                case 4:
                    message = [NSString stringWithFormat:@"%@A%@*B%@*C%@#", message,
                               [parameters objectAtIndex:1],
                               [parameters objectAtIndex:2],
                               [parameters objectAtIndex:3]];
                    break;
                default:
                    break;
            }
            break;
        case BWCCommandGetDevices:
            message = [NSString stringWithFormat:@"%@%@", message, @"YY#"];
            break;
        case BWCCommandAutomaticOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"Aon#"];
            break;
        case BWCCommandAutomaticOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"Aoff#"];
            break;
        case BWCCommandSpeedOn:
            message = [NSString stringWithFormat:@"%@%@%@,%@#",
                       message,
                       @"SPD",
                       [parameters objectAtIndex:1],
                       [parameters objectAtIndex:2]];
            break;
        case BWCCommandSpeedOff:
            // TODO:
            break;
        case BWCCommandState:
            message = [NSString stringWithFormat:@"%@%@", message, @"X#"];
            break;
        case BWCCommandReset:
            message = [NSString stringWithFormat:@"%@%@", message, @"Z#"];
            break;
        case BWCCommandHardReset:
            message = [NSString stringWithFormat:@"%@%@", message, @"V#"];
            break;
        case BWCCommandPassword:
            message = [NSString stringWithFormat:@"%@E%@#", message, [parameters objectAtIndex:1]];
            break;
        default:
            message = nil;
            break;
    }
    
    DLog(@"%@", message);
    
    return message;
}

@end
