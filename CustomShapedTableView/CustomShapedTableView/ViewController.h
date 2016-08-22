//
//  ViewController.h
//  CustomShapedTableView
//
//  Created by Ticket Services on 8/22/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomShapedTableView.h"
#import "TermsAndConditionsTableViewCell.h"
#import "ManualAnticipationTableViewCell.h"

#define TermsAndConditionsInvisible 0
#define TermsAndConditionsVisible 1

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, weak) IBOutlet CustomShapedTableView* myTable;
@property(nonatomic, strong) TermsAndConditionsTableViewCell *termsAndConditionsTableViewCell;
@property(nonatomic, strong) ManualAnticipationTableViewCell* manualAnticipationTableViewCell;

@property(nonatomic, weak) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property(nonatomic, assign) BOOL agreeWithTerms;
@property(nonatomic, assign) NSInteger termsAndConditionsMode;

@end

