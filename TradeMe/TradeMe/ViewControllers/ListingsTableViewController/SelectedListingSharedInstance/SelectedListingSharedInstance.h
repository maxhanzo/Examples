//
//  SelectedListingSharedInstance.h
//  TradeMe
//
//  Created by Max Ueda on 8/29/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Listing.h"
@interface SelectedListingSharedInstance : NSObject
@property(nonatomic, strong) Listing* selectedListing;

+ (SelectedListingSharedInstance*)getSharedInstance;
- (void)loadState;
- (void)saveState;
- (void) flushData;

@end