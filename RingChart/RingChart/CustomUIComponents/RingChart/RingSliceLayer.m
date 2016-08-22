//
//  RingSliceLayer.m
//  RingChart
//
//  Created by Max Ueda on 9/4/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//
//  Based on  Pavan Podila's Pie Chart (https://github.com/pavanpodila/PieChart )
//
//

#import "RingSliceLayer.h"
#define M_EPSILON 0.00001

@implementation RingSliceLayer

@dynamic startAngle, endAngle, gradientStartColor, gradientEndColor;


-(CABasicAnimation *)makeAnimationForKey:(NSString *)key {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:key];
    anim.fromValue = [[self presentationLayer] valueForKey:key];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    anim.duration = 0.7;
    
    return anim;
}

- (id)init {
    self = [super init];
    if (self) {
//        
        [self setNeedsDisplay];
    }
    
    return self;
}

-(id<CAAction>)actionForKey:(NSString *)event {
    if ([event isEqualToString:@"startAngle"] ||
        [event isEqualToString:@"endAngle"]) {
        return [self makeAnimationForKey:event];
    }
    
    return [super actionForKey:event];
}

- (id)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        if ([layer isKindOfClass:[RingSliceLayer class]]) {
            RingSliceLayer *other = (RingSliceLayer *)layer;
            self.startAngle = other.startAngle;
            self.endAngle = other.endAngle;
            
        }
    }
    
    return self;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"]) {
        return YES;
    }
    
    return [super needsDisplayForKey:key];
}


-(void)drawInContext:(CGContextRef)ctx
{
    //Initial calculation for radius and center
    CGFloat x = self.bounds.origin.x;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    
    CGFloat radius = 0;
    
    radius = (w < h)?((x + w)/2.098): ((x + h)/2.098);

    CGFloat innerRadius = radius / (1.5);
    //Mask stuff
    CGRect r = self.bounds;
    [self drawGradientInContext:ctx  startingAngle:self.startAngle endingAngle:self.endAngle intRadius:^float(float f) {
        return innerRadius;
    } outRadius:^float(float f) {
        return radius;
    } withGradientBlock:^UIColor *(float f) {

        CGColorRef startColorRef = [self.gradientStartColor CGColor];
        
        
        const CGFloat *componentsStartColor = CGColorGetComponents(startColorRef);
        CGFloat sr = componentsStartColor[0]*255;
        CGFloat sg = componentsStartColor[1]*255;
        CGFloat sb = componentsStartColor[2]*255;
        
        CGColorRef endColorRef = [self.gradientEndColor CGColor];
        const CGFloat *componentsEndColor = CGColorGetComponents(endColorRef);
        CGFloat er = componentsEndColor[0]*255;
        CGFloat eg = componentsEndColor[1]*255;
        CGFloat eb = componentsEndColor[2]*255;
        
        return [UIColor colorWithRed:(f*sr+(1-f)*er)/255. green:(f*sg+(1-f)*eg)/255. blue:(f*sb+(1-f)*eb)/255. alpha:1];
    } withSubdiv:80 withCenter:CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r)) withScale:1];
    
}


//AngularGradient
//http://stackoverflow.com/questions/11783114/draw-outer-half-circle-with-gradient-using-core-graphics-in-ios

typedef void (^voidBlock)(void);
typedef float (^floatfloatBlock)(float);
typedef UIColor * (^floatColorBlock)(float);

-(CGPoint) pointForTrapezoidWithAngle:(float)a andRadius:(float)r  forCenter:(CGPoint)p{
    return CGPointMake(p.x + r*cos(a), p.y + r*sin(a));
}

//subdivCount: Number of trapezoids per layer. More trapezoids == smoother view == more processing
-(void)drawGradientInContext:(CGContextRef)ctx  startingAngle:(float)a endingAngle:(float)b intRadius:(floatfloatBlock)intRadiusBlock outRadius:(floatfloatBlock)outRadiusBlock withGradientBlock:(floatColorBlock)colorBlock withSubdiv:(int)subdivCount withCenter:(CGPoint)center withScale:(float)scale
{
    float angleDelta = (b-a)/subdivCount;
    float fractionDelta = 1.0/subdivCount;
    
    CGPoint p0,p1,p2,p3, p4,p5;
    float currentAngle=a;
    p4=p0 = [self pointForTrapezoidWithAngle:currentAngle andRadius:intRadiusBlock(0) forCenter:center];
    p5=p3 = [self pointForTrapezoidWithAngle:currentAngle andRadius:outRadiusBlock(0) forCenter:center];
    CGMutablePathRef innerEnveloppe=CGPathCreateMutable(),
    outerEnveloppe=CGPathCreateMutable();
    
    CGPathMoveToPoint(outerEnveloppe, 0, p3.x, p3.y);
    CGPathMoveToPoint(innerEnveloppe, 0, p0.x, p0.y);
    CGContextSaveGState(ctx);
    
    CGContextSetLineWidth(ctx, 1);
    
    for (int i=0;i<subdivCount;i++)
    {
        float fraction = (float)i/subdivCount;
        currentAngle=a+fraction*(b-a);
        CGMutablePathRef trapezoid = CGPathCreateMutable();
        
        p1 = [self pointForTrapezoidWithAngle:currentAngle+angleDelta andRadius:intRadiusBlock(fraction+fractionDelta) forCenter:center];
        p2 = [self pointForTrapezoidWithAngle:currentAngle+angleDelta andRadius:outRadiusBlock(fraction+fractionDelta) forCenter:center];
        
        CGPathMoveToPoint(trapezoid, 0, p0.x, p0.y);
        CGPathAddLineToPoint(trapezoid, 0, p1.x, p1.y);
        CGPathAddLineToPoint(trapezoid, 0, p2.x, p2.y);
        CGPathAddLineToPoint(trapezoid, 0, p3.x, p3.y);
        CGPathCloseSubpath(trapezoid);
        
        CGPoint centerofTrapezoid = CGPointMake((p0.x+p1.x+p2.x+p3.x)/4, (p0.y+p1.y+p2.y+p3.y)/4);
        
        CGAffineTransform t = CGAffineTransformMakeTranslation(-centerofTrapezoid.x, -centerofTrapezoid.y);
        CGAffineTransform s = CGAffineTransformMakeScale(scale, scale);
        CGAffineTransform concat = CGAffineTransformConcat(t, CGAffineTransformConcat(s, CGAffineTransformInvert(t)));
        CGPathRef scaledPath = CGPathCreateCopyByTransformingPath(trapezoid, &concat);
        
        CGContextAddPath(ctx, scaledPath);
        CGContextSetFillColorWithColor(ctx,colorBlock(fraction).CGColor);
        CGContextSetStrokeColorWithColor(ctx, colorBlock(fraction).CGColor);
        CGContextSetMiterLimit(ctx, 0);
        
        CGContextDrawPath(ctx, kCGPathFillStroke);
        
        p0=p1;
        p3=p2;
        
        CGPathAddLineToPoint(outerEnveloppe, 0, p3.x, p3.y);
        CGPathAddLineToPoint(innerEnveloppe, 0, p0.x, p0.y);
        
        //Release the CGPaths
        CGPathRelease(trapezoid);
        CGPathRelease(scaledPath);
    }
    
    //stroke width
    CGContextSetLineWidth(ctx, 0.0001);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextAddPath(ctx, outerEnveloppe);
    CGContextAddPath(ctx, innerEnveloppe);
    CGContextMoveToPoint(ctx, p0.x, p0.y);
    CGContextAddLineToPoint(ctx, p3.x, p3.y);
    CGContextMoveToPoint(ctx, p4.x, p4.y);
    CGContextAddLineToPoint(ctx, p5.x, p5.y);
    CGContextStrokePath(ctx);
    
    //Cleanup
    CGPathRelease(innerEnveloppe);
    CGPathRelease(outerEnveloppe);

}



@end
