//
//  Category.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListingCategory : NSObject
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* ID;
@property(nonatomic, strong) NSString* detail;
@property(nonatomic, strong) NSArray* listings;

+(ListingCategory*) categoryWithTitle: (NSString*) title withDetail: (NSString*) detail withID: (NSString*) ID;

@end
