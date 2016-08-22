//
//  TermsAndConditionsTableViewCell.h
//  App Rede
//
//  Created by Max Ueda on 2/1/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsAndConditionsTableViewCell : UITableViewCell
@property(nonatomic, weak) IBOutlet UIWebView *wvTermsAndConditions;
@property(nonatomic, weak) IBOutlet UIButton *btnArrowUp;
@property(nonatomic, assign) BOOL isShrinked;
-(void) setHTMLWithFileName: (NSString*) fileName;
-(float) rowHeight;

@end
