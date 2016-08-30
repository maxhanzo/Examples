//
//  DatabaseManager.m
//  App Rede
//
//  Created by Ticket Services on 5/12/16.
//  Copyright © 2016 Ticket Serviços. All rights reserved.
//

#import <objc/runtime.h>
#import "DatabaseManager.h"
#define DB_NAME @"TradeMe.db"

@implementation DatabaseManager


#pragma mark - Retrieval

+(NSArray*) retrieveListingCategories{
    
    NSString *databasePath = [DatabaseManager getDatabasePath];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSString *query =  [NSString stringWithFormat:  @"SELECT ID, Title, Detail FROM ListingCategory"];
    FMResultSet *results = [db executeQuery:query];
    
    NSMutableArray* listingCategories = [NSMutableArray array];
    
    while([results next])
    {
        NSString* categoryID = [results stringForColumn: @"ID"];
        NSString* categoryTitle = [results stringForColumn: @"Title"];
        NSString* categoryDetail = [results stringForColumn: @"Detail"];
        [listingCategories addObject: [ListingCategory categoryWithTitle:categoryTitle withDetail:categoryDetail withID:categoryID]];
    }
    [db close];
    
    //Sorting categories by title (alphabetically)
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    NSArray *sortedArray =[listingCategories sortedArrayUsingDescriptors:@[sort]];
    return sortedArray;
}

//Not sure if this will be needed, but anyway...
+(Listing*) retrieveListingWithID: (NSString*) listingID
{
    NSString *databasePath = [DatabaseManager getDatabasePath];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSString *query =  [NSString stringWithFormat:  @"SELECT ID, Title, ImageFileName FROM Listing WHERE listingID = %@", listingID];
    FMResultSet *results = [db executeQuery:query];
    
    Listing* listing;
    while([results next])
    {
        NSString* listingID = [results stringForColumn: @"ID"];
        NSString* listingTitle = [results stringForColumn: @"Title"];
        NSString* listingImageFileName = [results stringForColumn: @"imageFileName"];
        listing =  [Listing listingWithTitle: listingTitle withID:listingID withImageFileName:listingImageFileName];
    }
    [db close];
    
    return listing;
}

+(NSArray*) retrieveListingsWithCategoryID: (NSString*) categoryID{
    NSString *databasePath = [DatabaseManager getDatabasePath];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSString *query =  [NSString stringWithFormat:  @"SELECT ID, Title, ImageFileName FROM Listing WHERE CategoryID = \"%@\"", categoryID];
    FMResultSet *results = [db executeQuery:query];
    
    NSMutableArray* listings = [NSMutableArray array];
    
    while([results next])
    {
        NSString* listingID = [results stringForColumn: @"ID"];
        NSString* listingTitle = [results stringForColumn: @"Title"];
        NSString* listingImageFileName = [results stringForColumn: @"imageFileName"];
        [listings addObject: [Listing listingWithTitle: listingTitle withID:listingID withImageFileName:listingImageFileName]];
    }
    [db close];
    
    //Sorting listings by ID
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"ID" ascending:YES];
    NSArray *sortedArray =[listings sortedArrayUsingDescriptors:@[sort]];
    return sortedArray;
}

+(ListingDetails*) retrieveListingsDetailsWithID: (NSString*) listingID{
    NSString *databasePath = [DatabaseManager getDatabasePath];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSString *query =  [NSString stringWithFormat:  @"SELECT ID, title, detail FROM ListingDetail WHERE ID = \"%@\"", listingID];
    FMResultSet *results = [db executeQuery:query];
    
    ListingDetails* listingDetails;
    
    while([results next])
    {
        NSString* listingID = [results stringForColumn: @"ID"];
        NSString* listingTitle = [results stringForColumn: @"Title"];
        NSString* listingDetail = [results stringForColumn: @"detail"];
        listingDetails = [ListingDetails listingDetailsWithTitle:listingTitle withID:listingID withDetail:listingDetail];
    
    }
    [db close];
    return listingDetails;
    
}

+(NSData*) retrieveImageDataWithID: (NSString*) imageID{
    NSString *databasePath = [DatabaseManager getDatabasePath];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databasePath];
    [db open];
    NSString *query =  [NSString stringWithFormat:  @"SELECT data FROM listingImage WHERE ID = \"%@\"", imageID];
    FMResultSet *results = [db executeQuery:query];
    
    
    NSData *imageData = nil;
    
    while([results next])
    {
        imageData = [results dataForColumn: @"data"];
    }
    [db close];
    return imageData;

}



#pragma mark - Insertion
//Inserts Listing Category from "raw" data
+(BOOL) insertListingCategoriesFromJSON:(NSArray *)listingCategories
{
    for (NSDictionary *subcategory in listingCategories){
    
        NSString *categoryName = [subcategory objectForKey: @"Name"];
        NSString *categoryID = [subcategory objectForKey: @"Number"];
        NSString *categoryDetails = [subcategory objectForKey: @"Path"];
        ListingCategory* listingCategory = [ListingCategory categoryWithTitle:categoryName withDetail:categoryDetails withID:categoryID];
        if(![DatabaseManager insertListingCategory: listingCategory])
        {
            return NO;
        }
    }
    return YES;
}

//Inserts Listings from "raw" data
+(BOOL) insertListings: (NSArray*) listings withCategoryID: (NSString*) categoryID;
{
    if([listings count]>0){
        for (NSDictionary *listing in listings)
        {
            Listing *myListing = [Listing listingFromJSON:listing];
            [DatabaseManager insertListing:myListing withCategoryID:categoryID];
        }
        return YES;
    }
    return NO;
}

+(BOOL) insertListing: (Listing*) listing withCategoryID: (NSString*) categoryID
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    [db open];
    BOOL success =  [db executeUpdate:@"INSERT INTO Listing('ID', 'categoryID', 'title', 'imageFileName') VALUES (?, ?, ?, ?);",
                     listing.ID, categoryID, listing.title, listing.imageFileName,nil];
    [db close];
    return success;
}

+(BOOL) insertListingDetails: (ListingDetails*) listingDetails
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    [db open];
    BOOL success =  [db executeUpdate:@"INSERT INTO ListingDetail('ID', 'title', 'detail') VALUES (?, ?, ?);",
                     listingDetails.ID, listingDetails.title, listingDetails.detail ,nil];
    [db close];
    return success;
}

+(BOOL) insertImage: (NSString*) imageID withData: (NSData*) imageData
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    [db open];
    BOOL success =  [db executeUpdate:@"INSERT INTO listingImage('ID', 'data') VALUES (?, ?);",
                     imageID, imageData, nil];
    [db close];
    return success;
}

+(BOOL) insertListingCategory: (ListingCategory*) listingCategory
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    [db open];
    BOOL success =  [db executeUpdate:@"INSERT INTO ListingCategory('ID', 'title', 'detail') VALUES (?, ?, ?);",
                     listingCategory.ID, listingCategory.title, listingCategory.detail, nil];
    [db close];
    return success;
}


#pragma mark - Delete

+(BOOL) deleteListings
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"DELETE FROM Listing;"];
    
    [db close];
    
    return success;
}
+(BOOL) deleteImages
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"DELETE FROM listingImage;"];
    
    [db close];
    
    return success;
}
+(BOOL) deleteListingCategories
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"DELETE FROM ListingCategory;"];
    
    [db close];
    
    return success;
}
+(BOOL) deleteListingDetails
{
    FMDatabase *db = [FMDatabase databaseWithPath:[DatabaseManager getDatabasePath]];
    
    [db open];
    
    BOOL success =  [db executeUpdate:@"DELETE FROM ListingDetail;"];
    
    [db close];
    
    return success;
}

+(BOOL) deleteAllData
{
    BOOL success;
    success = [DatabaseManager deleteImages];
    success = [DatabaseManager deleteListings];
    success = [DatabaseManager deleteListingDetails];
    success = [DatabaseManager deleteListingCategories];
    return success;
}

#pragma mark - Utils
+(NSString*) getDatabasePath
{
    NSString *homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    homeDir = [homeDir stringByAppendingPathComponent:DB_NAME];
    return homeDir;
}


@end

