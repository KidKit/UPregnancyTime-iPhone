//
//  AnswerView.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AnswerView.h"

@implementation AnswerView
@synthesize body=_body;
@synthesize author=_author;
@synthesize date=_date;
@synthesize show=_show;

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
    [_body release];
    [_author release];
    [_date release];
    [_show release];
    [super dealloc];
}
-(void)populateWithInfo:(AnswerInfo *)info{
    _body.text = info.answerBody;
    _author.text=info.author;
    _date.text = [info.date stringWithFormat:[NSDate dateTimeFormatStringCNFull]];
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
