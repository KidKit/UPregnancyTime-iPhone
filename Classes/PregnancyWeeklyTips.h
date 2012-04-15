//
//  PregnacyWeeklyTips.h
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-3-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@interface PregnacyWeeklyTips : NSObject<Entity>

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * tips_data;
@property (nonatomic, retain) NSNumber * tips_weekly;

@end
