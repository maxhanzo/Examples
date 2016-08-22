//
//  ManualAnticipationTableViewCell.h
//  App Rede
//
//  Created by Max Ueda on 2/1/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedEdgesButton.h"
@interface ManualAnticipationTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UILabel *lblValue;
@property(nonatomic, weak) IBOutlet UILabel *lblRate;
@property(nonatomic, weak) IBOutlet RoundedEdgesButton *btnAnticipate;


+(CGFloat) rowHeight;
@end
