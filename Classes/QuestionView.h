//
//  QuestionView.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionInfo.h"
#import "NSDate+Helper.h"

@interface QuestionView : UIView

@property (nonatomic,retain)IBOutlet UILabel *title;
@property (nonatomic,retain)IBOutlet UITextView *body;
@property (nonatomic,retain)IBOutlet UILabel *author;
@property (nonatomic,retain)IBOutlet UILabel *date;
-(void)populateWithInfo:(QuestionInfo *)info;
@end
