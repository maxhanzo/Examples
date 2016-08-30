//
//  Listing.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Listing : NSObject
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* ID;
@property(nonatomic, strong) NSString* imageFileName;




+(Listing*) listingWithTitle: (NSString*) title withID: (NSString*) ID withImageFileName: (NSString*) imageFileName;
//Some requests wrappers already return JSON as NSDictionary.
//+(Listing*) listingFromJSON: (NSData*) json;
+(Listing*) listingFromJSON: (NSDictionary*) json;


@end
