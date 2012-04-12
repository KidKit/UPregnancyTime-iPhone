//
//  PregnancyDaliyTipsType.h
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-4-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
@interface PregnancyDaliyTipsType : NSObject<Entity>

@property (nonatomic,retain)NSNumber *id;
@property (nonatomic,retain)NSString *name;
@property (nonatomic,retain)NSString *name_index;
@end
