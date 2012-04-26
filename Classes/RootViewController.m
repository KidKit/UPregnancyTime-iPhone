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
#define MENU_VIEW_WIDTH 200
#define kTriggerLeftOffSet 120
#define kTriggerRightOffSet 50
#define TIMELINE_VIEW_WIDTH 50

@interface RootViewController ()
{
    CGPoint touchBeganContentFramePoint;
    BOOL leftMoveable;
}
-(void)performViewTransition:(UIViewController *)subViewController;
-(void)switchToControllerWithLabelInfo:(LabelInfo *)labelInfo;
-(void)moveContentViewToRight;
-(void)moveContentViewToLeft;
-(void)moveContentViewToOrigin;
-(void)dismissContentView;
- (void)handlePanRecognizer:(UIPanGestureRecognizer*)recognizer;
@end

@implementation RootViewController
@synthesize contentView = _contentView;
@synthesize currentViewControllerKey=_currentViewControllerKey;
@synthesize menuController = _menuController;
@synthesize timelineController = _timelineController;
@synthesize functionControllers = _functionControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.functionControllers = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)dealloc
{
    [_timelineController release];
    [_menuController release];
    [_functionControllers release];
    [_currentViewControllerKey release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //菜单view
    self.menuController = [[[MenuViewController alloc] init] autorelease];
    _menuController.rootDelegate = self;
    [self.view insertSubview:_menuController.view belowSubview:_contentView];
    
    //时间轴
    self.timelineController = [[[TimeLineViewController alloc] init] autorelease];
    _timelineController.rootDelegate = self;
    _timelineController.view.frame = CGRectMake(self.view.frame.size.width-TIMELINE_VIEW_WIDTH, 0, TIMELINE_VIEW_WIDTH, _timelineController.view.frame.size.height);
    [self.view insertSubview:_timelineController.view belowSubview:_contentView];
 
    
    
    
    //显示内容
    //_contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper"]];
    LabelInfo *labelInfo = [LabelConverter getLabelInfoWithIdentifier:kTodayTips];
    [self switchToControllerWithLabelInfo:labelInfo];
    
    //设置背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-background"]];
    
    //响应触摸事件
    UIPanGestureRecognizer* panRecognizer = [[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)] autorelease];
    [_contentView addGestureRecognizer:panRecognizer];
    _contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _contentView.layer.shadowOpacity = 0.4f;
    _contentView.layer.shadowOffset = CGSizeMake(-12.0, 1.0f);
    _contentView.layer.shadowRadius = 7.0f;
    _contentView.layer.masksToBounds = NO;
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

-(void)switchToControllerWithLabelInfo:(LabelInfo *)labelInfo{
    NSString *controllerKey = labelInfo.identifier;
    NSString *titleName = labelInfo.labelName;
    UINavigationController *controller = [_functionControllers valueForKey:controllerKey];
    if(controller==nil){
        UIViewController *baseController = nil;
        if ([controllerKey isEqualToString:kTodayTips]) {
            baseController = [[[DaliyTipsViewController alloc] init] autorelease];
        }
        if ([controllerKey isEqualToString:kQuestionAndAnswer]) {
            baseController = [[[QAViewController alloc] init] autorelease];
        }
        if ([controllerKey isEqualToString:kBookmarks]) {
            baseController = [[[BookmarkTableViewController alloc] init] autorelease];
        }
        if ([controllerKey isEqualToString:kSettings]) {
            baseController = [[[SettingViewController alloc] init] autorelease];
        }
        if(baseController){
            if ([baseController respondsToSelector:@selector(setRootDelegate:)]) {
                [baseController performSelector:@selector(setRootDelegate:) withObject:self];
            }
            baseController.navigationItem.title = titleName;
            UIBarButtonItem *leftButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-menu-icon"] style:UIBarButtonItemStyleBordered target:self action:@selector(onMenuButtonClicked)] autorelease];
            [leftButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [leftButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button-pressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
            baseController.navigationItem.leftBarButtonItem = leftButton;
            //首页才能往左滑动
            if ([controllerKey isEqualToString:kTodayTips]) {
                leftMoveable = YES;
                UIBarButtonItem *rightButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-timeline-icon"] style:UIBarButtonItemStyleBordered target:self action:@selector(onTimeLineButtonClicked)] autorelease];
                [rightButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
                [rightButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button-pressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
                baseController.navigationItem.rightBarButtonItem = rightButton;
            }else {
                leftMoveable = NO;
            }
            
            
            CGRect frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
            controller = [[[UINavigationController alloc] initWithRootViewController:baseController] autorelease];
            controller.navigationBarHidden = NO;
            controller.view.frame = frame;
            [_functionControllers setValue:controller forKey:controllerKey];
        }
        //TODO
    }
    if (controller) {
        [self performViewTransition:controller];
        self.currentViewControllerKey = controllerKey;
        
    }
}

#pragma mark - animation

-(void)performViewTransition:(UIViewController *)subViewController{
    UIViewController *_currentViewController = [_functionControllers valueForKey:_currentViewControllerKey];
    [UIView animateWithDuration:0.2 animations:^{
        if(subViewController!=_currentViewController){
            //NSLog(@"content view changed");
            [_currentViewController.view removeFromSuperview];
            CGRect frame = CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height);
            subViewController.view.frame = frame;
            [_contentView addSubview:subViewController.view];
        }
        _contentView.frame = CGRectMake(0, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
       
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)moveContentViewToRight{
    
    [UIView animateWithDuration:0.2 animations:^{
        _contentView.frame = CGRectMake(MENU_VIEW_WIDTH, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
    } ];
}
-(void)moveContentViewToLeft{
    
    [UIView animateWithDuration:0.2 animations:^{
        _contentView.frame = CGRectMake(-TIMELINE_VIEW_WIDTH, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
    } ];
}
-(void)moveContentViewToOrigin{
    [UIView animateWithDuration:0.2 animations:^{
        _contentView.frame = CGRectMake(0, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
    } ];
}
-(void)dismissContentView{
    [UIView animateWithDuration:0.1 animations:^{
        _contentView.frame = CGRectMake(self.view.frame.size.width, _contentView.frame.origin.y, _contentView.frame.size.width, _contentView.frame.size.height);
    } ];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging");
}

#pragma mark - RootViewControllerDelegate
-(void)onMenuButtonClicked{
    if(_contentView.frame.origin.x!=0){
        [self moveContentViewToOrigin];
    }else {
        [self moveContentViewToRight];
    }
    
}
-(void)onTimeLineButtonClicked{
    if(_contentView.frame.origin.x!=0){
        [self moveContentViewToOrigin];
    }else {
        [self moveContentViewToLeft];
    }
}
-(void)onMenuItemClickedWithInfo:(LabelInfo *)labelInfo{
    [self switchToControllerWithLabelInfo:labelInfo];
}

-(void)gotoTipsViewByDay:(int)day{
    if ([kTodayTips isEqualToString:_currentViewControllerKey]) {
        UINavigationController *navController = [_functionControllers objectForKey:kTodayTips];
        UIViewController *tipsViewController = navController.topViewController;
        if ([tipsViewController respondsToSelector:@selector(gotoTipsViewByDay:)]) {
            [tipsViewController performSelector:@selector(gotoTipsViewByDay:) withObject:[NSNumber numberWithInt:day]];
        }
        
    }
}

#pragma mark - UISwipeGestureRecognizer

- (void)handlePanRecognizer:(UIPanGestureRecognizer*)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"testRecognizer begin:%@",recognizer);
        touchBeganContentFramePoint = _contentView.frame.origin;
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged&&touchBeganContentFramePoint.x==0) {
        CGFloat xOffSet = [recognizer translationInView:[[UIApplication sharedApplication] keyWindow]].x;
        if(xOffSet>0){
            if(_contentView.frame.origin.x>=0&&_contentView.frame.origin.x<=MENU_VIEW_WIDTH){
                _contentView.frame = CGRectMake(xOffSet,_contentView.frame.origin.y,_contentView.frame.size.width, _contentView.frame.size.height);
            } 
        }else if(leftMoveable){
            if(_contentView.frame.origin.x<=0&&_contentView.frame.origin.x>-TIMELINE_VIEW_WIDTH){
                _contentView.frame = CGRectMake(xOffSet,_contentView.frame.origin.y,_contentView.frame.size.width, _contentView.frame.size.height);
            }
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGFloat xOffSet = [recognizer translationInView:[[UIApplication sharedApplication] keyWindow]].x;
        if(touchBeganContentFramePoint.x!=0){
            if(touchBeganContentFramePoint.x*xOffSet<0){
                [self moveContentViewToOrigin];
            }
        }else {
            float offset = _contentView.frame.origin.x;
            if (offset<0&&leftMoveable) {
                if (_contentView.frame.origin.x < -kTriggerRightOffSet){
                    [self moveContentViewToLeft];
                }else if(_contentView.frame.origin.x > -kTriggerRightOffSet){
                    [self moveContentViewToOrigin];
                } 
            }else {
                if (_contentView.frame.origin.x > kTriggerLeftOffSet){
                    [self moveContentViewToRight];
                }else{
                    [self moveContentViewToOrigin];
                }
            }
        }
        
    }
}
@end
