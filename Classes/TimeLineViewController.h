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
#import "PregnacyPeriod.h"

@interface TimeLineViewController : UIViewController<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,retain)IBOutlet UITableView *scrollView;
@property (nonatomic,retain)CalendarView *dayLabel;
@property (nonatomic,retain)PregnacyPeriod *period;
@end
