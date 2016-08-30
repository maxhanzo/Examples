//
//  CategorySelectionDelegate.h
//  TradeMe
//
//  Created by Max Ueda on 8/28/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ListingCategory;
//This protocol is simple: it's just a way of sending a message between view controllers.
//I could have used Shared Instances instead.
@protocol CategorySelectionDelegate <NSObject>

@required
-(void)selectedCategory:(ListingCategory *)category;

@end