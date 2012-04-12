//
//  CalendarView.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+Helper.h"

@interface CalendarView : UIView

@property (nonatomic,retain)IBOutlet UILabel *currentDateLabel;
@property (nonatomic,retain)IBOutlet UILabel *weekLabel;
@property (nonatomic,retain)IBOutlet UILabel *dateLabel;
@property (nonatomic,retain)IBOutlet UIImageView *dayLabelBgImage;

-(void)populateWithDate:(NSDate *)currentDate sequenceInWeek:(int)sequenceInWeek sequenceInDate:(int)sequenceInDate;
@end
