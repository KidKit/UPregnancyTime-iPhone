//
//  SettingViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewDelegate.h"
#import "IASKAppSettingsViewController.h"

@interface SettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) id<RootViewDelegate>rootDelegate;
@end
