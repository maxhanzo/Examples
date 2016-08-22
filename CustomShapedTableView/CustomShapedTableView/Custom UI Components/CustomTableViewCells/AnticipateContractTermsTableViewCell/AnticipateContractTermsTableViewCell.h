//
//  AnticipateContractTermsTableViewCell.h
//  App Rede
//
//  Created by Max Ueda on 12/1/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnticipateContractTermsTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UIButton *btnCheck;
@property(nonatomic, weak) IBOutlet UIButton *btnToggleTermsConditions;

- (void)toggleCheck:(id)sender;

+(CGFloat) rowHeight;
@end
