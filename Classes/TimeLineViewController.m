//
//  TimeLineViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TimeLineViewController.h"

@interface TimeLineViewController ()
{
    float _calibrationCellViewHeight;
    float _pointerBaseOffsetY;

}
-(void)caculateWeekAndDayAffterScroll;
-(void)scrollRectToVisibleByDay:(int)day;
-(void)loadPeriod;
@end

@implementation TimeLineViewController
@synthesize scrollView=_scrollView;
@synthesize pointerView=_pointerView;
@synthesize period = _period;
@synthesize rootDelegate=_rootDelegate;
@synthesize calibrationView=_calibrationView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self loadPeriod];
    }
    return self;
}
- (void)dealloc
{
    [_period release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    UIImage *calibrationBG = [UIImage imageNamed:@"kedu"];
    _calibrationCellViewHeight = calibrationBG.size.height;//每个刻度高度
    _pointerBaseOffsetY = _pointerView.frame.origin.y*2;//算上相对位置, y要乘以2
    float contentHeight = calibrationBG.size.height*47;
    self.calibrationView = [[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-calibrationBG.size.width, 0, calibrationBG.size.width, contentHeight)] autorelease]; 
    for (int i=0; i<47; i++) {
        UIView *section = [[UIView alloc] initWithFrame:CGRectMake(0, i*calibrationBG.size.height, calibrationBG.size.width, calibrationBG.size.height)];
        section.backgroundColor = [UIColor colorWithPatternImage:calibrationBG];
        if (i>0&&i<42) {
            UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, calibrationBG.size.width, 20)];
            num.text = [NSString stringWithFormat:@"%d",i];
            num.backgroundColor = [UIColor clearColor];
            num.textColor = [UIColor whiteColor];
            [section addSubview:num];
            [num release];
        }
        [_calibrationView addSubview:section];
        [section release];
    }
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, contentHeight);
    [_scrollView addSubview:_calibrationView];
    _pointerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pointer"]];
    [self scrollRectToVisibleByDay:70];
    //[self.view bringSubviewToFront:_pointerView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.pointerView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - load data from db

-(void)loadPeriod{
    self.period = [[DatabaseAccess sharedAccess] executeQueryForUnique:[PregnancyPeriod class] withSql:@"select * from pregnancy_period" withArgumentsInArray:nil];
    //[[[NSDate date] dateByAddingTimeInterval:(24*60*60*220)] timeIntervalSince1970]
    //NSLog(@"_period.begin_date:%@",_period.begin_date);
}

#pragma mark UIScrollViewDelegateMethods

//The TimeScroller needs to know what's happening with the UITableView (UIScrollView)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    }
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   [self caculateWeekAndDayAffterScroll];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self caculateWeekAndDayAffterScroll];
    }
}
#pragma mark - caculate view offset
-(void)caculateWeekAndDayAffterScroll{
    CGRect frame = [_pointerView convertRect:_pointerView.frame toView:_calibrationView];
    NSLog(@"x:%f,y:%f,w:%f,h:%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    float fixY = frame.origin.y - 116.0f;
    float sum = fixY / 68.0f+1.0f;
    float week = floorf(sum);
    float day = roundf((sum - week)/(1.0f/7.0f))+1;
    [self scrollRectToVisibleByDay:day+(week-1)*7];
    NSLog(@"sum:%f,week:%f,day:%f",sum,week,day);
}
-(void)scrollRectToVisibleByDay:(int)day{
    float week = (day-1)/7.0f;
    if(week>40){
        week = 40.0f-1.0f/7.0f;
    }
    float targetDay = roundf(week*7)+1;
    NSLog(@"show day:%f view", targetDay);
    float offsetHeight = (week)*_calibrationCellViewHeight;
    [_scrollView scrollRectToVisible:CGRectMake(0, offsetHeight, self.view.frame.size.width, self.view.frame.size.height) animated:YES];
    if([_rootDelegate respondsToSelector:@selector(gotoTipsViewByDay:)]){
        [_rootDelegate gotoTipsViewByDay:targetDay];
    }
}
@end
