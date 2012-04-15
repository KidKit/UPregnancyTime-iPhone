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
@synthesize contentView=_contentView;
@synthesize tipsDetailView=_tipsDetailView;
@synthesize actionBar = _actionBar;

-(id)initWithdata:(PregnancyDaliyTips*)tips{
    if (self= [super initWithNibName:@"TipsViewController" bundle:nil]) {
        self.tips = tips;
        self.navigationItem.title = _tips.tips_key;
        
       
    }
    return self;
}

- (void)dealloc
{
    [_tips release];
    [super dealloc];
}

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    _tipsDetailView.text=_tips.tips_data;
    NSLog(@"%@",self.navigationItem.backBarButtonItem);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.contentView = nil;
    self.tipsDetailView = nil;
    self.actionBar = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
