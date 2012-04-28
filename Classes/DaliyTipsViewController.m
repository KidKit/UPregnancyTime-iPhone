//
//  DaliyTipsViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DaliyTipsViewController.h"

@interface DaliyTipsViewController ()
{
    int _currentPage;
    int _sequanceInDate;
    int _sequanceInWeek;
    int _currentTipsPageIndex;
    MBProgressHUD *_hud;
    BOOL _needReload;
}
-(void)loadTips;
-(void)reloadDayAndWeekLabel;
-(void)removeScrollSubView;
-(int)sequenceInDate:(NSDate *)date;
-(int)sequenceInWeek:(int)sequenceInDate;
-(void)innerGotoTipsViewByDay:(NSNumber *)day;
-(void)dataChanged;
@end

@implementation DaliyTipsViewController
@synthesize calendarView=_calendarView;
@synthesize scrollView=_scrollView;
@synthesize weekLabel=_weekLabel;
@synthesize dayLabel=_dayLabel;
@synthesize dayAndWeekIndexLabel = _dayAndWeekIndexLabel;

@synthesize tips=_tips;
@synthesize tipsViews=_tipsViews;
@synthesize currentDate=_currentDate;
@synthesize pageControl=_pageControl;
-(void)dataChanged{
    _needReload  = YES;
}
-(void)loadTips{
    _sequanceInDate = [self sequenceInDate:_currentDate];
    _sequanceInWeek = [self sequenceInWeek:_sequanceInDate];
    NSArray *args = [NSArray  arrayWithObjects:[NSNumber numberWithInt:_sequanceInDate],nil];
    self.tips = [[DatabaseAccess sharedAccess] executeQueryForList:[PregnancyDaliyTips class] limit:30  withSql:@"select * from pregnancy_daliy_tips_new where tips_day=? order by _id asc" withArgumentsInArray:args];
}
-(void)reloadDayAndWeekLabel{
    _weekLabel.text = [_currentDate weekdayCN];
    _dayLabel.text = [NSDate stringFromDate:_currentDate withFormat:[NSDate dateFormatStringCN]];
    _dayAndWeekIndexLabel.text = [NSString stringWithFormat:@"怀孕 第%d周 第%d天",_sequanceInWeek,_sequanceInDate];
}
-(int)sequenceInDate:(NSDate *)date{
    //开始时间距离实际当前时间的天数
    PregnancyPeriod *_period = [[CommonDataHolder instance] loadPeriod];
    int realDaysAgo = [_period.begin_date daysAgoAgainstMidnight];
    //NSLog(@"days ago:%@ with %d",_period.begin_date,realDaysAgo);
    //给定时间距离当前时间的天数
    int currentDaysAgo = [date daysAgoAgainstMidnight];
    //NSLog(@"days ago:%@ with %d",date,currentDaysAgo);
    int res = realDaysAgo-currentDaysAgo;
    res = (res<1)?1:res;
    res = (res>280)?280:res;
    return res;
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
-(void)removeScrollSubView{
    for(UIView *subView in [_scrollView subviews]){
        [subView removeFromSuperview];
    }
}
-(void)loadTipsViews{
    [self removeScrollSubView];
    _currentPage = 0;
    int count = [_tips count];
    CGFloat contentWidth = self.view.frame.size.width*count;
    [_scrollView setContentSize:CGSizeMake(contentWidth, 320)];
    [_pageControl setCurrentPage:_currentPage];
    [_pageControl setNumberOfPages:count];
    
    self.tipsViews = [NSMutableArray arrayWithCapacity:count];
    for (int i=0; i<count; i++) {
        NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:@"TipsArticleView" owner:nil options:nil];
        TipsArticleView *article = [viewArray lastObject];
        article.frame = CGRectMake(i*self.view.frame.size.width+20, 20, article.frame.size.width, article.frame.size.height);
        article.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"article_bg"]];
        PregnancyDaliyTips *tips = [_tips objectAtIndex:i];
        [article populateWithTips:tips];
        
        article.layer.cornerRadius = 26.0f;
        article.layer.masksToBounds = YES;
        article.alpha = 0.75f;
        
        [_tipsViews addObject:article];
        [_scrollView addSubview:article];
    }
}

#pragma mark - view life circle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.currentDate = [NSDate date];
        [self loadTips];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataChanged) name:kIASKAppSettingChanged object:nil];
    }
    return self;
}
- (void)dealloc
{
    [_tips release];
    [_tipsViews release];
    [_currentDate release];
    [_hud release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置字体
    _weekLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:12.0f];
    _dayLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:24.0f];
    _dayAndWeekIndexLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:24.0f];
    //加载内容
    [self loadTipsViews];
    
    //_scrollView.contentSize=CGSizeMake(640, _scrollView.frame.size.height);
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    //修改时间标签
    [self reloadDayAndWeekLabel];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.calendarView = nil;
    self.dayLabel=nil;
    self.weekLabel=nil;
    self.dayAndWeekIndexLabel=nil;
    self.pageControl = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    if (_needReload) {
        [self loadTips];
        [self loadTipsViews];
        [self reloadDayAndWeekLabel];
        _needReload = NO;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offsetofScrollView = scrollView.contentOffset;  
    [_pageControl setCurrentPage:offsetofScrollView.x / _scrollView.frame.size.width]; 
}
#pragma mark -transport
-(void)gotoTipsViewByDay:(NSNumber *)day{
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    _hud.dimBackground = YES;
    _hud.removeFromSuperViewOnHide = YES;
    _hud.delegate = self;
    [_hud showWhileExecuting:@selector(innerGotoTipsViewByDay:) onTarget:self withObject:day animated:YES onMainThread:YES];
}
-(void)innerGotoTipsViewByDay:(NSNumber *)day{
    PregnancyPeriod *_period = [[CommonDataHolder instance] loadPeriod];
    self.currentDate = [_period.begin_date dateByAddingTimeInterval:(24*60*60)*[day intValue]];
    [self loadTips];
    [self loadTipsViews];
    [self reloadDayAndWeekLabel];
}

/** 
 * Called after the HUD was fully hidden from the screen. 
 */
- (void)hudWasHidden:(MBProgressHUD *)hud{
    _hud = nil;
}
@end
