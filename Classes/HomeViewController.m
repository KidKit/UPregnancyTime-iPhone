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
    int _currentTipsPageIndex;
}

-(void)loadPeriod;

-(void)loadTips;

-(void)loadTipsTypes;

-(void)loadTipsViews;

-(void)updateDayLabel;

-(int)sequenceInDate:(NSDate *)date;

-(int)sequenceInWeek:(int)sequenceInDate;


@end

@implementation HomeViewController
@synthesize tipsTypes = _tipsTypes;
@synthesize tips = _tips;
@synthesize startPoint=_startPoint;
@synthesize dayLabel=_dayLabel;
@synthesize currentDate=_currentDate;
@synthesize period = _period;
@synthesize tipsTableView=_tipsTableView;
@synthesize tipsViews = _tipsViews;
@synthesize rootDelegate=_rootDelegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.currentDate = [NSDate date];
        [self loadPeriod];
        [self loadTipsTypes];
        [self loadTips];
        self.navigationItem.title = @"每日提醒";
        UIBarButtonItem *leftButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-menu-icon"] style:UIBarButtonItemStyleBordered target:_rootDelegate action:@selector(onMenuButtonClicked)] autorelease];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button-pressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        self.navigationItem.leftBarButtonItem = leftButton;
    }
    return self;
}
- (void)dealloc
{
    [_tipsTypes release];
    [_tips release];
    [_period release];
    [_currentDate release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _tipsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    NSLog(@"_tipsTableView frame:%f,%f,%f,%f",_tipsTableView.frame.origin.x,_tipsTableView.frame.origin.y,_tipsTableView.frame.size.width,_tipsTableView.frame.size.height);
    [self loadTipsViews];
    //加载日期标签
    NSArray *labelViewArray = [[NSBundle mainBundle] loadNibNamed:@"CalendarView" owner:nil options:nil];
    self.dayLabel = [labelViewArray lastObject];
    _dayLabel.frame = CGRectMake(0, 10, _dayLabel.frame.size.width, _dayLabel.frame.size.height);
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
    self.tipsTableView = nil;
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
    //NSLog(@"_period.begin_date:%@",_period.begin_date);
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
        page.frame = CGRectMake(0, 0, page.frame.size.width, page.frame.size.height);
        page.delegate=self;
        [_tipsViews addObject:page];
    }
}
-(void)updateDayLabel{
    [_dayLabel populateWithDate:_currentDate sequenceInWeek:_sequanceInWeek sequenceInDate:_sequanceInDate];
}
-(int)sequenceInDate:(NSDate *)date{
    //开始时间距离实际当前时间的天数
    int realDaysAgo = [_period.begin_date daysAgoAgainstMidnight];
    //NSLog(@"days ago:%@ with %d",_period.begin_date,realDaysAgo);
    //给定时间距离当前时间的天数
    int currentDaysAgo = [date daysAgoAgainstMidnight];
    //NSLog(@"days ago:%@ with %d",date,currentDaysAgo);
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


#pragma mark - AHomeViewDelegate

-(void)onDetailButtonClicked:(id)sender{
    UIButton *button = (UIButton *)sender;
    PregnancyDaliyTips *tips = [_tips objectAtIndex:button.tag];
    TipsViewController *tvc = [[TipsViewController alloc] initWithdata:tips];
    [self.navigationController pushViewController:tvc animated:YES];
    [tvc release];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tipsViews count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"TipsViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)  
    {  
        // Create a cell to display an ingredient.  
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        [cell addSubview:[_tipsViews objectAtIndex:indexPath.row]];
    }
    return  cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 416.0f;
}

#pragma mark - UIView override

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    return NO;
}

@end
