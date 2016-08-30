//
//  APIOperationsManager.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionOperation.h"
//Damn it!
#import "ListingCategory.h"
@interface APIOperationsManager : NSObject


//Handles all networking operations
//API Access
@property(nonatomic, strong) NSOperationQueue *operationQueue;
@property(nonatomic, strong) NSMutableArray *operationsArray;
@property(nonatomic, strong) NSError *operationError;


+ (APIOperationsManager*)getSharedInstance;

-(NSArray*) retrieveImagesWithImageIDs: (NSArray*) imageIDs;
//Given an array of ListingCategories, it will generate an array of operations to retrieve the corresponding listings.
-(NSArray*) retrieveCategoriesListings: (NSArray*) listingCategory;
-(NSOperation*) retrieveCategories;
-(NSOperation*) retrieveSearchResultsWithKeyword: (NSString*) keyword;
-(NSOperation*) retrieveSearchResultsWithCategoryID: (NSString*) categoryID;
-(NSOperation*) retrieveListingDetailsWithListingID: (NSString*) listingID;
-(NSOperation*) retrieveImageWithImageID: (NSString*) imageID;



-(void) retrieveDataFromNetworkWithOperations: (NSArray*) operations
                                      success:(void (^)(BOOL operationResult))success
                                      failure: (void (^)(NSError * error)) failure;

-(void) retrieveDataFromNetworkWithOperation: (NSOperation*) operation
                                      success:(void (^)(BOOL operationResult))success
                                      failure: (void (^)(NSError * error)) failure;
@end
