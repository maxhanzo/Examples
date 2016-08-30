//
//  Category.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ListingCategory.h"

@implementation ListingCategory
+(ListingCategory*) categoryWithTitle: (NSString*) title withDetail: (NSString*) detail withID: (NSString*) ID
{
    ListingCategory *myCategory = [[ListingCategory alloc] init];
    [myCategory setTitle: title];
    [myCategory setDetail: detail];
    [myCategory setID: ID];

    return myCategory;
}

//Key Value Coding: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/KeyValueCoding/Articles/KeyValueCoding.html
-(id) valueForKey:(NSString *)key
{
    if(key)
    {
        if ([key isEqualToString: @"title"])
        {
            return self.title;
        }
        
        else if([key isEqualToString: @"ID"])
        {
            return self.ID;
        }
        
        else if ([key isEqualToString:@"detail"])
        {
            return self.detail;
        }
        
        else if ([key isEqualToString:@"listings"])
        {
            return self.listings;
        }
    }
    return nil;
}

@end
