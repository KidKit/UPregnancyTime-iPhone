//
//  PregnacyPeriod.m
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PregnancyPeriod.h"


@implementation PregnancyPeriod

@synthesize  _id;
@synthesize begin_date;
@synthesize due_date;
@synthesize cycle;

- (void)dealloc
{
    [_id release];
    [begin_date release];
    [due_date release];
    [super dealloc];
}
-(NSString *)tableName{
    return @"pregnancy_period";
}

-(id)uniqueIdPropertyName{
    return @"_id";
}
@end
