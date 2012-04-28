//
//  PregnancyBookmark.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PregnancyBookmark.h"

@implementation PregnancyBookmark
@synthesize _id;
@synthesize mark_time;
@synthesize mark_at_day;
@synthesize bookmark_key;
@synthesize bookmark_value;
@synthesize bookmark_type;
@synthesize bookmark_keyword;

- (void)dealloc
{
    [bookmark_key release];
    [bookmark_value release];
    [bookmark_type release];
    [bookmark_keyword release];
    [super dealloc];
}
-(NSString *)tableName{
    return @"pregnancy_bookmark";
}

-(id)uniqueIdPropertyName{
    return @"_id";
}
@end
