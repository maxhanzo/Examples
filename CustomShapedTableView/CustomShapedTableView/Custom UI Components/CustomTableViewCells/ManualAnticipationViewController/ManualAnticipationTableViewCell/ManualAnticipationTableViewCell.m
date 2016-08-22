//
//  ManualAnticipationTableViewCell.m
//  App Rede
//
//  Created by Max Ueda on 2/1/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ManualAnticipationTableViewCell.h"

@implementation ManualAnticipationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat) rowHeight
{
    return 80.0f;
}
@end
