//
//  PrefectureListTableViewController.h
//  Sokuseki
//
//  Created by Ticket Services on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface PrefectureListTableViewController : UITableViewController<SWRevealViewControllerDelegate>


@property(nonatomic, strong) NSMutableArray *prefectureArray;
@property(nonatomic, strong) NSArray *prefectureDataSource;

@property(nonatomic, assign) NSUInteger topMostNumberOfImmigrants;
@property(nonatomic, assign) BOOL desc;





@end
