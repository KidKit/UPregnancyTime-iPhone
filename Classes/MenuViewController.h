//
//  MenuViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "LabelConverter.h"
#import "RootViewDelegate.h"

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain)NSArray *labelInfos;
@property (nonatomic,retain)IBOutlet UITableView *tableView;
@property (nonatomic,assign)id<RootViewDelegate>rootDelegate;
@end
