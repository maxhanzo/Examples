//
//  ViewController.m
//  LF Gen
//
//  Created by Ticket Services on 04/07/17.
//  Copyright © 2017 Ticket. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.longShots = [NSMutableDictionary dictionaryWithDictionary: @{ @"01": @0,
                                                                       @"02": @0,
                                                                       @"03": @0,
                                                                       @"04": @0,
                                                                       @"05": @0,
                                                                       @"06": @0,
                                                                       @"07": @0,
                                                                       @"08": @0,
                                                                       @"09": @0,
                                                                       @"10": @0,
                                                                       @"11": @0,
                                                                       @"12": @0,
                                                                       @"13": @0,
                                                                       @"14": @0,
                                                                       @"15": @0,
                                                                       @"16": @0,
                                                                       @"17": @0,
                                                                       @"18": @0,
                                                                       @"19": @0,
                                                                       @"20": @0,
                                                                       @"21": @0,
                                                                       @"22": @0,
                                                                       @"23": @0,
                                                                       @"24": @0,
                                                                       @"25": @0,
                                  
                                                                       
                                                                       
                                                                       }];
    
    NSDictionary *lastStreaks = @{@"1": @[@"1", @"2", @"3", @"8", @"9",@"10", @"11", @"12", @"13", @"14",@"17", @"18", @"20", @"22", @"25"],
                                  @"2": @[@"1", @"2", @"3", @"4", @"7",@"8", @"10", @"11", @"13", @"14",@"15", @"19", @"22", @"23", @"24"],
                                  @"3": @[@"2", @"4", @"5", @"7", @"9",@"10", @"12", @"14", @"15", @"16",@"18", @"20", @"22", @"23", @"24"],
                                  @"4": @[@"2", @"3", @"4", @"5", @"8",@"11", @"13", @"14", @"16", @"17",@"18", @"19", @"20", @"21", @"24"],
                                  @"5": @[@"1", @"2", @"4", @"5", @"6",@"8", @"9", @"10", @"17", @"18",@"20", @"21", @"23", @"24", @"25"],
                                  @"6": @[@"1", @"2", @"3", @"5", @"6",@"7", @"9", @"10", @"14", @"15",@"20", @"21", @"22", @"24", @"25"],
                                  @"7": @[@"5", @"7", @"8", @"9", @"10",@"11", @"13", @"15", @"17", @"18",@"20", @"21", @"22", @"23", @"25"],
                                  @"8": @[@"1", @"2", @"4", @"5", @"8",@"10", @"12", @"14", @"15", @"18",@"19", @"20", @"21", @"22", @"25"],
                                  @"9": @[@"1", @"3", @"5", @"6", @"7",@"8", @"9", @"10", @"13", @"14",@"20", @"22", @"23", @"24", @"25"],
                                  @"10": @[@"3", @"5", @"6", @"7", @"9",@"10", @"12", @"13", @"14", @"16",@"18", @"19", @"21", @"23", @"25"]/*,
                                  @"11": @[@"01", @"08", @"09", @"10", @"11",@"13", @"14", @"15", @"16", @"18",@"19", @"20", @"21", @"23", @"24"],
                                  @"12":@[@"01", @"02", @"03", @"04", @"05",@"07", @"08", @"12", @"14", @"15",@"17", @"19", @"20", @"23", @"24"]*/
                                  };
    
    [self analyseDrawings:lastStreaks];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) analyseDrawings: (NSDictionary*) drawings
{
    NSArray* allDrawings = (NSArray*)[drawings allValues];
    for(NSArray* drawing in allDrawings)
    {
        for(NSString* key in drawing)
        {
            NSNumber* longShot = [self.longShots objectForKey: key];
            if(self.longShots)
            {
                [self.longShots setObject:  [NSNumber numberWithFloat:([longShot floatValue] + 1)] forKey: key];
            }
        }
    }
}

-(NSArray*) findLongShots
{
    NSArray *allKeys = [self.longShots allKeys];
    NSMutableArray *myLongShots = [NSMutableArray array];
    for(NSString* key in allKeys)
    {
        NSNumber *potentialLongshot = [(NSNumber*) self.longShots valueForKey: key];
        if(potentialLongshot)
        {
            NSInteger occurences = [potentialLongshot integerValue];
            if(occurences >7)
            {
                [myLongShots addObject: key];
            }
        }
    }
    return (NSArray*) myLongShots;
}

-(NSDictionary*) generateLF: (NSArray*) longShots
{
    NSMutableDictionary *allStrategies = [NSMutableDictionary dictionaryWithDictionary:@{@"oddLow": @[],
                                                                                         @"oddHigh": @[],
                                                                                         @"evenLow": @[],
                                                                                          @"evenHigh": @[]}];
    
    return allStrategies;
    
}


-(NSArray*) generateOddLow: (NSArray*) longShots
{
    NSMutableArray *oddLow = [NSMutableArray array]; //4
    NSMutableArray *oddHigh = [NSMutableArray array]; //4
    NSMutableArray *evenLow = [NSMutableArray array]; //4
    NSMutableArray *evenHigh = [NSMutableArray array]; //3
    
    int oddLowCount = 4;
    int oddHighCount = 4;
    int evenLowCount = 4;
    int evenHighCount = 3;
    
    for(NSString *longShot in longShots)
    {
        NSInteger myLongShot = [longShot integerValue];
        if((myLongShot%2)!=0)
        {
            if(myLongShot<12)
            {
                [oddLow addObject: longShot];
                oddLowCount--;
            }
            
            else
            {
                [oddHigh addObject: longShot];
                oddHighCount--;
            }
        }
        
        else
        {
            if(myLongShot<12)
            {
                [evenLow addObject: longShot];
                evenLowCount--;
            }
            
            else
            {
                [evenHigh addObject: longShot];
                evenHighCount--;
            }

        }
    }
    
    while(oddLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddLow containsObject:myRandomGuess ])
        {
            oddLowCount--;
            [oddLow addObject: myRandomGuess];
        }
    }
    
    while(oddHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddHigh containsObject:myRandomGuess ])
        {
            oddHighCount--;
            [oddHigh addObject: myRandomGuess];
        }
    }
    
    while(evenLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenLow containsObject:myRandomGuess ])
        {
            evenLowCount--;
            [evenLow addObject: myRandomGuess];
        }
    }
    
    while(evenHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenHigh containsObject:myRandomGuess ])
        {
            evenHighCount--;
            [evenHigh addObject: myRandomGuess];
        }
    }
    
    NSArray *winningBet = [[[oddLow arrayByAddingObjectsFromArray:evenLow] arrayByAddingObjectsFromArray:oddHigh] arrayByAddingObjectsFromArray:evenHigh];
    
    NSLog(@"%@", winningBet);
    return winningBet;
}

-(NSArray*) generateOddHigh: (NSArray*) longShots
{
    NSMutableArray *oddLow = [NSMutableArray array]; //4
    NSMutableArray *oddHigh = [NSMutableArray array]; //4
    NSMutableArray *evenLow = [NSMutableArray array]; //3
    NSMutableArray *evenHigh = [NSMutableArray array]; //4
    
    int oddLowCount = 4;
    int oddHighCount = 4;
    int evenLowCount = 3;
    int evenHighCount = 4;
    
    for(NSString *longShot in longShots)
    {
        NSInteger myLongShot = [longShot integerValue];
        if((myLongShot%2)!=0)
        {
            if(myLongShot<12)
            {
                [oddLow addObject: longShot];
                oddLowCount--;
            }
            
            else
            {
                [oddHigh addObject: longShot];
                oddHighCount--;
            }
        }
        
        else
        {
            if(myLongShot<12)
            {
                [evenLow addObject: longShot];
                evenLowCount--;
            }
            
            else
            {
                [evenHigh addObject: longShot];
                evenHighCount--;
            }
            
        }
    }
    
    while(oddLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddLow containsObject:myRandomGuess ])
        {
            oddLowCount--;
            [oddLow addObject: myRandomGuess];
        }
    }
    
    while(oddHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddHigh containsObject:myRandomGuess ])
        {
            oddHighCount--;
            [oddHigh addObject: myRandomGuess];
        }
    }
    
    while(evenLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenLow containsObject:myRandomGuess ])
        {
            evenLowCount--;
            [evenLow addObject: myRandomGuess];
        }
    }
    
    while(evenHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenHigh containsObject:myRandomGuess ])
        {
            evenHighCount--;
            [evenHigh addObject: myRandomGuess];
        }
    }
    
    NSArray *winningBet = [[[oddLow arrayByAddingObjectsFromArray:evenLow] arrayByAddingObjectsFromArray:oddHigh] arrayByAddingObjectsFromArray:evenHigh];
    
    NSLog(@"%@", winningBet);
    return winningBet;
}


-(NSArray*) generateEvenLow: (NSArray*) longShots
{
    NSMutableArray *oddLow = [NSMutableArray array]; //4
    NSMutableArray *oddHigh = [NSMutableArray array]; //3
    NSMutableArray *evenLow = [NSMutableArray array]; //4
    NSMutableArray *evenHigh = [NSMutableArray array]; //4
    
    int oddLowCount = 3;
    int oddHighCount = 4;
    int evenLowCount = 4;
    int evenHighCount = 4;
    
    for(NSString *longShot in longShots)
    {
        NSInteger myLongShot = [longShot integerValue];
        if((myLongShot%2)!=0)
        {
            if(myLongShot<12)
            {
                [oddLow addObject: longShot];
                oddLowCount--;
            }
            
            else
            {
                [oddHigh addObject: longShot];
                oddHighCount--;
            }
        }
        
        else
        {
            if(myLongShot<12)
            {
                [evenLow addObject: longShot];
                evenLowCount--;
            }
            
            else
            {
                [evenHigh addObject: longShot];
                evenHighCount--;
            }
            
        }
    }
    
    while(oddLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddLow containsObject:myRandomGuess ])
        {
            oddLowCount--;
            [oddLow addObject: myRandomGuess];
        }
    }
    
    while(oddHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddHigh containsObject:myRandomGuess ])
        {
            oddHighCount--;
            [oddHigh addObject: myRandomGuess];
        }
    }
    
    while(evenLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenLow containsObject:myRandomGuess ])
        {
            evenLowCount--;
            [evenLow addObject: myRandomGuess];
        }
    }
    
    while(evenHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenHigh containsObject:myRandomGuess ])
        {
            evenHighCount--;
            [evenHigh addObject: myRandomGuess];
        }
    }
    
    NSArray *winningBet = [[[oddLow arrayByAddingObjectsFromArray:evenLow] arrayByAddingObjectsFromArray:oddHigh] arrayByAddingObjectsFromArray:evenHigh];
    
    NSLog(@"%@", winningBet);
    return winningBet;
}


-(NSArray*) generateEvenHigh: (NSArray*) longShots
{
    NSMutableArray *oddLow = [NSMutableArray array]; //3
    NSMutableArray *oddHigh = [NSMutableArray array]; //4
    NSMutableArray *evenLow = [NSMutableArray array]; //4
    NSMutableArray *evenHigh = [NSMutableArray array]; //4
    
    int oddLowCount = 3;
    int oddHighCount = 4;
    int evenLowCount = 4;
    int evenHighCount = 4;
    
    for(NSString *longShot in longShots)
    {
        NSInteger myLongShot = [longShot integerValue];
        if((myLongShot%2)!=0)
        {
            if(myLongShot<12)
            {
                [oddLow addObject: longShot];
                oddLowCount--;
            }
            
            else
            {
                [oddHigh addObject: longShot];
                oddHighCount--;
            }
        }
        
        else
        {
            if(myLongShot<12)
            {
                [evenLow addObject: longShot];
                evenLowCount--;
            }
            
            else
            {
                [evenHigh addObject: longShot];
                evenHighCount--;
            }
            
        }
    }
    
    while(oddLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddLow containsObject:myRandomGuess ])
        {
            oddLowCount--;
            [oddLow addObject: myRandomGuess];
        }
    }
    
    while(oddHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:NO];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [oddHigh containsObject:myRandomGuess ])
        {
            oddHighCount--;
            [oddHigh addObject: myRandomGuess];
        }
    }
    
    while(evenLowCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:1 upperBound:12 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenLow containsObject:myRandomGuess ])
        {
            evenLowCount--;
            [evenLow addObject: myRandomGuess];
        }
    }
    
    while(evenHighCount!=0)
    {
        NSInteger randomGuess = [ViewController generateRandomNumberWithLowerBound:13 upperBound:25 even:YES];
        NSString *myRandomGuess = [NSString stringWithFormat: @"%li", (long)randomGuess];
        if(! [evenHigh containsObject:myRandomGuess ])
        {
            evenHighCount--;
            [evenHigh addObject: myRandomGuess];
        }
    }
    
    NSArray *winningBet = [[[oddLow arrayByAddingObjectsFromArray:evenLow] arrayByAddingObjectsFromArray:oddHigh] arrayByAddingObjectsFromArray:evenHigh];
    
    NSLog(@"%@", winningBet);
    return winningBet;
}


+(NSInteger) generateRandomNumberWithLowerBound:(NSInteger)lowerBound
                               upperBound:(NSInteger)upperBound
                                           even: (BOOL) even

{
    NSInteger rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    if(even)
    {
        NSInteger result = (rndValue/2)*2;
        if (result != 0)
        {
            return result;
        }
        
        return 2;
    }
    
    return (((rndValue/2)*2) + 1);
}

-(IBAction) generate: (id) sender
{
    
    NSArray *myGuessOL = [self generateOddLow: [self findLongShots]];
    NSLog(@"OL: %@", myGuessOL);
    NSArray *myGuessOH = [self generateOddHigh: [self findLongShots]];
    NSLog(@"OH %@", myGuessOH);
    NSArray *myGuessEL = [self generateEvenLow: [self findLongShots]];
    NSLog(@"EL %@", myGuessEL);
    NSArray *myGuessEH = [self generateEvenHigh: [self findLongShots]];
    NSLog(@"EH %@", myGuessEH);
    
}

@end
