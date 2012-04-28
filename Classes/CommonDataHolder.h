//
//  CommonDataHolder.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PregnancyPeriod.h"
#import "DatabaseAccess.h"

@interface CommonDataHolder : NSObject
{

}

+ (CommonDataHolder *)instance;

-(PregnancyPeriod *)loadPeriod;

@end
