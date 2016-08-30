//
//  ListingsTableViewController.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategorySelectionDelegate.h"
#import "ListingCategory.h"


@interface ListingsTableViewController : UITableViewController<CategorySelectionDelegate, UISplitViewControllerDelegate>
@property(nonatomic, strong) NSArray* listings; 

@end
