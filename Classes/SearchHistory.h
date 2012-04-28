//
//  SearchHistory.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
@interface SearchHistory : NSObject<Entity>

@property (nonatomic,retain)NSNumber *_id;
@property (nonatomic,retain)NSString *key_word;
@property (nonatomic,retain)NSDate *search_date;
@property (nonatomic,retain)NSString *addition;

@end
