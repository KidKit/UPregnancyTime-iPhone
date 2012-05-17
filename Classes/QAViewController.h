//
//  QAViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OverlayViewController.h"
#import "SearchResultViewController.h"
#import "RootViewDelegate.h"
#import "MBProgressHUD.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "DatabaseAccess.h"
#import "SearchHistory.h"
#import "NSDate+Helper.h"
#import "NSURL+Addition.h"

@interface QAViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,OverlayViewControllerDelegate>

@property (nonatomic,retain)IBOutlet UIView *mainView;
@property (nonatomic,retain)IBOutlet UIView *searchView;
@property (nonatomic,retain)IBOutlet UIView *hotWordsTitleView;
@property (nonatomic,retain)IBOutlet UIScrollView *hotWordsView;
@property (nonatomic,retain)IBOutlet UITableView *historyView;
@property (nonatomic,retain)IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic,retain)IBOutlet UITextField *searchTextField;
@property (nonatomic,retain)OverlayViewController *overlay;
@property (nonatomic,assign) id<RootViewDelegate>rootDelegate;

@end
