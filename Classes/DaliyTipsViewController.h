//
//  DaliyTipsViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "UIImage+Resize.h"
#import "TipsArticleView.h"
#import "DatabaseAccess.h"
#import "PregnancyDaliyTips.h"
#import "PregnancyPeriod.h"
#import "NSDate+Helper.h"
#import "RootViewDelegate.h"
#import "MBProgressHUD.h"

@interface DaliyTipsViewController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate>

@property(nonatomic,retain)IBOutlet UIView *calendarView;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UILabel *weekLabel;
@property(nonatomic,retain)IBOutlet UILabel *dayLabel;
@property(nonatomic,retain)IBOutlet UILabel *dayAndWeekIndexLabel;
@property(nonatomic,retain)IBOutlet UIPageControl *pageControl;

@property (nonatomic,retain) NSArray *tips;
@property (nonatomic,retain) NSDate *currentDate;
@property (nonatomic,retain)PregnancyPeriod *period;
@property (nonatomic,retain) NSMutableArray *tipsViews;

-(void)gotoTipsViewByDay:(NSNumber *)day;
@end
