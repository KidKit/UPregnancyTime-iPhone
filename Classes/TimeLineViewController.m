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
@synthesize scrollView=_scrollView;
@synthesize pointerView=_pointerView;
@synthesize period = _period;
@synthesize rootDelegate=_rootDelegate;
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
    float contentHeight = calibrationBG.size.height*40;
    UIView *calibration = [[UIView alloc] initWithFrame:CGRectMake(18, 0, 32, contentHeight)]; 
    calibration.backgroundColor = [UIColor colorWithPatternImage:calibrationBG];
    _scrollView.contentSize = CGSizeMake(50, contentHeight);
    [_scrollView addSubview:calibration];
    [calibration release];
    _pointerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pointer"]];
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
    
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (!decelerate) {
        
        
    }
    
}
@end
