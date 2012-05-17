//
//  InitWithJsonable.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InitWithJsonable.h"

@implementation InitWithJsonable

+(id)objWithJsonDictionary:(NSDictionary *)jsonDictionary{
    return [self objWithDelegate:^id(NSString * pTypeName, NSString * pName) {
        if ([pName isEqualToString:@"_id"]) {
            return [jsonDictionary objectForKey:@"id"];
        }
        if ([pName isEqualToString:@"date"]) {
            NSNumber *interval = [jsonDictionary objectForKey:@"date"];
            //NSLog(@"%@",interval);
            return [NSDate dateWithTimeIntervalSince1970:[interval doubleValue]];
        }
        return [jsonDictionary objectForKey:pName];
    }];
}
@end
