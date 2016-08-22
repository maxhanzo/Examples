//
//  ViewController.m
//  RingChart
//
//  Created by Max Ueda on 8/21/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //First step: Choose gradient Start and End colors as UIColors. Each slice (CALayer) will have two colors.
    //These are the colors for the first slice
    UIColor *gradientStartColor = [UIColor colorWithRed: 119/255 green: 136/255 blue: 153/255 alpha:1];
    UIColor *gradientEndColor = [UIColor colorWithRed:198/255 green:226/255 blue:255/255 alpha:1];
    
    NSDictionary *firstLayerColors = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: gradientStartColor, gradientEndColor, nil] forKeys: [NSArray arrayWithObjects: @"gradientStartColor", @"gradientEndColor", nil]];
    
    //And these for the second slice.
    UIColor *secondLayerGradientStartColor = [UIColor colorWithRed:0.5 green:0.4 blue:0.3 alpha:1];
    UIColor *secondLayerGradientEndColor = [UIColor colorWithRed: 0.6 green: 0.6 blue: 0.6 alpha:1];
    
    //Each slice will need a NSDictionary containing the gradient colors. The keys are gradientStartColor and gradientEndColor
    NSDictionary *secondLayerColors = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: secondLayerGradientStartColor, secondLayerGradientEndColor, nil] forKeys: [NSArray arrayWithObjects: @"gradientStartColor", @"gradientEndColor", nil]];
    
    //Setting the array containing the dictionary with the gradient colors for each slice
    self.ringView.sliceColors = [NSArray arrayWithObjects: firstLayerColors, secondLayerColors, nil];
    
    //Setting the slices' values
    self.ringView.sliceValues =   [NSArray arrayWithObjects :@45, @55, nil];

    NSNumber* leftValue = [self.ringView.sliceValues lastObject ];
    NSString* strLeftValue = [self stringWithNumber: leftValue];
    [self.lblLeftValue setText:  [NSString stringWithFormat: @"%@%%", strLeftValue]];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray*) generateRandomValues
{
    float max = 99.0f;
    
    NSMutableArray* sliceValuesArray = [NSMutableArray array];
    
    float sliceValue = (float)rand()/(float)(RAND_MAX) * max;
    [sliceValuesArray addObject: [NSNumber numberWithFloat: sliceValue]];
    [sliceValuesArray addObject: [NSNumber numberWithFloat: (100 - sliceValue)]];

    return (NSArray*)sliceValuesArray;
}

-(IBAction)btnRandomValues:(id)sender
{
    //Updating the slice values will animate the ring view.
    self.ringView.sliceValues = [self generateRandomValues];
    NSNumber* leftValue = [self.ringView.sliceValues lastObject];
    NSString* strLeftValue = [self stringWithNumber: leftValue];
    [self.lblLeftValue setText:  [NSString stringWithFormat: @"%@%%", strLeftValue]];
}

-(NSString*) stringWithNumber: (NSNumber*) number
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setMinimumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundDown];
    return [formatter stringFromNumber:number];
}
@end
