//
//  ViewController.h
//  RingChart
//
//  Created by Max Ueda on 8/21/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingView.h"
@interface ViewController : UIViewController
@property(nonatomic, weak) IBOutlet RingView* ringView;
@property(nonatomic, weak) IBOutlet UILabel* lblLeftValue;

-(NSArray*) generateRandomValues;
-(IBAction)btnRandomValues:(id)sender;


@end

