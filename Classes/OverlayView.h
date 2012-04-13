//
//  OverlayView.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OverlayViewDelegate;
@interface OverlayView : UIView

@property (nonatomic,assign)id<OverlayViewDelegate> delegate;
@end

@protocol OverlayViewDelegate <NSObject>

@required
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

@end