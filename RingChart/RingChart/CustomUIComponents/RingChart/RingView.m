//
//  RingView.m
//  RingChart
//
//  Created by Max Ueda on 9/4/15.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//
//  Based on  Pavan Podila's Pie Chart (https://github.com/pavanpodila/PieChart )
//
//
//Drawing Rings:
//http://stackoverflow.com/questions/25932943/weird-behaviour-of-fill-method-in-different-kinds-of-uibezierpath

#import <QuartzCore/QuartzCore.h>
#import "RingView.h"
#import "RingSliceLayer.h"

@interface RingView() {
	NSMutableArray *_normalizedValues;
	CALayer *_containerLayer;
}

-(void)updateSlices;
@end

@implementation RingView
@synthesize sliceValues = _sliceValues;




-(void)doInitialSetup {
	_containerLayer = [CAShapeLayer layer];
    //Shadow parameters.
    _containerLayer.shadowOffset = CGSizeMake(0, 12);
    _containerLayer.shadowRadius = 15.0;
    _containerLayer.shadowColor = [UIColor blackColor].CGColor;
    _containerLayer.shadowOpacity = .75;
    _containerLayer.contentsScale = [[UIScreen mainScreen] scale];
   
    [self.layer addSublayer:_containerLayer];

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self doInitialSetup];
    }
	
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self doInitialSetup];
	}
	
	return self;
}

-(void) dealloc
{
    _containerLayer = nil;
    _sliceValues = nil;
    _normalizedValues = nil;
}

-(id)initWithSliceValues:(NSArray *)sliceValues {
	if (self) {
		[self doInitialSetup];
		self.sliceValues = sliceValues;
	}
	
	return self;
}

-(void)setSliceValues:(NSArray *)sliceValues {
	_sliceValues = sliceValues;
	
	_normalizedValues = [NSMutableArray array];
	if (sliceValues) {

		// total
		CGFloat total = 0.0;
		for (NSNumber *num in sliceValues) {
			total += num.floatValue;
		}
		
		// normalize
		for (NSNumber *num in sliceValues) {
			[_normalizedValues addObject:[NSNumber numberWithFloat:num.floatValue/total]];
		}
	}
	
	[self updateSlices];
}


-(void)updateSlices
{
    _containerLayer.frame = self.bounds;
	// Adjust number of slices
	if (_normalizedValues.count > _containerLayer.sublayers.count) {
		long count = _normalizedValues.count - _containerLayer.sublayers.count;
		for (int i = 0; i < count; i++) {
			RingSliceLayer *slice = [RingSliceLayer layer];
            //To prevent aliasing effects with retina screens
            slice.contentsScale =  [[UIScreen mainScreen] scale];
			slice.frame = self.bounds;
            
			[_containerLayer addSublayer:slice];
		}
	}
    
	else if (_normalizedValues.count < _containerLayer.sublayers.count) {
		long count = _containerLayer.sublayers.count - _normalizedValues.count;

		for (int i = 0; i < count; i++) {
			[[_containerLayer.sublayers objectAtIndex:0] removeFromSuperlayer];
		}
	}
	
	// Set the angles on the slices (radians)
	CGFloat startAngle =3*M_PI/2;
	int index = 0;
	for (NSNumber *num in _normalizedValues)
    {
        NSDictionary* colors = [self.sliceColors objectAtIndex: index];
        if(!colors)
        {
            UIColor *gradientStartColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.85];
            UIColor *gradientEndColor = [UIColor colorWithRed: 119/255 green: 136/255 blue: 153/255 alpha:0.25];
            
            colors = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: gradientStartColor, gradientEndColor, nil] forKeys: [NSArray arrayWithObjects: @"gradientStartColor", @"gradientEndColor", nil]];
        }
        
		CGFloat angle = num.floatValue * 2 * M_PI;

		RingSliceLayer *slice = (RingSliceLayer*)[_containerLayer.sublayers objectAtIndex:index];
		slice.startAngle = startAngle;
		slice.endAngle = startAngle + angle;
        //slice.gradientStartColor = [colors objectForKey:@"gradientStartColor"];
        //slice.gradientEndColor = [colors objectForKey:@"gradientEndColor"];
        
        //float er = 130, eg= 247, eb = 255;
        //float sr = 34, sg = 184, sb = 237;
        [slice setGradientStartColor: [colors objectForKey: @"gradientStartColor"]];
        [slice setGradientEndColor: [colors objectForKey: @"gradientEndColor"]];
		startAngle += angle;
		index++;
	}
}


@end
