//
//  DaliyTipsViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaliyTipsViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,retain)IBOutlet UIView *calendarView;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;

@end
