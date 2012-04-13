//
//  QAViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayViewController.h"

@interface QAViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,OverlayViewControllerDelegate>

@property (nonatomic,retain)IBOutlet UIView *mainView;
@property (nonatomic,retain)IBOutlet UIView *searchView;
@property (nonatomic,retain)IBOutlet UITableView *resultView;
@property (nonatomic,retain)IBOutlet UITextField *searchTextField;
@property (nonatomic,retain)OverlayViewController *overlay;
@end
