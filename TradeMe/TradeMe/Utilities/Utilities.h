//
//  Utilities.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject
+(float) randFloatBetween:(float)low and:(float)high;
+(long) randLongBetween:(long)low and:(long)high;
+(NSString*) dateWithFormat: (NSString*) format withDate: (NSDate*) date;
@end
