//
//  PregnacyPeriod.m
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PregnacyPeriod.h"


@implementation PregnacyPeriod

@synthesize  id;
@synthesize begin_date;
@synthesize due_date;

- (void)dealloc
{
    [begin_date release];
    [due_date release];
    [super dealloc];
}
-(NSString *)tableName{
    return @"pregnancy_period";
}

-(id)uniqueIdPropertyName{
    return @"id";
}
@end
