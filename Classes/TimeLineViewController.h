//
//  TimeLineViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "DatabaseAccess.h"
#import "CalendarView.h"
#import "PregnancyPeriod.h"
#import "RootViewDelegate.h"

@interface TimeLineViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain)IBOutlet UIView *pointerView;
@property (nonatomic,retain)PregnancyPeriod *period;
@property (nonatomic,assign) id<RootViewDelegate>rootDelegate;
@end
