//
//  TipsArticleView.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TipsArticleView.h"

@implementation TipsArticleView
@synthesize articleText=_articleText;
@synthesize articleTitle=_articleTitle;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
- (void)dealloc
{
    [_articleTitle release];
    [_articleText release];
    [super dealloc];
}
-(void)populateWithTips:(PregnancyDaliyTips *)tips{
    _articleText.text = tips.tips_data;
    _articleText.font = [UIFont fontWithName:@"FZMiaoWuS-GB" size:16.0f];
    _articleTitle.text = tips.tips_key;
    _articleTitle.font = [UIFont fontWithName:@"FZMiaoWuS-GB" size:24.0f];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
