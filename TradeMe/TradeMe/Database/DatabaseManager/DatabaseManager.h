//
//  DatabaseManager.h
//  App Rede
//
//  Created by Ticket Services on 5/12/16.
//  Copyright © 2016 Ticket Serviços. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "Listing.h"
#import "ListingCategory.h"
#import "ListingDetails.h"


@interface DatabaseManager : NSObject
//Handles database operations.



#pragma mark - Retrieval

+(NSArray*) retrieveListingsWithCategoryID: (NSString*) categoryID;
+(Listing*) retrieveListingWithID: (NSString*) listingID;
+(NSData*) retrieveImageDataWithID: (NSString*) imageID;
+(NSArray*) retrieveListingCategories;
+(ListingDetails*) retrieveListingsDetailsWithID: (NSString*) listingID;

//
//#pragma mark - Insertion
+(BOOL) insertListings: (NSArray*) listings withCategoryID: (NSString*) categoryID;
+(BOOL) insertListingCategoriesFromJSON:(NSArray *)listingCategories;
+(BOOL) insertImage: (NSString*) imageID withData: (NSData*) imageData;
+(BOOL) insertListingCategory: (ListingCategory*) listingCategory;
+(BOOL) insertListingDetails: (ListingDetails*) listingDetails;


//
//#pragma mark - Delete
+(BOOL) deleteListings;
+(BOOL) deleteImages;
+(BOOL) deleteListingCategories;
+(BOOL) deleteListingDetails;
+(BOOL) deleteAllData;
//

//
#pragma mark - Utils
+(NSString*) getDatabasePath;

@end

