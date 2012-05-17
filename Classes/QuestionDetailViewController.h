//
//  QuestionDetailViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "QuestionInfo.h"
#import "AnswerInfo.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"
#import "DatabaseAccess.h"
#import "NSObject+Addition.h"
#import "NSURL+Addition.h"
#import "QuestionView.h"
#import "AnswerView.h"

@interface QuestionDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)IBOutlet UITableView *tableView;

@property (nonatomic,retain)QuestionInfo *questionInfo;
@property (nonatomic,retain)NSArray *questionAnswers;
-(id)initWithIdentifier:(NSString *)questionId;
@end
