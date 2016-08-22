//
//  BracketView.h
//  CustomBracketView
//
//  Created by Max Ueda on 01/15/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

//A dull and boring component for visual effects, as requested by one of our clients.
//It's parameters can be set and previewd with Interface Builder (all except drop shadow).
#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface BracketView : UIView

@property(nonatomic, assign) IBInspectable NSInteger bracketDirection;
@property(nonatomic, assign) IBInspectable CGFloat archRadius;
@property(nonatomic, assign) IBInspectable CGFloat bracketCenter;
@property(nonatomic, assign) IBInspectable CGFloat bracketOffset;
@property(nonatomic, assign) IBInspectable CGFloat roundedEdgesRadius;
@property(nonatomic, assign) IBInspectable BOOL roundedEdges;
@property(nonatomic, assign) IBInspectable BOOL dropShadow;
@property(nonatomic, strong) IBInspectable UIColor *dropShadowColor;

-(UIBezierPath*) drawBracketPath;
-(UIBezierPath*) drawBracketPathRoundedEdges;


@end
