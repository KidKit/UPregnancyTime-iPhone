//
//  RootViewDelegate.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LabelConverter.h"

@protocol RootViewDelegate <NSObject>
-(void)onMenuButtonClicked;
-(void)onMenuItemClickedWithInfo:(LabelInfo *)labelInfo;

@optional
-(void)gotoTipsViewByDay:(int)day;
@end
