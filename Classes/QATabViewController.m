//
//  QATabViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QATabViewController.h"
#import "JMTabItem.h"
#import "JMTabView.h"
#import "QAViewController.h"
#import "CustomTabItem.h"
#import "CustomSelectionView.h"
#import "CustomBackgroundLayer.h"
@interface QATabViewController ()
{
    
}
@property (nonatomic,retain)QAViewController *contentController;
@end

@implementation QATabViewController
@synthesize contentView=_contentView;
@synthesize tabView=_tabView;
@synthesize contentController=_contentController;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    JMTabView * tabView = [[[JMTabView alloc] initWithFrame:CGRectMake(0, 0., self.view.bounds.size.width, 44)] autorelease];
    tabView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    tabView.backgroundColor = [UIColor clearColor];
    [tabView setDelegate:self];
    
    
    UIImage * standardIcon = [UIImage imageNamed:@"icon3.png"];
    UIImage * highlightedIcon = [UIImage imageNamed:@"icon2.png"];
    
    CustomTabItem * tabItem1 = [CustomTabItem tabItemWithTitle:@"搜索" icon:standardIcon alternateIcon:highlightedIcon];
    CustomTabItem * tabItem2 = [CustomTabItem tabItemWithTitle:@"我的问题" icon:standardIcon alternateIcon:highlightedIcon];
    CustomTabItem * tabItem3 = [CustomTabItem tabItemWithTitle:@"我的回答" icon:standardIcon alternateIcon:highlightedIcon];
    [tabView addTabItem:tabItem1];
    [tabView addTabItem:tabItem2];
    [tabView addTabItem:tabItem3];
    [tabView setSelectionView:[CustomSelectionView createSelectionView]];
    [tabView setItemSpacing:1.];
    [tabView setBackgroundLayer:[[[CustomBackgroundLayer alloc] init] autorelease]];
    [tabView setSelectedIndex:0];
    [_tabView addSubview:tabView];
    
    self.contentController = [[[QAViewController alloc] init] autorelease];
    [_contentView addSubview:_contentController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -- JMTabViewDelegate
-(void)tabView:(JMTabView *)tabView didSelectTabAtIndex:(NSUInteger)itemIndex{
    
}
@end
