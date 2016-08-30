//
//  APIOperationsManager.m
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.

//

//http://wiki.lanet.accorservices.net/xwiki/bin/view/Arquitetura/NPE.Estabelecimentos.V1

#import "APIOperationsManager.h"
#import "APIOperations.h"

//Handles all networking operations
@implementation APIOperationsManager

+(APIOperationsManager*)getSharedInstance
{
    static APIOperationsManager *_sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedInstance = [[super allocWithZone:NULL]init];
    });
    return _sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        
    }
    return self;
}


//Operations execution (queue) and results handling.
-(void) retrieveDataFromNetworkWithOperations: (NSArray*) operations
                                      success:(void (^)(BOOL operationResult))success
                                    failure: (void (^)(NSError * _Nonnull)) failure
{
    //Control operation. This is hardly the best solution, but it works for most scenarios.
    NSOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"All done");
        BOOL operationResult = YES;
        
        if(self.operationQueue)
        {
            NSLog(@"Operation count: %li", (long)[self.operationQueue operationCount]);
            APIOperationsManager *apiOperationsManager = [APIOperationsManager getSharedInstance];
            if(apiOperationsManager.operationError)
            {
                self.operationQueue = nil;
                operationResult = NO;
                NSError *error = apiOperationsManager.operationError;
                failure(error);
            }
            
            
            else
            {
                //There shouldn't be operations in the queue when this operation starts.
                if([self.operationQueue operationCount]>0)
                {
                    self.operationQueue = nil;
                    operationResult = NO;
                    NSError *error = [NSError errorWithDomain:@"trademe.co.nz.error" code:666 userInfo:nil];
                    failure(error);
                }
            
                else
                {
                    self.operationQueue = nil;
                    success(operationResult);
                }
            }
        }
        
        
    }];
    
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self.operationQueue setMaxConcurrentOperationCount:1];
    
    self.operationQueue.name = @"AFHTTPSessionManager queue";
    
    //Completion operation will be added to the last operation in the array.
    /*
     Shouldn't this work better?
     NSOperation *lastOperation = [operations lastObject];
     [completionOperation addDependency: operation];
     */
    for (NSOperation *operation in operations)
    {
        [completionOperation addDependency:operation];
    }
    
    if(operations&&([operations count]>0))
    {
        [self.operationQueue addOperations:operations waitUntilFinished:NO];
        [[NSOperationQueue mainQueue] addOperation:completionOperation];
    }
}

//Executes ONE operation (duh)
-(void) retrieveDataFromNetworkWithOperation: (NSOperation*) operation
                                     success:(void (^)(BOOL operationResult))success
                                     failure: (void (^)(NSError * error)) failure
{
    [self retrieveDataFromNetworkWithOperations:@[operation] success:success failure:failure];
}

-(NSArray*) retrieveCategoriesListings: (NSArray*) listingCategory
{
   AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableArray *operationsArray = [NSMutableArray array];
    
    for(NSInteger i=0; i<[listingCategory count]; i++)
    {
        ListingCategory *category = [listingCategory objectAtIndex:i];
        [operationsArray addObject: [APIOperations generateListingOperation:manager withCategoryID:category.ID]];
    }
    return operationsArray;
}

-(NSArray*) retrieveImagesWithImageIDs: (NSArray*) imageIDs
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableArray *operationsArray = [NSMutableArray array];
    
    for(NSInteger i=0; i<[imageIDs count]; i++)
    {
        NSString *imageID = [imageIDs objectAtIndex:i];
        [operationsArray addObject: [APIOperations generateThumbnailOperation: manager withImageID:imageID]];
    }
    return operationsArray;
}


-(NSOperation*) retrieveCategories
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return [APIOperations generateCategoryOperation:manager];
    
}
-(NSOperation*) retrieveSearchResultsWithKeyword: (NSString*) keyword
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return [APIOperations generateSearchOperation:manager withKeyword:keyword];
}
-(NSOperation*) retrieveSearchResultsWithCategoryID: (NSString*) categoryID
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return [APIOperations generateListingOperation:manager withCategoryID:categoryID];
}

-(NSOperation*) retrieveListingDetailsWithListingID: (NSString*) listingID
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return [APIOperations generateListingDetailOperation:manager withListingID:listingID];
}

-(NSOperation*) retrieveImageWithImageID: (NSString*) imageID
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    return [APIOperations generateThumbnailOperation:manager withImageID:imageID];
}

@end
