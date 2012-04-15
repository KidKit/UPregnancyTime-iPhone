//
//  PregnancyBookmark.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"

@interface PregnancyBookmark : NSObject<Entity>


@property (nonatomic,retain)NSNumber * id;
@property (nonatomic,retain)NSNumber * mark_at_day;
@property (nonatomic,retain)NSNumber * mark_time;
@property (nonatomic, retain) NSString * bookmark_type;
@property (nonatomic, retain) NSString * bookmark_key;
@property (nonatomic, retain) NSString * bookmark_value;
@property (nonatomic, retain) NSString * bookmark_keyword;

@end
