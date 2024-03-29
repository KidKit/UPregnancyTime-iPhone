//
//  PregnacyPeriod.h
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"


@interface PregnancyPeriod : NSObject<Entity>

@property (nonatomic, retain) NSNumber * _id;
@property (nonatomic, retain) NSDate * begin_date;
@property (nonatomic, retain) NSDate * due_date;
@property (nonatomic, retain) NSNumber * cycle;
@end
