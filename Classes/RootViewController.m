//
//  RootViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#define NAV_BASE_ORIGIN_X 18
#define NAV_BASE_ORIGIN_Y -54

@interface RootViewController ()
{
    
}
-(void)performViewTransition:(UIViewController *)subViewController inView:(UIView*)parentView;
-(void)switchToController:(int)tag;
@end

@implementation RootViewController
@synthesize navView=_navView;
@synthesize contentView=_contentView;
@synthesize currentViewController=_currentViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dealloc
{
    [_navView release];
    [_contentView release];
    [_homeController release];
    [_timeLineController release];
    [_qaController release];
    [_searchController release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //显示导航标签
    NSArray *labels = [LabelConverter getSystemDefaultLabelsInfo];
    int i =0;
    for(LabelInfo *label in labels){
        CGRect navFrame = CGRectMake(NAV_BASE_ORIGIN_X+i*label.bgImage.size.width, NAV_BASE_ORIGIN_Y, label.bgImage.size.width, label.bgImage.size.height);
        UIButton *navLabelButton = [[[UIButton alloc] initWithFrame:navFrame] autorelease];
        [navLabelButton setBackgroundImage:label.bgImage forState:UIControlStateNormal];
        navLabelButton.backgroundColor = [UIColor clearColor];
        [navLabelButton setShowsTouchWhenHighlighted:YES];
        //[navLabelButton setTitle:label.labelName forState:UIControlStateNormal];
        [navLabelButton setReversesTitleShadowWhenHighlighted:YES];
        navLabelButton.userInteractionEnabled = YES;
        navLabelButton.tag=i;
        UILabel *navLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 60, label.bgImage.size.width, 22)] autorelease];
        navLabel.backgroundColor = [UIColor clearColor];
        navLabel.font = [UIFont boldSystemFontOfSize:16];
        navLabel.textAlignment = UITextAlignmentCenter;
        navLabel.text=label.labelName;
        navLabel.userInteractionEnabled = NO;
        [navLabelButton addSubview:navLabel];
        [navLabelButton addTarget:self action:@selector(didNavLabelClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:navLabelButton];
        i++;
    }
    //显示内容
    //_contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper"]];
    [self switchToController:0];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"root_bg"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.navView = nil;
    self.contentView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - IBAction

-(IBAction)didNavLabelClick:(id)sender{
    UIButton *button = (UIButton*)sender;
    [self switchToController:button.tag];
    
}

-(void)switchToController:(int)tag{
    switch (tag) {
        case 0:
        {
            if(_homeController==nil){
                HomeViewController *hvc = [[[HomeViewController alloc] init] autorelease];
                CGRect frame = CGRectMake(0, -30, hvc.view.frame.size.width, hvc.view.frame.size.height);
                _homeController = [[UINavigationController alloc] initWithRootViewController:hvc];
                _homeController.navigationBarHidden = YES;
                _homeController.view.frame = frame;
            }
            [self performViewTransition:_homeController inView:_contentView];
            break;
        }
        case 1:
        {
            if(_timeLineController==nil){
                TimeLineViewController *tvc = [[[TimeLineViewController alloc] init] autorelease];
                CGRect frame = CGRectMake(0, -30, tvc.view.frame.size.width, tvc.view.frame.size.height);
                _timeLineController = [[UINavigationController alloc] initWithRootViewController:tvc];
                _timeLineController.navigationBarHidden = YES;
                _timeLineController.view.frame = frame;
            }
            [self performViewTransition:_timeLineController inView:_contentView];
            break;
        }
        case 2:
        {
            if(_qaController==nil){
                QAViewController *qvc = [[[QAViewController alloc] init] autorelease];
                CGRect frame = CGRectMake(0, -30, qvc.view.frame.size.width, qvc.view.frame.size.height);
                _qaController = [[UINavigationController alloc] initWithRootViewController:qvc];
                _qaController.navigationBarHidden = YES;
                _qaController.view.frame = frame;
            }
            [self performViewTransition:_qaController inView:_contentView];
            break;
        }
        case 3:
        {
            if(_searchController==nil){
                SearchViewController *svc = [[[SearchViewController alloc] init] autorelease];
                CGRect frame = CGRectMake(0, -30, svc.view.frame.size.width, svc.view.frame.size.height);
                _searchController = [[UINavigationController alloc] initWithRootViewController:svc];
                _searchController.navigationBarHidden = YES;
                _searchController.view.frame = frame;
            }
            [self performViewTransition:_searchController inView:_contentView];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - animation

-(void)performViewTransition:(UIViewController *)subViewController inView:(UIView*)parentView{
    [UIView transitionWithView:parentView duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [_currentViewController.view removeFromSuperview];
        [parentView addSubview:subViewController.view];
    } completion:^(BOOL finished) {
        self.currentViewController = subViewController;
    }];
}

@end
