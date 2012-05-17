//
//  AnswerView.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerInfo.h"
#import "NSDate+Helper.h"

@interface AnswerView : UIView

@property (nonatomic,retain)IBOutlet UIImageView *show;
@property (nonatomic,retain)IBOutlet UILabel *author;
@property (nonatomic,retain)IBOutlet UILabel *date;
@property (nonatomic,retain)IBOutlet UITextView *body;


-(void)populateWithInfo:(AnswerInfo *)info;
@end
