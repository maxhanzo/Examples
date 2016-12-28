//
//  YearTableViewCell.m
//  TagTest
//
//  Created by Ticket Services on 12/14/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "YearTableViewCell.h"

@implementation YearTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float) rowHeight
{
    return 43.5f;
}

@end
