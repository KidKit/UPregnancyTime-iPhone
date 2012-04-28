//
//  CommonDataHolder.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonDataHolder.h"

@implementation CommonDataHolder

+ (CommonDataHolder *)instance
{    
    static CommonDataHolder * instance;    
    if (instance == nil) {        
        @synchronized (self) {            
            instance = [[CommonDataHolder alloc] init];            
            assert(instance != nil);            
        }        
    }    
    return instance;    
}
- (void)dealloc
{
    [super dealloc];
}
-(PregnancyPeriod *)loadPeriod{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSDate *dueDate = [def objectForKey:PERIOD_DUE_DATE_KEY];
    NSDate *beginDate = [def objectForKey:PERIOD_BEGIN_DATE_KEY];
    NSString *cycle = [def objectForKey:PERIOD_CYCLE_KEY];
    if (dueDate&&beginDate&&cycle) {
        PregnancyPeriod * period = [[[PregnancyPeriod alloc] init] autorelease];
        period.begin_date = beginDate;
        period.due_date = dueDate;
        period.cycle = [NSNumber numberWithInt:[cycle intValue]];
        return period;
    }
    return nil;
}


@end
