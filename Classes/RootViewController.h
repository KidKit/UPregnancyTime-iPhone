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
#import "HomeViewController.h"
#import "TimeLineViewController.h"
#import "QAViewController.h"
#import "SearchViewController.h"

@interface RootViewController : UIViewController
{
    UINavigationController *_homeController;
    UINavigationController *_timeLineController;
    UINavigationController *_qaController;
    UINavigationController *_searchController;
}
@property (nonatomic,retain)IBOutlet UIView *navView;
@property (nonatomic,retain)IBOutlet UIScrollView *contentView;
@property (nonatomic,retain)UIViewController *currentViewController;

-(IBAction)didNavLabelClick:(id)sender;

@end
