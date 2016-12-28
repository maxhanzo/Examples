//
//  GroupDetailTableViewFooterCell.h
//  Sokuseki
//
//  Created by Ticket Services on 12/26/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailTableViewFooterCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblTotalPeople;
-(void) setTotalPeopleText: (NSString*) totalRecords;
+(float)rowHeight;
@end
