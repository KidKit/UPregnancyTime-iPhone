//
//  TipsViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "PregnancyDaliyTips.h"

@interface TipsViewController : UIViewController

@property (nonatomic,retain)PregnancyDaliyTips *tips;
@property (nonatomic,retain)IBOutlet UIScrollView *contentView;
@property (nonatomic,retain)IBOutlet UITextView *tipsDetailView;
@property (nonatomic,retain)IBOutlet UIScrollView *actionBar;

-(id)initWithdata:(PregnancyDaliyTips*)tips;

@end
