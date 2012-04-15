//
//  PregnacyDaliyTips.m
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PregnancyDaliyTips.h"


@implementation PregnancyDaliyTips

@synthesize id;
@synthesize tips_key;
@synthesize tips_data;
@synthesize tips_data_index;
@synthesize tips_day;

- (void)dealloc
{
    [tips_key release];
    [tips_data release];
    [super dealloc];
}
-(NSString *)tableName{
    return @"pregnancy_daliy_tips_new";
}

-(id)uniqueIdPropertyName{
    return @"id";
}
@end
