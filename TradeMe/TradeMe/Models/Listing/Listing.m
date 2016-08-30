//
//  Listing.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "Listing.h"


@implementation Listing

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init])
    {
        self.title =  [decoder decodeObjectForKey:@"title"] ;
        self.ID = [decoder decodeObjectForKey:@"ID"];
        self.imageFileName = [decoder decodeObjectForKey: @"imageFileName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject: self.title forKey:@"title"] ;
    [encoder encodeObject: self.ID forKey:@"ID"];
    [encoder encodeObject: self.imageFileName forKey:@"imageFileName"];
}

//Listing from "raw" data
/*
 {
 "ListingId": 4799154,
 "Title": "Junk Troll 39 J1 B1",
 "Category": "0187-2192-2678-6493-",
 "StartPrice": 1.12,
 "BuyNowPrice": 12.01,
 "StartDate": "/Date(1472094314710)/",
 "EndDate": "/Date(1472526314710)/",
 "ListingLength": null,
 "HasGallery": true,
 "AsAt": "/Date(1472517629441)/",
 "CategoryPath": "/Antiques-collectables/Art-deco-retro/Home-décor/Lamps-lightshades",
 "PictureHref": "https://images.tmsandbox.co.nz/photoserver/thumb/892412.jpg",
 "IsNew": true,
 "Region": "Canterbury",
 "Suburb": "Christchurch City",
 "HasReserve": true,
 "HasBuyNow": true,
 "NoteDate": "/Date(0)/",
 "ReserveState": 2,
 "Subtitle": "Junk39-B-001 1 - F5d",
 "PriceDisplay": "$1.12"
 }*/
+(Listing *)listingFromJSON:(NSDictionary *)json
{
    NSString *title = [json objectForKey: @"Title"];
    NSString *ID = [NSString stringWithFormat: @"%li", (long) [[json objectForKey: @"ListingId"] integerValue]];
    
    NSString *strImageName = [json objectForKey: @"PictureHref"];
    NSCharacterSet *unwantedCharacterSetImageName = [NSCharacterSet characterSetWithCharactersInString:@"https://images.tmsandbox.co.nz/photoserver/thumb/.jpg"];
    strImageName = [[strImageName componentsSeparatedByCharactersInSet: unwantedCharacterSetImageName] componentsJoinedByString:@""];
    if([strImageName isEqualToString:@""])
    {
        NSLog(@"HEY");
    }
    
    return [Listing listingWithTitle:title  withID:ID  withImageFileName:strImageName];

}

+(Listing*) listingWithTitle: (NSString*) title withID: (NSString*) ID withImageFileName: (NSString*) imageFileName{
    Listing *myListing = [[Listing alloc] init];
    [myListing setTitle: title];
    [myListing setID: ID];
    [myListing setImageFileName: imageFileName];
    
    return myListing;
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
        
        else if ([key isEqualToString:@"imageFileName"])
        {
            return self.imageFileName;
        }
    }
    return nil;
}


@end
