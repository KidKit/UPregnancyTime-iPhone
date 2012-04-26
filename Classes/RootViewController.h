//
//  RootViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "LabelConverter.h"
#import "UPTContentView.h"
#import "DaliyTipsViewController.h"
#import "HomeViewController.h"
#import "TimeLineViewController.h"
#import "QAViewController.h"
#import "SearchViewController.h"
#import "BookmarkTableViewController.h"
#import "SettingViewController.h"
#import "MenuViewController.h"
#import "RootViewDelegate.h"



@interface RootViewController : UIViewController<UIScrollViewDelegate,RootViewDelegate>
{
    
}
@property (nonatomic,assign)NSString *currentViewControllerKey;
@property (nonatomic,retain)MenuViewController *menuController;
@property (nonatomic,retain)TimeLineViewController *timelineController;
@property (nonatomic,retain)IBOutlet UPTContentView *contentView;
@property (nonatomic,retain)NSMutableDictionary *functionControllers;


@end


