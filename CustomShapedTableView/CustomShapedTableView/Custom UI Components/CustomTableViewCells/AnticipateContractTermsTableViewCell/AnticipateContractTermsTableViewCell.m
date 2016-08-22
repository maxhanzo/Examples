//
//  AnticipateContractTermsTableViewCell.m
//  App Rede
//
//  Created by Max Ueda on 12/1/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "AnticipateContractTermsTableViewCell.h"

@implementation AnticipateContractTermsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)toggleCheck:(id)sender
{
    self.btnCheck.selected = !self.btnCheck.selected; // toggle the selected property, just a simple BOOL
    [self changeCheckboxImage];
}

+(CGFloat) rowHeight
{
    return 46.0f;
}

-(void) changeCheckboxImage
{
    if(self.btnCheck.selected)
    {
        [self.btnCheck setBackgroundImage:[UIImage imageNamed: @"EmptyCheckbox"] forState:UIControlStateSelected];
    }
    
    else
    {
        [self.btnCheck setBackgroundImage:[UIImage imageNamed: @"Checkbox"] forState:UIControlStateNormal];
    }
}
@end
