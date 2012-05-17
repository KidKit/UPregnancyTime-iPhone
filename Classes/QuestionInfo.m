//
//  QuestionInfo.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuestionInfo.h"

@implementation QuestionInfo
@synthesize _id;
@synthesize questionBody;
@synthesize questionTags;
@synthesize questionTitle;
@synthesize questionView;
@synthesize questionVote;
@synthesize answerCount;
@synthesize date;
@synthesize author;

-(NSString *)tableName{
    return @"question_info";
}

-(NSString *)uniqueIdPropertyName{
    return @"_id";
}
+(id)objWithJsonDictionary:(NSDictionary *)jsonDictionary{
    return [self objWithDelegate:^id(NSString * pTypeName, NSString * pName) {
        if ([pName isEqualToString:@"_id"]) {
            return [jsonDictionary objectForKey:@"id"];
        }else if([pName isEqualToString:@"questionTags"]){
            id array = [jsonDictionary objectForKey:@"questionTags"];
            if (array != [NSNull null]) {
                NSMutableString *str = [NSMutableString string];
                for(NSString *tag in array){
                    [str appendString:tag];
                    [str appendString:@" "];
                }
                return str;
            }else {
                return [NSNull null];
            }
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
