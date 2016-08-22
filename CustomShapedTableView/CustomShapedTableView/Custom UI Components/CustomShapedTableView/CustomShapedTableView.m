//
//  CustomShapedTableView.m
//  App Rede
//
//  Created by Ticket Services on 4/1/16.
//  Copyright © 2016 Ticket Serviços. All rights reserved.
//

#import "CustomShapedTableView.h"
#define ShadowViewTag 666
#define ViewTag 777

@implementation CustomShapedTableView
//TODO: SHADOW

- (void)prepareForInterfaceBuilder
{
#if !TARGET_INTERFACE_BUILDER
    self.cornerRadius = 10;
    self.backgroundColor = [UIColor greenColor];
    self.maskClipsToBounds = NO;
    
#else
    // this code will execute only in IB
#endif
    //[self setupTable];
    [self setNeedsDisplay];
}

-(void) setupTable
{
    self.layer.masksToBounds = self.maskClipsToBounds;
    [self.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.layer setShadowOpacity:0.8];
    [self.layer setShadowRadius:3.0];
    [self.layer setShadowOffset:CGSizeMake(2.0, 2.0)];

}
- (void)drawRect:(CGRect)rect {
    [self setTag: ViewTag];
    self.layer.masksToBounds = _maskClipsToBounds;
    //Dynamic corners
    UIRectCorner corners = (_bottomEdgeLeft ? UIRectCornerBottomLeft : 0) |
    (_bottomEdgeRight ? UIRectCornerBottomRight : 0) |
    (_topEdgeLeft ? UIRectCornerTopLeft : 0) |
    (_topEdgeRight ? UIRectCornerTopRight : 0);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners                                                         cornerRadii:CGSizeMake(self.cornerRadius, self.cornerRadius)];
    
    [self.backgroundColor set];
    
    [maskPath fill];
    [maskPath stroke];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), .02, [UIColor blackColor].CGColor);
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
    
    if(!self.shadowView)
    {
        [self putView:self insideShadowWithColor:self.shadowColor andRadius:1 andOffset:CGSizeMake(1, 1) andOpacity:5];
    }
    
    else
    {
        [self resizeShadowWithColor: self.shadowColor andRadius:1 andOffset:CGSizeMake(1, 1) andOpacity:5];
    }
    
    CGContextFlush(context);
    
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {

        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

//Drop shadow
- (void)putView:(UIView*)view insideShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity
{
    CGRect shadowFrame = view.frame; // Modify this if needed
    UIView * shadow = [[UIView alloc] initWithFrame:shadowFrame];
    [shadow setTag: ShadowViewTag];
    shadow.userInteractionEnabled = YES; // Modify this if needed
    shadow.layer.shadowColor = color.CGColor;
    shadow.layer.shadowOffset = shadowOffset;
    shadow.layer.shadowRadius = shadowRadius;
    shadow.layer.masksToBounds = NO;
    shadow.clipsToBounds = NO;
    shadow.layer.shadowOpacity = shadowOpacity;
    [view.superview insertSubview:shadow belowSubview:view];
    [shadow addSubview:view];
    self.shadowView = shadow;
}

//Workarround. I didn't think we'd need to redraw and resize this TableView, thus, Daniel Gindi's solution won't work
//well in this case. We'll need to resize the shadow as well, instead of drawing it again.
-(void) resizeShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity
{
    CGRect shadowFrame = self.frame; // Modify this if needed
    UIView * shadow = [[UIView alloc] initWithFrame:shadowFrame];
    [shadow setTag: ShadowViewTag];
    shadow.userInteractionEnabled = YES; // Modify this if needed
    shadow.layer.shadowColor = color.CGColor;
    shadow.layer.shadowOffset = shadowOffset;
    shadow.layer.shadowRadius = shadowRadius;
    shadow.layer.masksToBounds = NO;
    shadow.clipsToBounds = NO;
    shadow.layer.shadowOpacity = shadowOpacity;
    self.shadowView = shadow;
}

@end
