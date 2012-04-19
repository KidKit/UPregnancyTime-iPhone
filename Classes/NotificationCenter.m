//
//  TipsNotification.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NotificationCenter.h"

@implementation NotificationCenter
-(void)registerNotificationWithEntity:(id<NotificationEntity>)entity{
    UILocalNotification *localNotif=[self populateNotificationWithEntity:entity];
    if (localNotif) {
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
}
-(UILocalNotification *)populateNotificationWithEntity:(id<NotificationEntity>)entity{
    UILocalNotification *localNotif = [[[UILocalNotification alloc] init] autorelease];
    if (localNotif == nil)
        return nil;
    localNotif.fireDate = [entity fireDate]?[entity fireDate]:[NSDate dateWithTimeIntervalSinceNow:10];;
    localNotif.repeatInterval = kCFCalendarUnitMinute;
    localNotif.timeZone = [entity timeZone]?[entity timeZone]:[NSTimeZone defaultTimeZone];
    localNotif.alertBody = NSLocalizedString(@"testttt",@"testttt");
    localNotif.alertAction = NSLocalizedString(@"testttt11111",@"testttt111");
    localNotif.applicationIconBadgeNumber = [entity badgeNumber]?[entity badgeNumber]:1;
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    return localNotif;
}
@end
