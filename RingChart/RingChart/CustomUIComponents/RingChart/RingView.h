//
//  RingView.h
//  RingChart
//
//  Created by Max Ueda on 9/4/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//
//  Based on  Pavan Podila's Pie Chart (https://github.com/pavanpodila/PieChart )
//

#import <UIKit/UIKit.h>


@interface RingView : UIView

@property (nonatomic, strong) NSArray *sliceValues;
//StartColor and EndColor (each slice has it's own Dictionary
@property (nonatomic, strong) NSArray *sliceColors;


@property(nonatomic, assign) BOOL integerPercentageValueFormat;

@property(nonatomic, strong) NSString* minValue;
@property(nonatomic, strong) NSString* maxValue;


-(id)initWithSliceValues:(NSArray *)sliceValues;


@end
