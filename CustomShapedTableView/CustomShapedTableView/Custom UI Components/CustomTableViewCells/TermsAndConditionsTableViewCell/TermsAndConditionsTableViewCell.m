//
//  TermsAndConditionsTableViewCell.m
//  Custom Shaped Table View
//
//  Created by Max Ueda on 2/1/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "TermsAndConditionsTableViewCell.h"

@implementation TermsAndConditionsTableViewCell
-(void) setHTMLWithFileName: (NSString*) fileName
{
    NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    NSString* htmlContent = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
    [self.wvTermsAndConditions loadHTMLString:htmlContent baseURL:nil];

}


-(float) rowHeight
{
    return 229.5;
}

@end
