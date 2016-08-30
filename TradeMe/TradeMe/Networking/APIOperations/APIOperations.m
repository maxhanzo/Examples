//
//  APIOperations.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.


#import "APIOperations.h"
#import "APIOperationsManager.h"
#import "DatabaseManager.h"

//Generates the networking operations
@implementation APIOperations

//TODO: Error handling
//TODO: Move keys to config file.
//TODO: Move URIs to config file

#define CONSUMER_KEY @"A1AC63F0332A131A78FAC304D007E7D1"
#define CONSUMER_SECRET @"EC7F18B17A062962C6930A8AE88B16C7"
#define OAUTH_SIGNATURE_METHOD @"PLAINTEXT"
#define SANDBOXURI @"api.tmsandbox.co.nz"
#define IMAGES_SANDBOXURI @"images.tmsandbox.co.nz"
#define MOCKUPURI @"localhost:8045"

#pragma mark - Class methods


//https://api.tmsandbox.co.nz/v1/Search/General.json?buy=All&category=0187-&clearance=All&condition=All&expired=false&pay=All&photo_size=Thumbnail&return_metadata=false&rows=20&shipping_method=All&sort_order=Default HTTP/1.1
//Given the category ID, returns the first 20 items
+(NSOperation*) generateListingOperation: (AFHTTPSessionManager *)manager withCategoryID: (NSString*)categoryID
{
    NSString* apiURL = [NSString stringWithFormat: @"https://%@/v1/Search/General.json?buy=All&category=%@&clearance=All&condition=All&expired=false&pay=All&photo_size=Thumbnail&return_metadata=false&rows=20&shipping_method=All&sort_order=Default HTTP/1.1", SANDBOXURI, categoryID];
    apiURL = [apiURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSLog(@"Generated URL: %@", apiURL);
    
    
    APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
    [apiOperationsManager setOperationError:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat: @"OAuth oauth_consumer_key=\"%@\", oauth_signature_method=\"%@\", oauth_signature=\"%@&\"", CONSUMER_KEY, OAUTH_SIGNATURE_METHOD, CONSUMER_SECRET] forHTTPHeaderField:@"Authorization"];
    
    NSOperation *operation = [AFHTTPSessionOperation operationWithManager:manager HTTPMethod:@"GET" URLString:apiURL parameters:nil uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON ListingOperation SUCCESSFUL: %@", responseObject);
        NSArray* listings = [responseObject objectForKey: @"List"];
        if([listings count]>0)
        {
            [DatabaseManager insertListings:listings withCategoryID:categoryID];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        //Gotta think of a better way
        [apiOperationsManager setOperationError:error];
        NSLog(@"Error: %@", error);
    }];
    
    return operation;
    
}

//https://api.tmsandbox.co.nz/v1/Search/General.json?buy=All&clearance=All&condition=All&expired=false&pay=All&photo_size=Thumbnail&return_metadata=false&rows=20&search_string=lamp&shipping_method=All&sort_order=Default HTTP/1.1
//Given a keyword , returns the first 20 items
+(NSOperation*) generateSearchOperation: (AFHTTPSessionManager *)manager withKeyword: (NSString*)keyword
{
    NSString* apiURL = [NSString stringWithFormat: @"https://%@/v1/Search/General.json?buy=All&clearance=All&condition=All&expired=false&pay=All&photo_size=Thumbnail&return_metadata=false&rows=20&search_string=%@&shipping_method=All&sort_order=Default HTTP/1.1", SANDBOXURI, keyword];
    
    apiURL = [apiURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSLog(@"Generated URL: %@", apiURL);
    
    
    APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
    [apiOperationsManager setOperationError:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat: @"OAuth oauth_consumer_key=\"%@\", oauth_signature_method=\"%@\", oauth_signature=\"%@&\"", CONSUMER_KEY, OAUTH_SIGNATURE_METHOD, CONSUMER_SECRET] forHTTPHeaderField:@"Authorization"];
    
    NSOperation *operation = [AFHTTPSessionOperation operationWithManager:manager HTTPMethod:@"GET" URLString:apiURL parameters:nil uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON SearchOperation SUCCESSFUL: %@", responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [apiOperationsManager setOperationError:error];
        NSLog(@"Error: %@", error);
    }];
    
    return operation;
    
}

//https://api.tmsandbox.co.nz/v1/Listings/4799154.json?increment_view_count=false&return_member_profile=false HTTP/1.1
//Given an ID, returns the listing details
+(NSOperation*) generateListingDetailOperation: (AFHTTPSessionManager *)manager withListingID: (NSString*)listingID
{
    NSString* apiURL = [NSString stringWithFormat: @"https://%@/v1/Listings/%@.json?increment_view_count=false&return_member_profile=false HTTP/1.1", SANDBOXURI, listingID];
    
    apiURL = [apiURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSLog(@"Generated URL: %@", apiURL);
    
    
    APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
    [apiOperationsManager setOperationError:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat: @"OAuth oauth_consumer_key=\"%@\", oauth_signature_method=\"%@\", oauth_signature=\"%@&\"", CONSUMER_KEY, OAUTH_SIGNATURE_METHOD, CONSUMER_SECRET] forHTTPHeaderField:@"Authorization"];
    
    NSOperation *operation = [AFHTTPSessionOperation operationWithManager:manager HTTPMethod:@"GET" URLString:apiURL parameters:nil uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON ListingDetailOperation SUCCESSFUL: %@", responseObject);
        ListingDetails* listingDetails = [ListingDetails listingFromJSON:responseObject];
        [DatabaseManager insertListingDetails: listingDetails];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [apiOperationsManager setOperationError:error];
        NSLog(@"Error: %@", error);
    }];
    
    return operation;
    
}

//Returns all categories
//http://api.tmsandbox.co.nz/v1/Categories.json
+(NSOperation*) generateCategoryOperation: (AFHTTPSessionManager *)manager
{
    NSString* apiURL = [NSString stringWithFormat: @"https://%@/v1/Categories.json", SANDBOXURI];
    apiURL = [apiURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSLog(@"Generated URL: %@", apiURL);

    
    APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
    [apiOperationsManager setOperationError:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSOperation *operation = [AFHTTPSessionOperation operationWithManager:manager HTTPMethod:@"GET" URLString:apiURL parameters:nil uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"JSON CategoryOperation SUCCESSFUL: %@", responseObject);
        NSArray *subcategories =  [responseObject objectForKey: @"Subcategories"];
        
        if(subcategories){
            [DatabaseManager insertListingCategoriesFromJSON:subcategories];
        }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            [apiOperationsManager setOperationError:error];
            NSLog(@"Error: %@", error);
        }];
        
        return operation;
        
}



//https://images.tmsandbox.co.nz/photoserver/thumb/892412.jpg
//Given a listing ID, returns its thumbnail
+(NSOperation*) generateThumbnailOperation: (AFHTTPSessionManager *)manager withImageID: (NSString*)imageID
{
    NSString* apiURL = [NSString stringWithFormat: @"https://%@/photoserver/thumb/%@.jpg", IMAGES_SANDBOXURI, imageID];
    apiURL = [apiURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSLog(@"Generated URL: %@", apiURL);
    
    
    APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
    [apiOperationsManager setOperationError:nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    AFImageResponseSerializer* responseSerializer = (AFImageResponseSerializer*)[UIImageView sharedImageDownloader].sessionManager.responseSerializer;
    responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObject:@"image/jpg"];
    
    manager.responseSerializer = responseSerializer;
    
    NSOperation *operation = [AFHTTPSessionOperation operationWithManager:manager HTTPMethod:@"GET" URLString:apiURL parameters:nil uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"JSON ThumbnailOperation SUCCESSFUL: %@", responseObject);
        
        NSData *uiImageData = UIImagePNGRepresentation(responseObject);
        [DatabaseManager insertImage: imageID withData: uiImageData];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [apiOperationsManager setOperationError:error];
        NSLog(@"Error: %@", error);
    }];
    
    return operation;
}



@end
