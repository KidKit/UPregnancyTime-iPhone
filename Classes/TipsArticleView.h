//
//  TipsArticleView.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PregnancyDaliyTips.h"
@interface TipsArticleView : UIView
@property(nonatomic,retain)IBOutlet UILabel *articleTitle;
@property(nonatomic,retain)IBOutlet UITextView *articleText;

-(void)populateWithTips:(PregnancyDaliyTips *)tips;
@end
