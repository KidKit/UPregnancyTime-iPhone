//
//  PageView.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PagingView.h"
#define PAGE_RECT_WIDTH 20
#define PAGE_RECT_HEIGHT 20
@interface PagingView()
{
    int _pageSize;
    NSMutableArray *_pageLabelViews;
}
-(id)drawPage;    
@end

@implementation PagingView

-(id)initWithPageSize:(int)size{
    self = [super initWithFrame:CGRectMake(0, 0, size*PAGE_RECT_WIDTH, PAGE_RECT_HEIGHT)];
    if(self){
        _pageSize = size;
        _pageLabelViews = [NSMutableArray arrayWithCapacity:size];
        [self drawPage];
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
-(id)drawPage{
    for(int i =0;i<_pageSize;i++){
        UIView *p = [[[UIView alloc] initWithFrame:CGRectMake(0+PAGE_RECT_WIDTH*i, 0, PAGE_RECT_WIDTH, PAGE_RECT_HEIGHT)] autorelease];
        p.layer.borderWidth=1.0f;
        p.layer.borderColor = [UIColor whiteColor].CGColor;
        UILabel *p_text = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, PAGE_RECT_WIDTH, PAGE_RECT_HEIGHT)] autorelease];
        p_text.textAlignment = UITextAlignmentCenter;
        p_text.backgroundColor = [UIColor lightGrayColor];
        p_text.textColor = [UIColor whiteColor];
        p_text.text = [NSString stringWithFormat:@"%d",i+1];
        [p addSubview:p_text];
        [self addSubview:p];
        [_pageLabelViews addObject:p_text];
    }
    return self;    
}

//跳转到某一页(0 base)
-(void)goToPage:(int)page{
    UILabel *p_text = [_pageLabelViews objectAtIndex:page];
    p_text.backgroundColor = [UIColor orangeColor];
}


@end
