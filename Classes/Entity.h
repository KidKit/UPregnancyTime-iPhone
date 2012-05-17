//
//  Entity.h
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-4-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Addition.h"


@protocol Entity <NSObject>

@required
-(NSString *)tableName;

-(NSString *)uniqueIdPropertyName;

@end
