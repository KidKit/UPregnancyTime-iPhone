//
//  OverlayViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
@protocol OverlayViewControllerDelegate;
@interface OverlayViewController : UIViewController<OverlayViewDelegate>


@property (nonatomic,retain)IBOutlet OverlayView *overlayView;
@property (nonatomic,assign)id<OverlayViewControllerDelegate> delegate;

@end

@protocol OverlayViewControllerDelegate <NSObject>

-(void)touchBeginOnOverlayView;

@end