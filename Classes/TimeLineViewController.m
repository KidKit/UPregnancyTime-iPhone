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
    
}

-(void)loadPeriod;
@end

@implementation TimeLineViewController
@synthesize dayLabel=_dayLabel;
@synthesize scrollView=_scrollView;
@synthesize period = _period;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self loadPeriod];
        UITabBarItem *tabBarItem = [[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:2] autorelease];
        self.tabBarItem = tabBarItem;
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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    _scrollView.backgroundColor =[UIColor clearColor];
    //加载日期标签
    NSArray *labelViewArray = [[NSBundle mainBundle] loadNibNamed:@"CalendarView" owner:nil options:nil];
    self.dayLabel = [labelViewArray lastObject];
    _dayLabel.frame = CGRectMake(0, 50, _dayLabel.frame.size.width, _dayLabel.frame.size.height);
    [self.view addSubview:_dayLabel];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.dayLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - load data from db

-(void)loadPeriod{
    self.period = [[DatabaseAccess sharedAccess] executeQueryForUnique:[PregnacyPeriod class] withSql:@"select * from pregnancy_period" withArgumentsInArray:nil];
    //[[[NSDate date] dateByAddingTimeInterval:(24*60*60*220)] timeIntervalSince1970]
    //NSLog(@"_period.begin_date:%@",_period.begin_date);
}

#pragma mark UIScrollViewDelegateMethods

//The TimeScroller needs to know what's happening with the UITableView (UIScrollView)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSArray *visibleRows = [_scrollView indexPathsForVisibleRows];
    if([visibleRows count]>0){
        NSIndexPath *currentIndex = [visibleRows objectAtIndex:0];
        int daliy = currentIndex.section*7+currentIndex.row+1;
        NSDate *currentDate = [_period.begin_date dateByAddingTimeInterval:(24*60*60)*daliy];
        [_dayLabel populateWithDate:currentDate sequenceInWeek:currentIndex.section+1 sequenceInDate:daliy];
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        
        
    }
    
}
#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 430;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimeLineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)  
    {  
        // Create a cell to display an ingredient.  
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 1; i<5; i++) {
            NSString *tagImageName = [NSString  stringWithFormat:@"tag_%d",i];
            UIImage *tipsBG = [UIImage imageNamed:tagImageName];
            UIImageView *tipsBGView = [[[UIImageView alloc] initWithImage:tipsBG] autorelease];
            tipsBGView.frame = CGRectMake(0, 0, tipsBG.size.width, tipsBG.size.height);
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, tipsBG.size.width, tipsBG.size.height);
            button.backgroundColor = [UIColor clearColor];
            button.showsTouchWhenHighlighted = YES;
            button.userInteractionEnabled = YES;
            [button setTitle:@"button_1" forState:UIControlStateNormal];
            UIView *tipsView = [[[UIView alloc] initWithFrame:CGRectMake(60, 45+(i-1)*tipsBG.size.height, tipsBG.size.width, tipsBG.size.height)] autorelease];
            tipsView.backgroundColor = [UIColor clearColor];
            [tipsView addSubview:tipsBGView];
            [tipsView addSubview:button];
            [cell addSubview:tipsView];
        }
        
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return nil;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:40];
    for(int i=0;i<40;i++){
        [array addObject:[NSString stringWithFormat:@"%d",i+1 ]]; 
    }
    return array;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [title integerValue];
}
@end
