//
//  PrefectureStatsTopTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureStatsTopTableViewCell.h"
#import "Utilities.h"

@implementation PrefectureStatsTopTableViewCell
@synthesize lblPrefectureName, vwBarView, imgPrefectureFlag, numberOfPeople;
- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void) setPrefectureDataWithName: (NSString*) prefectureName withNumberOfImmigrants: (NSNumber*) numberOfImmigrants
{
    numberOfPeople = [numberOfImmigrants integerValue];
    NSString* prefectureInfo = [NSString stringWithFormat: @"%@ • %@", prefectureName,  [numberOfImmigrants stringValue]];
    
    lblPrefectureName.text = prefectureInfo;
    
}

-(void) setPrefectureDataWithPrefecture: (PrefectureStatistics*) prefecture
{
    numberOfPeople = [prefecture.numberOfImmigrants integerValue];
    
    NSString* prefectureInfo = [NSString stringWithFormat: @"%@ • %@", prefecture.name,  [prefecture.numberOfImmigrants stringValue]];
    
    lblPrefectureName.text = prefectureInfo;
    imgPrefectureFlag.image = [Utilities flagForPrefectureName:prefecture.name];
}


-(void) setBarColor: (UIColor*) color
{
    vwBarView.backgroundColor = color;
}

-(void) resizePercentageBarWithTotalValue: (NSNumber*) totalValue
{
    float currentNumber = (float) numberOfPeople;
    float total = [totalValue floatValue];
    float percentage = (currentNumber*100)/total;
    
    CGFloat barNewWidth = vwBarView.frame.size.width*percentage/100;
    
    if(barNewWidth<4)
    {
        barNewWidth = 4;
    }
    vwBarView.frame = CGRectMake(vwBarView.frame.origin.x, vwBarView.frame.origin.y, barNewWidth, vwBarView.frame.size.height);
    
}
+(float) rowHeight
{
    return 44.0f;
}
@end
