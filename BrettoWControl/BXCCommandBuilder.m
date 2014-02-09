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
NSInteger const BWCCommandImmobilizeOn = 2;
NSInteger const BWCCommandImmobilizeOff = 3;
NSInteger const BWCCommandSensorOn = 4;
NSInteger const BWCCommandSensorOff = 5;
NSInteger const BWCCommandLocationWeb = 6;
NSInteger const BWCCommandLocationGPRMC = 7;
NSInteger const BWCCommandLocationGPSD = 8;
NSInteger const BWCCommandSirenOn = 9;
NSInteger const BWCCommandSirenOff = 10;
NSInteger const BWCCommandSaveOn = 11;
NSInteger const BWCCommandSaveOff = 12;
NSInteger const BWCCommandCall = 13;
NSInteger const BWCCommandImei = 14;
NSInteger const BWCCommandReset = 15;
NSInteger const BWCCommandHardReset = 16;
NSInteger const BWCCommandSetDevices = 17;
NSInteger const BWCCommandGetDevices = 18;
NSInteger const BWCCommandPassword = 19;
NSInteger const BWCCommandSensibility = 20;
NSInteger const BWCCommandState = 21;

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
        case BWCCommandImmobilizeOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"K#"];
            break;
        case BWCCommandImmobilizeOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"STOP#"];
            break;
        case BWCCommandSensorOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"H#"];
            break;
        case BWCCommandSensorOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"N#"];
            break;
        case BWCCommandLocationWeb:
            message = [NSString stringWithFormat:@"%@%@", message, @"P#"];
            break;
        case BWCCommandLocationGPRMC:
            message = [NSString stringWithFormat:@"%@%@", message, @"GPS#"];
            break;
        case BWCCommandLocationGPSD:
            message = [NSString stringWithFormat:@"%@%@", message, @"GPSD#"];
            break;
        case BWCCommandSirenOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"SIRENON#"];
            break;
        case BWCCommandSirenOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"SIRENOFF#"];
            break;
        case BWCCommandSaveOn:
            message = [NSString stringWithFormat:@"%@%@", message, @"SL*O#"];
            break;
        case BWCCommandSaveOff:
            message = [NSString stringWithFormat:@"%@%@", message, @"SL*C#"];
            break;
        case BWCCommandCall:
            message = [NSString stringWithFormat:@"%@%@%@#", message, @"VM", [parameters objectAtIndex:1]];
            break;
        case BWCCommandImei:
            message = [NSString stringWithFormat:@"%@%@", message, @"IMEI#"];
            break;
        case BWCCommandReset:
            message = [NSString stringWithFormat:@"%@%@", message, @"Z#"];
            break;
        case BWCCommandHardReset:
            message = [NSString stringWithFormat:@"%@%@", message, @"V#"];
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
        case BWCCommandPassword:
            message = [NSString stringWithFormat:@"%@E%@#", message, [parameters objectAtIndex:1]];
            break;
        case BWCCommandSensibility:
            message = [NSString stringWithFormat:@"%@VS*%@#", message, [parameters objectAtIndex:1]];
            break;
        case BWCCommandState:
            message = [NSString stringWithFormat:@"%@%@", message, @"X#"];
            break;
        default:
            message = nil;
            break;
    }
    
    DLog(@"%@", message);
    
    return message;
}

@end
