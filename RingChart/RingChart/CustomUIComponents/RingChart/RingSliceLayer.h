//
//  RingSliceLayer.h
//  RingChart
//
//
//  Created by Max Ueda on 9/4/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//
//  Based on  Pavan Podila's Pie Chart (https://github.com/pavanpodila/PieChart )
//
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface RingSliceLayer : CALayer


@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat endAngle;

@property (nonatomic, strong) UIColor *gradientStartColor;
@property (nonatomic, strong) UIColor *gradientEndColor;

@end
