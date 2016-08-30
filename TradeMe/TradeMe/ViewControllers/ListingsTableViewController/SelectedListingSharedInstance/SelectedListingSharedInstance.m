//
//  SelectedListingSharedInstance.m
//  TradeMe
//
//  Created by Max Ueda on 8/29/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "SelectedListingSharedInstance.h"
#define SELECTEDLISTING_FILENAME @"selectedListing.dat"

@implementation SelectedListingSharedInstance

+ (SelectedListingSharedInstance*)getSharedInstance
{
    static SelectedListingSharedInstance *_sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedInstance = [[super allocWithZone:NULL]init];
    });
    return _sharedInstance;
}

- (id)init {
    if ((self = [super init])) {
        [self loadState];
    }
    return self;
}


//back from background: State is loaded.
- (void)loadState {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString* rootPath = paths[0];
    
    NSString *filePath = [rootPath stringByAppendingPathComponent:SELECTEDLISTING_FILENAME];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:filePath];
    
    if (data)
    { // Might not have any initial state.
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        self.selectedListing = [decoder decodeObjectForKey: @"selectedListing"];
        [decoder finishDecoding];
    }
    
}

//Enters background: State is saved.
- (void)saveState{
    NSMutableData *data = [NSMutableData data];
    if (data)
    {
        NSKeyedArchiver *coder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [coder encodeObject: self.selectedListing forKey: @"selectedListing"];
        [coder finishEncoding];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:SELECTEDLISTING_FILENAME];
    
    // Save instance state to file system
    [data writeToFile:dataPath atomically:YES];
}

//If user signs out.
-(void) deleteFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString* rootPath = paths[0];
    NSString *filePath = [rootPath stringByAppendingPathComponent:SELECTEDLISTING_FILENAME];
    
    NSError *error;
    [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
    
    if (error)
    {
        NSLog(@"%@", error);
    }
}
//TODO
- (void) flushData{}
@end


