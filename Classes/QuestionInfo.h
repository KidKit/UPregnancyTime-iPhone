//
//  QuestionInfo.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
#import "InitWithJsonable.h"

@interface QuestionInfo : NSObject<Entity>

@property (nonatomic,retain)NSString *_id;
@property (nonatomic,retain)NSString *questionBody;
@property (nonatomic,retain)NSString *questionTitle;
@property (nonatomic,retain)NSString *questionTags;
@property (nonatomic,retain)NSNumber *questionVote;
@property (nonatomic,retain)NSNumber *questionView;
@property (nonatomic,retain)NSNumber *answerCount;
@property (nonatomic,retain)NSDate *date;
@property (nonatomic,retain)NSString *author;
+(id)objWithJsonDictionary:(NSDictionary *)jsonDictionary;
@end
