//
//  UPTContentView.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UPTContentView.h"

@implementation UPTContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    //NSLog(@"UPTContentView-touchesShouldBegin at view:%@",view);
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    //NSLog(@"UPTContentView-touchesShouldCancelInContentView at view:%@",view);
    return YES;
}

@end
