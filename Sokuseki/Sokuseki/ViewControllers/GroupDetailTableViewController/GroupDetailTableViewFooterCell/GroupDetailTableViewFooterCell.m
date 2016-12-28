//
//  GroupDetailTableViewFooterCell.m
//  Sokuseki
//
//  Created by Ticket Services on 12/26/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "GroupDetailTableViewFooterCell.h"

@implementation GroupDetailTableViewFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void) setTotalPeopleText: (NSString*) totalRecords
{
    [self.lblTotalPeople setText: [NSString stringWithFormat:@"%@ people", totalRecords]];
}

+(float)rowHeight
{
    return 43.0f;
}
@end
