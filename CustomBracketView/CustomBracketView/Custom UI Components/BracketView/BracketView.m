//
//  BracketView.m
//  CustomBracketView
//
//  Created by Max Ueda on 01/15/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//


#import "BracketView.h"
#define BracketDown 0
#define BracketUp 1
#define BracketLeft 2
#define BracketRight 3

@implementation BracketView

- (void)prepareForInterfaceBuilder
{
    
#if !TARGET_INTERFACE_BUILDER
    self.archRadius = 10;
    self.backgroundColor = [UIColor greenColor];
#else
    // this code will execute only in IB
#endif
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath* path = nil;
    
    if(self.roundedEdges)
    {
        path = [self drawBracketPathRoundedEdges];
    }
    
    else
    {
        path = [self drawBracketPath];
    }
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = path.CGPath;
    self.layer.mask         = maskLayer;
    [self.layer setMasksToBounds:YES];
    
    
    if(self.dropShadow)
    {
        [self putView:self insideShadowWithColor:self.dropShadowColor andRadius:1 andOffset:CGSizeMake(1, 1) andOpacity:5];
    }

    
}

//Draws the path to bracket without rounded edges
-(UIBezierPath*) drawBracketPath
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    
    switch(self.bracketDirection)
    {
        case BracketDown:
        {
            [path addLineToPoint: CGPointMake(self.frame.size.width, 0)];
            [path addLineToPoint: CGPointMake(self.frame.size.width, self.frame.size.height - self.bracketOffset)];
            [path addLineToPoint: CGPointMake(self.bracketOffset + self.archRadius, self.frame.size.height - self.bracketOffset)];
            
            CGPoint bracketRightArchCenter = CGPointMake(self.bracketCenter + self.archRadius, self.frame.size.height - self.bracketOffset + self.archRadius);
            
            [path addArcWithCenter:bracketRightArchCenter radius:self.archRadius startAngle:(3*M_PI/2) endAngle:M_PI clockwise:NO];
            
            CGPoint bracketLeftArchCenter = CGPointMake(self.bracketCenter - self.archRadius, self.frame.size.height - self.bracketOffset + self.archRadius);
            
            [path addArcWithCenter:bracketLeftArchCenter radius:self.archRadius startAngle:2*M_PI endAngle:(3*M_PI/2) clockwise:NO];
            
            [path addLineToPoint: CGPointMake(0, self.frame.size.height - self.bracketOffset)];
            
            [path closePath];
        }   break;
            
        case BracketUp:
        {
            [path moveToPoint: CGPointMake(self.frame.size.width, self.bracketOffset)];
            [path addLineToPoint: CGPointMake(self.bracketCenter + self.archRadius, self.bracketOffset)];
            
            CGPoint bracketRightArchCenter = CGPointMake(self.bracketCenter + self.archRadius, self.bracketOffset - self.archRadius);
            
            [path addArcWithCenter:bracketRightArchCenter radius:self.archRadius startAngle:M_PI/2 endAngle:(M_PI) clockwise:YES];
            
            CGPoint bracketLeftArchCenter = CGPointMake(self.bracketCenter - self.archRadius, self.bracketOffset - self.archRadius);
            
            [path addArcWithCenter:bracketLeftArchCenter radius:self.archRadius startAngle:2*M_PI endAngle:(M_PI/2) clockwise:YES];
            
            [path addLineToPoint: CGPointMake(0, self.bracketOffset)];
            [path addLineToPoint: CGPointMake(0, self.frame.size.height)];
            [path addLineToPoint: CGPointMake(self.frame.size.width, self.frame.size.height)];
            [path addLineToPoint: CGPointMake(self.frame.size.width, self.bracketOffset)];;
            [path closePath];
            
        }   break;
            
        case BracketLeft:
        {
            [path moveToPoint: CGPointMake(self.bracketOffset + self.archRadius, 0)];
            [path addLineToPoint: CGPointMake(self.frame.size.width, 0)];
            [path addLineToPoint: CGPointMake(self.frame.size.width, self.frame.size.height)];
            [path addLineToPoint: CGPointMake(self.bracketOffset + self.archRadius, self.frame.size.height)];
            
            [path addLineToPoint: CGPointMake(self.bracketOffset + self.archRadius , self.bracketCenter + self.archRadius)];
            CGPoint bracketLowerArchCenter = CGPointMake(self.bracketOffset , self.bracketCenter + self.archRadius);
            
            [path addArcWithCenter:bracketLowerArchCenter radius:self.archRadius startAngle:0 endAngle:(3*M_PI/2) clockwise:NO];
            
            CGPoint bracketUpperArchCenter = CGPointMake(self.bracketOffset, self.bracketCenter - self.archRadius);
            
            [path addArcWithCenter:bracketUpperArchCenter radius:self.archRadius startAngle:M_PI/2 endAngle:(2*M_PI) clockwise:NO];
            
            [path closePath];

            
        }   break;
            

        case BracketRight:
        {
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.bracketOffset, 0)];
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.bracketOffset, self.bracketCenter - self.archRadius)];
            
            
            CGPoint bracketUpperArchCenter = CGPointMake(self.frame.size.width - self.bracketOffset + self.archRadius, self.bracketCenter - self.archRadius);
            [path addArcWithCenter:bracketUpperArchCenter radius:self.archRadius startAngle:(M_PI) endAngle:(M_PI/2) clockwise:NO];
            
            CGPoint bracketLowerArchCenter = CGPointMake(self.frame.size.width -  self.bracketOffset + self.archRadius, self.bracketCenter + self.archRadius);
            [path addArcWithCenter:bracketLowerArchCenter radius:self.archRadius startAngle:3*M_PI/2 endAngle:(M_PI) clockwise:NO];
            
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.bracketOffset, self.frame.size.height)];
            [path addLineToPoint: CGPointMake(0, self.frame.size.height)];
            [path closePath];
            
        }   break;
            
        default: break;
    }
    
    [self.backgroundColor setFill];
    
    [path fill];
    return path;

}

//Draws the path to bracket with rounded edges
-(UIBezierPath*) drawBracketPathRoundedEdges
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    
    switch(self.bracketDirection)
    {
        case BracketDown:
        {
            //Upper Left Rounded Edge Corner
            [path addArcWithCenter:CGPointMake(self.roundedEdgesRadius, self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.roundedEdgesRadius, 0)];
            
            //Upper Right Rounded Edge Corner
            [path addArcWithCenter:CGPointMake(self.frame.size.width - self.roundedEdgesRadius, self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
            [path addLineToPoint: CGPointMake(self.frame.size.width, self.frame.size.height - self.bracketOffset - self.roundedEdgesRadius)];
            
            //Lower Right Rounded Edge Corner
            [path addArcWithCenter:CGPointMake(self.frame.size.width - self.roundedEdgesRadius, self.frame.size.height - self.bracketOffset - self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:2*M_PI endAngle:M_PI/2 clockwise:YES];
            [path addLineToPoint: CGPointMake(self.bracketOffset + self.archRadius, self.frame.size.height - self.bracketOffset)];
            
            //Bracket Right Arch
            CGPoint bracketRightArchCenter = CGPointMake(self.bracketCenter + self.archRadius, self.frame.size.height - self.bracketOffset + self.archRadius);
            [path addArcWithCenter:bracketRightArchCenter radius:self.archRadius startAngle:(3*M_PI/2) endAngle:M_PI clockwise:NO];
            
            //Bracket Left Arch
            CGPoint bracketLeftArchCenter = CGPointMake(self.bracketCenter - self.archRadius, self.frame.size.height - self.bracketOffset + self.archRadius);
            [path addArcWithCenter:bracketLeftArchCenter radius:self.archRadius startAngle:2*M_PI endAngle:(3*M_PI/2) clockwise:NO];
            
            [path addLineToPoint: CGPointMake(self.roundedEdgesRadius, self.frame.size.height - self.bracketOffset)];
            
            //Lower Left Rounded Edge Corner
            [path addArcWithCenter:CGPointMake(self.roundedEdgesRadius, self.frame.size.height - self.bracketOffset - self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
            
            [path closePath];
        }   break;
            
        case BracketUp:
        {
    
            [path moveToPoint: CGPointMake(self.frame.size.width - self.roundedEdgesRadius, self.bracketOffset)];
            [path addLineToPoint: CGPointMake(self.bracketCenter + self.archRadius, self.bracketOffset)];
            
            //Bracket right arch
            CGPoint bracketRightArchCenter = CGPointMake(self.bracketCenter + self.archRadius, self.bracketOffset - self.archRadius);
            [path addArcWithCenter:bracketRightArchCenter radius:self.archRadius startAngle:M_PI/2 endAngle:(M_PI) clockwise:YES];
            
            //Bracket left arch
            CGPoint bracketLeftArchCenter = CGPointMake(self.bracketCenter - self.archRadius, self.bracketOffset - self.archRadius);
            [path addArcWithCenter:bracketLeftArchCenter radius:self.archRadius startAngle:2*M_PI endAngle:(M_PI/2) clockwise:YES];
            
            //Upper Left Rounded Edge Corner
            [path addLineToPoint: CGPointMake(self.roundedEdgesRadius, self.bracketOffset)];
            [path addArcWithCenter:CGPointMake(self.roundedEdgesRadius, self.roundedEdgesRadius + self.bracketOffset) radius:self.roundedEdgesRadius startAngle:3*M_PI/2 endAngle:M_PI clockwise:NO];
            
            //Lower Left Rounded Edge Corner
            [path addLineToPoint: CGPointMake(0, self.frame.size.height - self.roundedEdgesRadius)];
            [path addArcWithCenter:CGPointMake(self.roundedEdgesRadius, self.frame.size.height - self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:M_PI endAngle:M_PI/2 clockwise:NO];
            
            //Lower Right Rounded Edge Corner
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.roundedEdgesRadius, self.frame.size.height)];
            [path addArcWithCenter:CGPointMake(self.frame.size.width - self.roundedEdgesRadius, self.frame.size.height - self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:M_PI/2 endAngle:2*M_PI clockwise:NO];
            
            //Upper Right Rounded Edge Corner
            [path addLineToPoint: CGPointMake(self.frame.size.width, self.bracketOffset + self.roundedEdgesRadius)];
            [path addArcWithCenter:CGPointMake(self.frame.size.width - self.roundedEdgesRadius,self.bracketOffset + self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:2*M_PI endAngle:3*M_PI/2 clockwise:NO];
            
            [path closePath];
            
        }   break;
            
        case BracketLeft:
        {
            CGPoint upperLeftRoundCorner = CGPointMake(self.bracketOffset + self.archRadius + self.roundedEdgesRadius, self.roundedEdgesRadius);
            [path moveToPoint: CGPointMake(self.bracketOffset + self.archRadius, self.roundedEdgesRadius)];
            [path addArcWithCenter:upperLeftRoundCorner radius:self.roundedEdgesRadius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
            
            
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.roundedEdgesRadius, 0)];
            
            CGPoint upperRightRoundCorner = CGPointMake(self.frame.size.width - self.roundedEdgesRadius, self.roundedEdgesRadius);
            
            [path addArcWithCenter:upperRightRoundCorner radius:self.roundedEdgesRadius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];

            
            [path addLineToPoint: CGPointMake(self.frame.size.width, self.frame.size.height - self.roundedEdgesRadius)];
            
            CGPoint lowerRightRoundCorner = CGPointMake(self.frame.size.width - self.roundedEdgesRadius, self.frame.size.height - self.roundedEdgesRadius);
            [path addArcWithCenter:lowerRightRoundCorner radius:self.roundedEdgesRadius startAngle:2*M_PI endAngle:M_PI/2 clockwise:YES];
            
            [path addLineToPoint: CGPointMake(self.bracketOffset + self.archRadius + self.roundedEdgesRadius, self.frame.size.height)];
            
            CGPoint lowerLeftRoundCorner = CGPointMake(self.bracketOffset + self.archRadius + self.roundedEdgesRadius, self.frame.size.height - self.roundedEdgesRadius);
            [path addArcWithCenter:lowerLeftRoundCorner radius:self.roundedEdgesRadius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
            
            
            [path addLineToPoint: CGPointMake(self.bracketOffset + self.archRadius , self.bracketCenter + self.archRadius)];
            CGPoint bracketLowerArchCenter = CGPointMake(self.bracketOffset , self.bracketCenter + self.archRadius);
            
            [path addArcWithCenter:bracketLowerArchCenter radius:self.archRadius startAngle:0 endAngle:(3*M_PI/2) clockwise:NO];
            
            CGPoint bracketUpperArchCenter = CGPointMake(self.bracketOffset, self.bracketCenter - self.archRadius);
            
            [path addArcWithCenter:bracketUpperArchCenter radius:self.archRadius startAngle:M_PI/2 endAngle:(2*M_PI) clockwise:NO];
            
            [path closePath];
            

            
            
        }   break;
            
        case BracketRight:
        {
            [path moveToPoint: CGPointMake(self.roundedEdgesRadius, 0)];
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.bracketOffset - self.roundedEdgesRadius, 0)];
            [path addArcWithCenter:CGPointMake(self.frame.size.width - self.bracketOffset - self.roundedEdgesRadius, self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:3*M_PI/2 endAngle:2*M_PI clockwise:YES];
            
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.bracketOffset, self.bracketCenter - self.archRadius)];
            
            
            CGPoint bracketUpperArchCenter = CGPointMake(self.frame.size.width - self.bracketOffset + self.archRadius, self.bracketCenter - self.archRadius);
            [path addArcWithCenter:bracketUpperArchCenter radius:self.archRadius startAngle:(M_PI) endAngle:(M_PI/2) clockwise:NO];
            
            CGPoint bracketLowerArchCenter = CGPointMake(self.frame.size.width -  self.bracketOffset + self.archRadius, self.bracketCenter + self.archRadius);
            [path addArcWithCenter:bracketLowerArchCenter radius:self.archRadius startAngle:3*M_PI/2 endAngle:(M_PI) clockwise:NO];
            
            [path addLineToPoint: CGPointMake(self.frame.size.width - self.bracketOffset, self.frame.size.height - self.roundedEdgesRadius)];
            [path addArcWithCenter:CGPointMake(self.frame.size.width - self.bracketOffset - self.roundedEdgesRadius, self.frame.size.height - self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:2*M_PI endAngle:M_PI/2 clockwise:YES];

            [path addLineToPoint: CGPointMake(self.roundedEdgesRadius, self.frame.size.height)];
            [path addArcWithCenter:CGPointMake(self.roundedEdgesRadius, self.frame.size.height - self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:M_PI/2 endAngle:M_PI clockwise:YES];
            
            [path addLineToPoint: CGPointMake(0, self.roundedEdgesRadius)];
            [path addArcWithCenter:CGPointMake(self.roundedEdgesRadius, self.roundedEdgesRadius) radius:self.roundedEdgesRadius startAngle:M_PI endAngle:3*M_PI/2 clockwise:YES];
            [path closePath];
            
            
            
            
            }   break;
            
        default: break;
    }
    
    [self.backgroundColor setFill];
    
    [path fill];
    return path;
    
}

//Drop shadow
//http://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow
//daniel.gindi 's answer
- (void)putView:(UIView*)view insideShadowWithColor:(UIColor*)color andRadius:(CGFloat)shadowRadius andOffset:(CGSize)shadowOffset andOpacity:(CGFloat)shadowOpacity
{
    CGRect shadowFrame = view.frame; // Modify this if needed
    UIView * shadow = [[UIView alloc] initWithFrame:shadowFrame];
    shadow.userInteractionEnabled = YES; // Modify this if needed
    shadow.layer.shadowColor = color.CGColor;
    shadow.layer.shadowOffset = shadowOffset;
    shadow.layer.shadowRadius = shadowRadius;
    shadow.layer.masksToBounds = NO;
    shadow.clipsToBounds = NO;
    shadow.layer.shadowOpacity = shadowOpacity;
    [view.superview insertSubview:shadow belowSubview:view];
    [shadow addSubview:view];
}



- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
