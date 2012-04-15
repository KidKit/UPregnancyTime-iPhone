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
#import "PregnancyPeriod.h"
#import "TipsViewController.h"
#import "AHomeView.h"
#import "CalendarView.h"
#import "NSDate+Helper.h"
#import "RootViewDelegate.h"


@interface HomeViewController : UIViewController<AHomeViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
}
@property (nonatomic,retain) NSArray *tipsTypes;
@property (nonatomic,retain) NSArray *tips;
@property (nonatomic,readwrite)CGPoint startPoint;
@property (nonatomic,retain) NSDate *currentDate;
@property (nonatomic,retain)CalendarView *dayLabel;
@property (nonatomic,retain)PregnancyPeriod *period;
@property (nonatomic,retain) NSMutableArray *tipsViews;
@property (nonatomic,assign) id<RootViewDelegate>rootDelegate;

@property (nonatomic,retain)IBOutlet UITableView *tipsTableView;



@end
