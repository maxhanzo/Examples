//
//  CategoriesTableViewController.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListingCategory.h"
#import "CategorySelectionDelegate.h"

@interface CategoriesTableViewController : UITableViewController
@property(nonatomic, strong) NSArray* categoriesArray;
@property (nonatomic, assign) id<CategorySelectionDelegate> delegate;
@property (strong, nonatomic) UISearchController *searchController;
@end
