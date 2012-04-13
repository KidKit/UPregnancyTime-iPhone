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
#define MENU_VIEW_WIDTH 270

@interface RootViewController ()
{
    CGPoint touchBeganPoint;
}
-(void)performViewTransition:(UIViewController *)subViewController inView:(UIView*)parentView;
-(void)switchToController:(int)tag;
@end

@implementation RootViewController
@synthesize contentView = _contentView;
@synthesize currentViewController=_currentViewController;
@synthesize menuController = _menuController;

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
    [_homeController release];
    [_timeLineController release];
    [_qaController release];
    [_searchController release];
    [_menuController release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //菜单view
    self.menuController = [[[MenuViewController alloc] init] autorelease];
    
    [self.view insertSubview:_menuController.view belowSubview:_contentView];
 
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav-bar"] forBarMetrics:UIBarMetricsDefault];
    
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
                CGRect frame = CGRectMake(0, 0, hvc.view.frame.size.width, hvc.view.frame.size.height);
                _homeController = [[UINavigationController alloc] initWithRootViewController:hvc];
                _homeController.navigationBarHidden = NO;
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
            [self performViewTransition:_qaController inView:self.view];
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

#pragma mark - touch action

// Check touch position in this method (Add by Ethan, 2011-11-27)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    //NSLog(@"touchesBegan");
    UITouch *touch=[touches anyObject];
	touchBeganPoint=[touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    CGFloat yOffSet = touchPoint.y - touchBeganPoint.y;
    CGFloat xOffSet = touchPoint.x - touchBeganPoint.x;
    
    CGFloat arg = ((xOffSet/sqrt((yOffSet*yOffSet+xOffSet*xOffSet))));
    if (fabs(arg)>0.8f&&xOffSet<MENU_VIEW_WIDTH&&_contentView.frame.origin.x<MENU_VIEW_WIDTH) {
        NSLog(@"arg:%f",arg);
        _contentView.frame = CGRectMake(xOffSet, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
    }
    
    
    
}
// reset indicators when touch ended (Add by Ethan, 2011-11-27)
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    CGFloat yOffSet = touchPoint.y - touchBeganPoint.y;
    CGFloat xOffSet = touchPoint.x - touchBeganPoint.x;
    CGFloat arg = ((xOffSet/sqrt((yOffSet*yOffSet+xOffSet*xOffSet))));
    
    if(xOffSet>100){
        if (fabs(arg)>0.8f) {
            _contentView.layer.shadowColor = [UIColor blackColor].CGColor;
            _contentView.layer.shadowOpacity = 0.4f;
            _contentView.layer.shadowOffset = CGSizeMake(-12.0, 1.0f);
            _contentView.layer.shadowRadius = 7.0f;
            _contentView.layer.masksToBounds = NO;
            [UIView animateWithDuration:0.2 animations:^{
                _contentView.frame = CGRectMake(MENU_VIEW_WIDTH, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
            } ];
        }
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            _contentView.frame = CGRectMake(0, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
        } ];
    }
    
}
@end
