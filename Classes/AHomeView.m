//
//  HomeView.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AHomeView.h"

@implementation AHomeView
@synthesize delegate=_delegate;
@synthesize tips1Label = _tips1Label;
@synthesize tips1TextView = _tips1TextView;
@synthesize tips1DetailButton = _tips1DetailButton;
@synthesize tips2Label = _tips2Label;
@synthesize tips2TextView = _tips2TextView;
@synthesize tips2DetailButton = _tips2DetailButton;
@synthesize tips3Label = _tips3Label;
@synthesize tips3TextView = _tips3TextView;
@synthesize tips3DetailButton = _tips3DetailButton;
@synthesize tips4Label = _tips4Label;
@synthesize tips4TextView = _tips4TextView;
@synthesize tips4DetailButton = _tips4DetailButton;
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
    self.tips1Label = nil;
    self.tips1TextView = nil;
    self.tips1DetailButton = nil;
    self.tips2Label = nil;
    self.tips2TextView = nil;
    self.tips2DetailButton = nil;
    self.tips3Label = nil;
    self.tips3TextView = nil;
    self.tips3DetailButton = nil;
    self.tips4Label = nil;
    self.tips4TextView = nil;
    self.tips4DetailButton = nil;
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)populateTipsViewWithDataArray:(NSArray*)dataArray atPageIndex:(int)pageIndex pageCount:(int) pageCount{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper"]];
    for (int i=0;i<4;i++) {
        if(i>= [dataArray count]){
            if(i==0){
                [_tips1Label removeFromSuperview];
                [_tips1TextView removeFromSuperview];
                [_tips1DetailButton removeFromSuperview];
            }
            if(i==1){
                [_tips2Label removeFromSuperview];
                [_tips2TextView removeFromSuperview];
                [_tips2DetailButton removeFromSuperview];
            }
            if(i==2){
                [_tips3Label removeFromSuperview];
                [_tips3TextView removeFromSuperview];
                [_tips3DetailButton removeFromSuperview];
            }
            if(i==3){
                [_tips4Label removeFromSuperview];
                [_tips4TextView removeFromSuperview];
                [_tips4DetailButton removeFromSuperview];
            }
        }else{
            PregnancyDaliyTips *tips = [dataArray objectAtIndex:i];
            if(i==0){
                _tips1Label.text = tips.tips_key;
                _tips1TextView.text = tips.tips_data;
                _tips1DetailButton.tag=i+pageIndex*4;
            }
            if(i==1){
                _tips2Label.text = tips.tips_key;
                _tips2TextView.text = tips.tips_data;
                _tips2DetailButton.tag=i+pageIndex*4;
            }
            if(i==2){
                _tips3Label.text = tips.tips_key;
                _tips3TextView.text = tips.tips_data;
                _tips3DetailButton.tag=i+pageIndex*4;
            }
            if(i==3){
                _tips4Label.text = tips.tips_key;
                _tips4TextView.text = tips.tips_data;
                _tips4DetailButton.tag=i+pageIndex*4;
            }
        }
    }
    PagingView *pagingView = [[[PagingView alloc] initWithPageSize:pageCount] autorelease];
    pagingView.frame = CGRectMake(0, 0, pagingView.frame.size.width, pagingView.frame.size.height);
    pagingView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-30);
    [pagingView goToPage:pageIndex];
    [self addSubview:pagingView];
    
}


#pragma mark - IBAction
-(IBAction)onDetailButtonClicked:(id)sender{
    if ([_delegate respondsToSelector:@selector(onDetailButtonClicked:)]) {
        [_delegate onDetailButtonClicked:sender];
    }
}

@end
