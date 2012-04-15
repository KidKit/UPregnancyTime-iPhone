//
//  QAViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "QAViewController.h"

@interface QAViewController ()

@end

@implementation QAViewController
@synthesize searchView = _searchView;
@synthesize resultView=_resultView;
@synthesize mainView=_mainView;
@synthesize searchTextField = _searchTextField;
@synthesize overlay = _overlay;
@synthesize rootDelegate=_rootDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"孕期问答";
        UIBarButtonItem *leftButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav-menu-icon"] style:UIBarButtonItemStyleBordered target:_rootDelegate action:@selector(onMenuButtonClicked)] autorelease];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [leftButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button-pressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        self.navigationItem.leftBarButtonItem = leftButton;
    }
    return self;
}
- (void)dealloc
{
    [_overlay release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _resultView.backgroundColor = [UIColor clearColor];
    _searchView.backgroundColor = [UIColor clearColor];
    _mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    self.view.backgroundColor = [UIColor clearColor];;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainView = nil;
    self.searchView = nil;
    self.resultView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SearchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)  
    {  
        // Create a cell to display an ingredient.  
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = @"test";
    return cell;
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.overlay = [[[OverlayViewController alloc] init] autorelease];
    _overlay.delegate = self;
    CGFloat xaxis = _resultView.frame.origin.x;
    CGFloat yaxis = _resultView.frame.origin.y;
    CGFloat width = _resultView.frame.size.width;
    CGFloat height = _resultView.frame.size.height;
    CGRect frame = CGRectMake(xaxis, yaxis, width, height);
    _overlay.view.frame = frame;
    _overlay.view.backgroundColor = [UIColor grayColor];
    _overlay.view.alpha = 0.5;
    [_mainView insertSubview:_overlay.view aboveSubview:_resultView];
    
    NSLog(@"UITextFieldDelegate-textFieldDidBeginEditing");
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    NSLog(@"UITextFieldDelegate-textFieldShouldClear");
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"UITextFieldDelegate-textFieldShouldClear");
    [_overlay.view removeFromSuperview];
    [_searchTextField resignFirstResponder];
    return YES;
}

#pragma mark - OverlayViewControllerDelegate

-(void)touchBeginOnOverlayView{
    [_overlay.view removeFromSuperview];
    [_searchTextField resignFirstResponder];
    
}
@end
