//
//  TipsNotification.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NotificationEntity <NSObject>

-(NSDate *)fireDate;
-(NSTimeZone *)timeZone;
-(NSString *)alertBody;
-(NSString *)alertBody;
-(NSString *)alertAction;
-(NSString *)soundName;
-(int)badgeNumber;
@end

@interface NotificationCenter : NSObject
-(void)registerNotificationWithEntity:(id<NotificationEntity>)entity;
-(UILocalNotification *)populateNotificationWithEntity:(id<NotificationEntity>)entity;
@end
