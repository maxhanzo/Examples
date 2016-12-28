//
//  PrefectureShipInputTableViewController.h
//  TagTest
//
//  Created by Ticket Services on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrefectureShipInputTableViewController : UITableViewController
@property(nonatomic, strong) NSString *segueID;
@property(nonatomic, strong) NSArray *sectionTitles;
@property(nonatomic, strong) NSDictionary *sectionHeaders;
@property(nonatomic, strong) NSArray *dataCollection;

+(NSArray*) generateShipNames;
+(NSArray*) generatePrefectureNames;
@end
