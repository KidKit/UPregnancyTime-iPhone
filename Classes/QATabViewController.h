//
//  QATabViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMTabView.h"

@interface QATabViewController : UIViewController<JMTabViewDelegate>

@property (nonatomic,retain)IBOutlet UIScrollView *contentView;
@property (nonatomic,retain)IBOutlet UIView *tabView;
@end
