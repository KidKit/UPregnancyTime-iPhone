//
//  UBTAppDelegate.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "PeriodSettingViewController.h"
#import "CommonDataHolder.h"

@interface UBTAppDelegate : UIResponder <UIApplicationDelegate,PeriodSettingDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
