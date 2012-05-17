//
//  SearchResultViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionInfo.h"
#import "QuestionDetailViewController.h"

@interface SearchResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)IBOutlet UITableView *resultView;
@property (nonatomic,retain)NSArray *resultSet;

-(id)initWithResult:(NSArray *)result;
@end
