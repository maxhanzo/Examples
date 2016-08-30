//
//  APIOperations.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.


#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "AFHTTPSessionOperation.h"

//Generates the networking operations
@interface APIOperations : NSObject

//https://api.tmsandbox.co.nz/v1/Search/General.json?buy=All&category=0187-&clearance=All&condition=All&expired=false&pay=All&photo_size=Thumbnail&return_metadata=false&rows=20&shipping_method=All&sort_order=Default HTTP/1.1
//Given the category ID, returns the first 20 items
+(NSOperation*) generateListingOperation: (AFHTTPSessionManager *)manager withCategoryID: (NSString*)categoryID;

//https://api.tmsandbox.co.nz/v1/Search/General.json?buy=All&clearance=All&condition=All&expired=false&pay=All&photo_size=Thumbnail&return_metadata=false&rows=20&search_string=lamp&shipping_method=All&sort_order=Default HTTP/1.1
//Given a keyword , returns the first 20 items
+(NSOperation*) generateSearchOperation: (AFHTTPSessionManager *)manager withKeyword: (NSString*)keyword;
//https://api.tmsandbox.co.nz/v1/Listings/4799154.json?increment_view_count=false&return_member_profile=false HTTP/1.1
//Given an ID, returns the listing details
+(NSOperation*) generateListingDetailOperation: (AFHTTPSessionManager *)manager withListingID: (NSString*)listingID;
//Returns all categories
//http://api.tmsandbox.co.nz/v1/Categories.json
+(NSOperation*) generateCategoryOperation: (AFHTTPSessionManager *)manager;


//https://images.tmsandbox.co.nz/photoserver/thumb/892412.jpg
//Given a listing ID, returns its thumbnail
+(NSOperation*) generateThumbnailOperation: (AFHTTPSessionManager *)manager withImageID: (NSString*)imageID;

@end
