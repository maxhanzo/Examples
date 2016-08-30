//
//  ListingDetails.m
//  TradeMe
//
//  Created by Max Ueda on 8/29/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ListingDetails.h"

@implementation ListingDetails
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self.title =  [decoder decodeObjectForKey:@"title"] ;
        self.ID = [decoder decodeObjectForKey:@"ID"];
        self.detail = [decoder decodeObjectForKey: @"detail"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject: self.title forKey:@"title"] ;
    [encoder encodeObject: self.ID forKey:@"ID"];
    [encoder encodeObject: self.detail forKey:@"detail"];
}

+(ListingDetails*)listingFromJSON:(NSDictionary *)json
{
    NSString *title = [json objectForKey: @"Title"];
    NSString *ID = [NSString stringWithFormat: @"%li", (long) [[json objectForKey: @"ListingId"] integerValue]];
    
    NSString *detail = [json objectForKey: @"Body"];

    
    return [ListingDetails listingDetailsWithTitle:title  withID:ID  withDetail:detail];
    
}

+(ListingDetails*) listingDetailsWithTitle: (NSString*) title withID: (NSString*) ID withDetail: (NSString*) detail{
    ListingDetails *myListingDetail = [[ListingDetails alloc] init];
    [myListingDetail setTitle: title];
    [myListingDetail setID: ID];
    [myListingDetail setDetail: detail];
    
    return myListingDetail;
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
    }
    return nil;
}


@end
