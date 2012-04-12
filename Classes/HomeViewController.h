//
//  HomeViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "DatabaseAccess.h"
#import "PregnancyDaliyTips.h"
#import "PregnancyDaliyTipsType.h"
#import "PregnacyPeriod.h"
#import "TipsViewController.h"
#import "AHomeView.h"
#import "CalendarView.h"
#import "NSDate+Helper.h"


@interface HomeViewController : UIViewController<TipsDetailViewDelegate,AHomeViewDelegate>
{
}
@property (nonatomic,retain) NSArray *tipsTypes;
@property (nonatomic,retain) NSArray *tips;
@property (nonatomic,readwrite)CGPoint startPoint;
@property (nonatomic,retain) NSMutableArray *tipsViews;
@property (nonatomic,retain) NSDate *currentDate;

@property (nonatomic,retain)CalendarView *dayLabel;

@property (nonatomic,retain)PregnacyPeriod *period;



@end
