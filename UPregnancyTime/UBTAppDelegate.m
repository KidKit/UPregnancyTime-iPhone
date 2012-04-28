//
//  UBTAppDelegate.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UBTAppDelegate.h"
#import "NotificationCenter.h"

@implementation UBTAppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //NotificationCenter *nc = [[[NotificationCenter alloc] init] autorelease];
        [application cancelAllLocalNotifications];
        //[application scheduleLocalNotification:[nc populateNotificationWithEntity:nil]]; 
    });
    
    //设置导航栏
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav-bar"] forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav-bar-back-button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 4)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"nav-bar-back-button-pressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 4)] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    id period = [[CommonDataHolder instance] loadPeriod];
    if (period) {
        [self completedChange];
    }else {
        PeriodSettingViewController *settingController = [[[PeriodSettingViewController alloc] init] autorelease];
        settingController.periodChangeDelegate = self;
        UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:settingController] autorelease];
        navigationController.navigationBarHidden = NO;
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"didReceiveLocalNotification");
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - PeriodSettingDelegate

-(void)completedChange{
    RootViewController *rootController = [[[RootViewController alloc] init] autorelease];
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:rootController] autorelease];
    navigationController.navigationBarHidden = YES;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
}
@end
