//
//  CalendarView.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CalendarView.h"

@implementation CalendarView
@synthesize currentDateLabel=_currentDateLabel;
@synthesize weekLabel = _weekLabel;
@synthesize dateLabel = _dateLabel;
@synthesize dayLabelBgImage = _dayLabelBgImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *labelBg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_1"]] autorelease];
        [_currentDateLabel addSubview:labelBg];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)populateWithDate:(NSDate *)currentDate sequenceInWeek:(int)sequenceInWeek sequenceInDate:(int)sequenceInDate{
    NSString *currentDateString = [currentDate stringWithFormat:[NSDate dateFormatStringCN]];
    NSString *weekly = [NSString stringWithFormat:@"第%d周",sequenceInWeek];
    NSString *daliy = [NSString stringWithFormat:@"第%d天",sequenceInDate];
    if(![weekly isEqualToString:_weekLabel.text]){
        [UIView transitionWithView:_weekLabel duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            _weekLabel.text = weekly;
        }completion:NULL];
    }
    if(![daliy isEqualToString:_dateLabel.text]){
        [UIView transitionWithView:_dateLabel duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            _dateLabel.text = daliy;
        }completion:NULL];
    }
    if(![currentDateString isEqualToString:_currentDateLabel.text]){
        [UIView transitionWithView:_currentDateLabel duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            _currentDateLabel.text = currentDateString;
        }completion:NULL];
    }
    
}

@end
