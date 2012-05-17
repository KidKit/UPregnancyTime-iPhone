//
//  UINavigationBar.m
//  D3BUS
//
//  Created by Zhimin Jiang on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+BG.h"

@implementation UINavigationBar (BackgroundImage)
//This overridden implementation will patch up the NavBar with a custom Image instead of the title
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"nav-bar"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
