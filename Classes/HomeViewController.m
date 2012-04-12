//
//  HomeViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    int _currentPage;
    int _pageCount;
    int _sequanceInDate;
    int _sequanceInWeek;
}

-(void)loadPeriod;

-(void)loadTips;

-(void)loadTipsTypes;

-(void)cleanTipsViews;

-(void)loadTipsViews;

-(void)showTipsViewsWithAnimation:(CATransition *)animation;

-(void)updateDayLabel;

-(int)sequenceInDate:(NSDate *)date;

-(int)sequenceInWeek:(int)sequenceInDate;

-(void)performTransitionLeft:(UIView *)View;

-(void)performTransitionRight:(UIView *)View;

-(void)performTransitionUp:(UIView *)View;

-(void)performTransitionDown:(UIView *)View;

@end

@implementation HomeViewController
@synthesize tipsTypes = _tipsTypes;
@synthesize tips = _tips;
@synthesize startPoint=_startPoint;
@synthesize tipsViews = _tipsViews;
@synthesize dayLabel=_dayLabel;
@synthesize currentDate=_currentDate;
@synthesize period = _period;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.currentDate = [NSDate date];
        [self loadPeriod];
        [self loadTipsTypes];
        [self loadTips];
    }
    return self;
}
- (void)dealloc
{
    [_tipsTypes release];
    [_tips release];
    [_tipsViews release];
    [_period release];
    [_currentDate release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self cleanTipsViews];
    [self loadTipsViews];
    [self showTipsViewsWithAnimation:nil];
    //加载日期标签
    NSArray *labelViewArray = [[NSBundle mainBundle] loadNibNamed:@"CalendarView" owner:nil options:nil];
    self.dayLabel = [labelViewArray lastObject];
    _dayLabel.frame = CGRectMake(0, 50, _dayLabel.frame.size.width, _dayLabel.frame.size.height);
    [self updateDayLabel];
    [self.view addSubview:_dayLabel];
    [self.view bringSubviewToFront:_dayLabel];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.dayLabel = nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)loadPeriod{
    self.period = [[DatabaseAccess sharedAccess] executeQueryForUnique:[PregnacyPeriod class] withSql:@"select * from pregnancy_period" withArgumentsInArray:nil];
    //[[[NSDate date] dateByAddingTimeInterval:(24*60*60*220)] timeIntervalSince1970]
    NSLog(@"_period.begin_date:%@",_period.begin_date);
}

-(void)loadTipsTypes{
     self.tipsTypes = [[DatabaseAccess sharedAccess] executeQueryForList:[PregnancyDaliyTipsType class] limit:20 withSql:@"select * from pregnancy_daliy_tips_type order by name_index" withArgumentsInArray:nil];
}

-(void)loadTips{
    _sequanceInDate = [self sequenceInDate:_currentDate];
    _sequanceInWeek = [self sequenceInWeek:_sequanceInDate];
     NSArray *args = [NSArray  arrayWithObjects:[NSNumber numberWithInt:_sequanceInDate],nil];
    self.tips = [[DatabaseAccess sharedAccess] executeQueryForList:[PregnancyDaliyTips class] limit:30  withSql:@"select * from pregnancy_daliy_tips_new where tips_day=? order by id asc" withArgumentsInArray:args];
    if([_tips count] % 4==0){
        _pageCount = [_tips count]/4;
    }else {
        _pageCount = [_tips count]/4 + 1;
    }
    _currentPage = 0;
}
-(void)loadTipsViews{
    self.tipsViews = [NSMutableArray arrayWithCapacity:_pageCount];
    for (int i=0; i<_pageCount; i++) {
        NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"AHomeView" owner:nil options:nil];
        AHomeView *page = [viewArray lastObject];
        NSRange pageRange;
        if (([_tips count]-4*(i))<4) {
            pageRange.length = [_tips count]-4*(i);
        }else {
            pageRange.length = 4;
        }
        pageRange.location = 4*(i);
        NSArray * dataArray = [_tips subarrayWithRange:pageRange];
        [page populateTipsViewWithDataArray:dataArray atPageIndex:i pageCount:_pageCount];
        page.frame = CGRectMake(0, 30, page.frame.size.width, page.frame.size.height);
        page.delegate=self;
        [_tipsViews addObject:page];
    }
}
-(void)showTipsViewsWithAnimation:(CATransition *)transition{
    if([_tipsViews count]==0){
        return;
    }
    UIView *page = [_tipsViews objectAtIndex:0];
    if (transition) {
        [self.view insertSubview:page atIndex:0];
        [self viewWillDisappear:YES];
        [self.view.layer addAnimation:transition forKey:nil];
    }else {
        [self.view addSubview:page];
    }
    
}

-(void)cleanTipsViews{
    if ([_tips count]>0) {
        for (AHomeView *page in _tipsViews) {
            [page removeFromSuperview];
        }
    }else {
        NSLog(@"error data at day:%d",[self sequenceInDate:_currentDate]);
    }
}
-(void)updateDayLabel{
    [_dayLabel populateWithDate:_currentDate sequenceInWeek:_sequanceInWeek sequenceInDate:_sequanceInDate];
}
-(int)sequenceInDate:(NSDate *)date{
    //开始时间距离实际当前时间的天数
    int realDaysAgo = [_period.begin_date daysAgoAgainstMidnight];
    NSLog(@"days ago:%@ with %d",_period.begin_date,realDaysAgo);
    //给定时间距离当前时间的天数
    int currentDaysAgo = [date daysAgoAgainstMidnight];
    NSLog(@"days ago:%@ with %d",date,currentDaysAgo);
    return realDaysAgo-currentDaysAgo;
}

-(int)sequenceInWeek:(int)sequenceInDate{
    int weekly = 0;
    if (sequenceInDate % 7==0) {
        weekly = sequenceInDate/7;
    }else {
        weekly = sequenceInDate/7 +1;
    }
    return weekly;
}

#pragma mark - TipsDetailViewDelegate

-(void)closeTips:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - AHomeViewDelegate

-(void)onDetailButtonClicked:(id)sender{
    CGRect frame = self.view.frame;
    NSString *bgImageName = @"tips_1@2x";
    UIButton *button = (UIButton *)sender;
    PregnancyDaliyTips *tips = [_tips objectAtIndex:button.tag];
    TipsViewController *tvc = [[[TipsViewController alloc] initWithBgImageName:bgImageName withParentViewFrame:frame data:tips] autorelease];
    tvc.delegate = self;
    tvc.modalPresentationStyle = UIModalPresentationPageSheet;
    tvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    tvc.view.frame = frame;
    //[self presentModalViewController:tvc animated:YES];
    [self presentViewController:tvc animated:YES completion:NULL];
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    //NSLog(@"touchesBegan");
    UITouch *touch=[touches anyObject];
	CGPoint point1=[touch locationInView:self.view];
	self.startPoint=point1;
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    //NSLog(@"touchesMoved");

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    //NSLog(@"touchesEnded");
    UITouch *touch=[touches anyObject];
	CGPoint point2=[touch locationInView:self.view];
    if (fabs(point2.x-self.startPoint.x)>50) {		
		if ((point2.x-self.startPoint.x)>0) {			
			//向右边滑动,表示得到上一页			
			--_currentPage;
			if (_currentPage>=0) {
				AHomeView *nextView=[_tipsViews objectAtIndex:_currentPage];
				[self performTransitionRight:nextView];
			}else{
				_currentPage=0;
			}
		}else {			
			//向左滑动，表示得到下一页
			++_currentPage;
			if (_currentPage<[_tipsViews count]) {				
				AHomeView *nextView=[_tipsViews objectAtIndex:_currentPage];
				[self performTransitionLeft:nextView];
			}else {
				_currentPage=[_tipsViews count]-1;
			}
            
		}
	}else  if (fabs(point2.y-self.startPoint.y)>50) {
        if ((point2.y-self.startPoint.y)>0) {
            //向下滑动
            self.currentDate = [_currentDate dateByAddingTimeInterval:24*60*60];
            [self loadTips];
            [self updateDayLabel];
            [self cleanTipsViews];
            [self loadTipsViews];
            [self performTransitionDown:nil];
        }else {
            //向上滑动
            self.currentDate = [_currentDate dateByAddingTimeInterval:-24*60*60];
            [self loadTips];
            [self updateDayLabel];
            [self cleanTipsViews];
            [self loadTipsViews];
            [self performTransitionUp:nil];
        }
        
        
        [self.view bringSubviewToFront:_dayLabel];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    NSLog(@"touchesCancelled");
}



//翻页向左
-(void)performTransitionLeft:(UIView *)View{
	CATransition *transition = [CATransition animation];
	transition.duration = 0.3;
	transition.type = @"pageCurl";
	transition.subtype = kCATransitionFromRight;
	[[self.view.subviews objectAtIndex:0] removeFromSuperview];
	[self.view insertSubview:View atIndex:0];
	[self viewWillDisappear:YES];
	[self.view.layer addAnimation:transition forKey:nil];
	
	
}
//翻页向右
-(void)performTransitionRight:(UIView *)View{
	CATransition *transition = [CATransition animation];
	transition.duration = 0.3;
	transition.type = @"pageUnCurl";
	transition.subtype = kCATransitionFromRight;
	[[self.view.subviews objectAtIndex:0] removeFromSuperview];
	[self.view insertSubview:View atIndex:0];
	[self viewWillDisappear:YES];
	[self.view.layer addAnimation:transition forKey:nil];	
}

-(void)performTransitionUp:(UIView *)View{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self showTipsViewsWithAnimation:transition];
}

-(void)performTransitionDown:(UIView *)View{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [self showTipsViewsWithAnimation:transition];
}

@end
