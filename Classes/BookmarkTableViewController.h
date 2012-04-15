//
//  BookmarkTableViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewDelegate.h"
#import "DatabaseAccess.h"
#import "PregnancyBookmark.h"

@interface BookmarkTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,retain)IBOutlet UIView *mainView;
@property (nonatomic,retain)IBOutlet UIView *searchView;
@property (nonatomic,retain)IBOutlet UITableView *resultView;
@property (nonatomic,retain)IBOutlet UITextField *searchTextField;
@property (nonatomic,assign)id<RootViewDelegate>rootDelegate;
@property (nonatomic,retain)NSArray *bookmarks;
@end
