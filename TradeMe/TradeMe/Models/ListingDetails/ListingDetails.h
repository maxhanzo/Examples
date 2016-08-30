//
//  ListingDetails.h
//  TradeMe
//
//  Created by Max Ueda on 8/29/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListingDetails : NSObject
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* ID;
@property(nonatomic, strong) NSString* detail;
+(ListingDetails*)listingFromJSON:(NSDictionary *)json;
+(ListingDetails*) listingDetailsWithTitle: (NSString*) title withID: (NSString*) ID withDetail: (NSString*) detail;
@end
