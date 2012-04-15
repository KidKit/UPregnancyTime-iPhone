//
//  PregnacyWeeklyTips.m
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PregnancyWeeklyTips.h"


@implementation PregnacyWeeklyTips

@synthesize id;
@synthesize tips_data;
@synthesize tips_weekly;

- (void)dealloc
{
    [tips_data release];
    [super dealloc];
}

@end
