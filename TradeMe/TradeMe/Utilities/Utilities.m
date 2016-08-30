//
//  Utilities.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+(float) randFloatBetween:(float)low and:(float)high
{
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}

+(long) randLongBetween:(long)low and:(long)high
{
    float diff = high - low;
    return (((long) rand() / RAND_MAX) * diff) + low;
}


+(NSString*) dateWithFormat: (NSString*) format withDate: (NSDate*) date
{
    if(date)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:format];
        return [dateFormatter stringFromDate: date ];
    }
    return nil;
    
}

@end
