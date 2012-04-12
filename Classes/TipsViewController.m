//
//  TipsViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TipsViewController.h"

@interface TipsViewController ()
{
    
}

@end

@implementation TipsViewController
@synthesize tips = _tips;
@synthesize delegate=_delegate;
@synthesize bgImageName=_bgImageName;
@synthesize detailTips = _detailTips;
@synthesize closeButton = _closeButton;
@synthesize tipsDetail=_tipsDetail;
@synthesize tipsTitle=_tipsTitle;

-(id)initWithBgImageName:(NSString*)bgImageName withParentViewFrame:(CGRect)parentFrame data:(PregnancyDaliyTips*)tips{
    if (self= [super init]) {
        self.tips = tips;
        self.bgImageName = bgImageName;
        UIImage *detailTipsBgImage = [UIImage imageNamed:_bgImageName];
        CGRect frame = CGRectMake((parentFrame.size.width-detailTipsBgImage.size.width)/2+5, 40, detailTipsBgImage.size.width, detailTipsBgImage.size.height);
        self.detailTips = [[[UIScrollView alloc] initWithFrame:parentFrame] autorelease];
        if(detailTipsBgImage){
            UIImageView *bgView = [[[UIImageView alloc] initWithImage:detailTipsBgImage] autorelease];
            bgView.frame = frame;
            _detailTips.backgroundColor = [UIColor clearColor];
            [_detailTips addSubview:bgView];
        }
        
        
        //标题
        CGRect titleFrame = CGRectMake(parentFrame.size.width/2-40, 65, detailTipsBgImage.size.width, 22);
        self.tipsTitle = [[[UILabel alloc] initWithFrame:titleFrame] autorelease];
        _tipsTitle.backgroundColor = [UIColor clearColor];
        [_detailTips addSubview:_tipsTitle];
        
        //内容
        CGRect detailFrame = CGRectMake((parentFrame.size.width-detailTipsBgImage.size.width)/2+20, 90, detailTipsBgImage.size.width-20, detailTipsBgImage.size.height-20);
        self.tipsDetail = [[[UITextView alloc] initWithFrame:detailFrame] autorelease];
        _tipsDetail.backgroundColor = [UIColor clearColor];
        _tipsDetail.editable=NO;
        [_detailTips addSubview:_tipsDetail];
        
        
        //操作图标
        UIImage *closeImage = [UIImage imageNamed:@"close"];
        self.closeButton = [[[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-20, 50, closeImage.size.width, closeImage.size.height)] autorelease];
        [_closeButton setBackgroundImage:closeImage forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [_detailTips addSubview:_closeButton];
        
    }
    return self;
}

- (void)dealloc
{
    [_closeButton release];
    [_detailTips release];
    [_tipsDetail release];
    [_tipsTitle release];
    [_tips release];
    [super dealloc];
}

-(void)loadView{
    [super loadView];
    _tipsTitle.text = _tips.tips_key;
    _tipsDetail.text = [NSString stringWithFormat:@"%@ \n %@",_tipsDetail.text,_tips.tips_data];
    [self.view addSubview: _detailTips];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.bgImageName=nil;
    self.detailTips = nil;
    self.closeButton = nil;
    self.tipsDetail = nil;
    self.tipsTitle = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - IBAction

-(IBAction)close:(id)sender{
    NSLog(@"detail tips view close;");
    if([_delegate respondsToSelector:@selector(closeTips:)]){
        [_delegate closeTips:sender];
    }
}
@end
