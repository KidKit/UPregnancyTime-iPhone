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


@protocol TipsDetailViewDelegate;
@interface TipsViewController : UIViewController

@property (nonatomic,retain)PregnancyDaliyTips *tips;
@property (nonatomic,copy) NSString *bgImageName;
@property (nonatomic,retain)UIScrollView *detailTips;
@property (nonatomic,retain)UILabel *tipsTitle;
@property (nonatomic,retain)UITextView *tipsDetail;
@property (nonatomic,retain)UIButton *closeButton;
@property (nonatomic,assign)id<TipsDetailViewDelegate> delegate;

-(id)initWithBgImageName:(NSString*)bgImageName withParentViewFrame:(CGRect)parentFrame data:(PregnancyDaliyTips*)tips;

-(IBAction)close:(id)sender;
@end

@protocol TipsDetailViewDelegate <NSObject>

-(void)closeTips:(id)sender;

@end