//
//  AnswerInfo.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InitWithJsonable.h"

@interface AnswerInfo : InitWithJsonable

@property (nonatomic,retain)NSNumber *_id;
@property (nonatomic,retain)NSString *answerBody;
@property (nonatomic,retain)NSDate *date;
@property (nonatomic,retain)NSNumber *answerVote;
@property (nonatomic,retain)NSString *author;
@end
