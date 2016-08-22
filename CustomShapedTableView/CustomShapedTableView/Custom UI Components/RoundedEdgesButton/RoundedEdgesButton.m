//
//  RoundedEdgesButton.m
//  RoundedEdgesButton
//
//  Created by Max Ueda on 12/1/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//


#import "RoundedEdgesButton.h"

@implementation RoundedEdgesButton


- (void)prepareForInterfaceBuilder
{

#if !TARGET_INTERFACE_BUILDER
    self.cornerRadius = 10;
    self.backgroundColor = [UIColor redColor];
   
#else
    // this code will execute only in IB
#endif
     [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    //Dynamic corners
    //http://stackoverflow.com/questions/20296222/how-to-write-a-generic-uirectcorner-function
    UIRectCorner corners = (_bottomEdgeLeft ? UIRectCornerBottomLeft : 0) |
    (_bottomEdgeRight ? UIRectCornerBottomRight : 0) |
    (_topEdgeLeft ? UIRectCornerTopLeft : 0) |
    (_topEdgeRight ? UIRectCornerTopRight : 0);

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners                                                         cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    
    [self.backgroundColor set];
    
    [maskPath fill];
    [maskPath stroke];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path  = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    if(self.dropShadow)
    {
        [self putView:self insideShadowWithColor:self.dropShadowColor andRadius:1 andOffset:CGSizeMake(1, 1) andOpacity:5];
    }
    

}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame])){
    
    }
    
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
}

//Drop shadow
//http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow
//daniel.gindi 's answer
- (void)putView:(UIView*)view insideShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity
{
    //Personally, I don't like this idea of drawing the shadow view and adding the superview onto it.
    //However, we've a tight schedule, and perhaps it'd be better to think of better ways later.
    CGRect shadowFrame = view.frame;
    UIView * shadow = [[UIView alloc] initWithFrame:shadowFrame];
    shadow.userInteractionEnabled = YES;
    shadow.layer.shadowColor = color.CGColor;
    shadow.layer.shadowOffset = shadowOffset;
    shadow.layer.shadowRadius = shadowRadius;
    shadow.layer.masksToBounds = NO;
    shadow.clipsToBounds = NO;
    shadow.layer.shadowOpacity = shadowOpacity;
    [view.superview insertSubview:shadow belowSubview:view];
    [shadow addSubview:view];
}



@end
