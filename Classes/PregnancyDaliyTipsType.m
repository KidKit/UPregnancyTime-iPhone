//
//  PregnancyDaliyTipsType.m
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-4-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PregnancyDaliyTipsType.h"

@implementation PregnancyDaliyTipsType
@synthesize id;
@synthesize name;
@synthesize name_index;

- (void)dealloc
{
    [name release];
    [name_index release];
    [super dealloc];
}

-(NSString *)tableName{
    return @"pregnancy_daliy_tips_type";
}

-(id)uniqueIdPropertyName{
    return @"id";
}
@end
