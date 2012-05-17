//
//  NSURL+Addition.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSURL+Addition.h"

@implementation NSURL (Addition)
+ (id)URLWithCNString:(NSString *)URLCNString{
    NSString * sUrl = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)URLCNString, nil, nil, kCFStringEncodingUTF8);
    return [self URLWithString:sUrl];
}
@end
