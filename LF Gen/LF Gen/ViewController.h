//
//  ViewController.h
//  LF Gen
//
//  Created by Ticket Services on 04/07/17.
//  Copyright © 2017 Ticket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, strong) NSMutableDictionary* longShots;

-(void) analyseDrawings: (NSDictionary*) drawings;

+(NSInteger) generateRandomNumberWithLowerBound:(NSInteger)lowerBound
                                     upperBound:(NSInteger)upperBound
                                           even: (BOOL) even;

@end

