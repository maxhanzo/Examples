//
//  RoundedEdgesButton.h
//  RoundedEdgesButton
//
//  Created by Max Ueda on 12/1/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface RoundedEdgesButton : UIButton

@property(assign) IBInspectable CGFloat cornerRadius;

@property(assign) IBInspectable BOOL topEdgeLeft;
@property(assign) IBInspectable BOOL topEdgeRight;
@property(assign) IBInspectable BOOL bottomEdgeLeft;
@property(assign) IBInspectable BOOL bottomEdgeRight;
@property(assign, nonatomic) IBInspectable BOOL dropShadow;
@property(nonatomic, strong) IBInspectable UIColor *dropShadowColor;


@property(nonatomic, strong) CAShapeLayer *containerLayer;
@end
