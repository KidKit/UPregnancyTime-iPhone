//
//  QAViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QAViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)IBOutlet UIView *searchView;
@property (nonatomic,retain)IBOutlet UITableView *resultView;
@end
