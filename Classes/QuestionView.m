//
//  QuestionView.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QuestionView.h"

@implementation QuestionView
@synthesize title=_title;
@synthesize body=_body;
@synthesize author=_author;
@synthesize date=_date;

-(void)populateWithInfo:(QuestionInfo *)info{
    _title.text = info.questionTitle;
    _body.text = info.questionBody;
    _author.text = info.author;
    //NSLog(@"date:%@",info.date);
    _date.text = [info.date stringWithFormat:[NSDate dateTimeFormatStringCNFull]];
}

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
    [_title release];
    [_body release];
    [_author release];
    [_date release];
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

@end
