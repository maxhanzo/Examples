//
//  Passenger.m
//  Shin Ashiato
//
//  Created by Max Ueda on 8/19/14.
//  Copyright (c) 2014 UedaSoft IT Solutions. All rights reserved.
//

#import "Passenger.h"

@implementation Passenger
@synthesize prefectureName, numberOfImmigrants;
+(Passenger*) passengerWithPrefectureName: (NSString*) prefectureName withNumberOfImmigrants: (NSUInteger) numberOfImmigrants
{
    Passenger *passenger = [[Passenger alloc] init];
    [passenger setPrefectureName: prefectureName];
    [passenger setNumberOfImmigrants: numberOfImmigrants];
    return passenger;
}
@end
