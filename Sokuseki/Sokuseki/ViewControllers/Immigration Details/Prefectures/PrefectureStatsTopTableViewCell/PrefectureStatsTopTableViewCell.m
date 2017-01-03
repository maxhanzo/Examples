//
//  PrefectureStatsTopTableViewCell.m
//  Sokuseki
//
//  Created by Max Ueda on 26/12/16.
//  Copyright © 2016 UedaSoft IT Solutions. All rights reserved.
//

#import "PrefectureStatsTopTableViewCell.h"
#import "Utilities.h"


#define barWidth 136.0f
#define barHeight 22.0f
#define labelX 271
#define labelY 4
#define barPoint CGPointMake(133, 4)
@implementation PrefectureStatsTopTableViewCell
@synthesize lblNumberOfPeople, lblPrefectureName, vwBarView, imgPrefectureFlag, numberOfPeople;
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
    lblNumberOfPeople.text = [numberOfImmigrants stringValue];
    lblPrefectureName.text = prefectureName;
}

-(void) setPrefectureDataWithPrefecture: (PrefectureStatistics*) prefecture
{
    numberOfPeople = [prefecture.numberOfImmigrants integerValue];
    lblNumberOfPeople.text = [prefecture.numberOfImmigrants stringValue];
    lblPrefectureName.text = prefecture.name;
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
    
    CGFloat barNewWidth = barWidth*percentage/100;
    
    if(barNewWidth<4)
    {
        barNewWidth = 4;
    }
    vwBarView.frame = CGRectMake(barPoint.x, barPoint.y, barNewWidth, barHeight);
    
    CGFloat delta = barWidth - barNewWidth;
    
    CGSize lblNumberOfPeopleSize = lblNumberOfPeople.frame.size;
    lblNumberOfPeople.frame = CGRectMake(labelX - delta, labelY, lblNumberOfPeopleSize.width, lblNumberOfPeopleSize.height);
}
+(float) rowHeight
{
    return 30.0f;
}
@end
