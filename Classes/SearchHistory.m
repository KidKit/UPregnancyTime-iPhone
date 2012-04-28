//
//  SearchHistory.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchHistory.h"

@implementation SearchHistory
@synthesize _id;
@synthesize key_word;
@synthesize search_date;
@synthesize addition;

-(NSString *)tableName{
    return @"qa_search_history";
}

-(NSString *)uniqueIdPropertyName{
    return @"_id";
}
@end
