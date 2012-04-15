//
//  BookmarkTableViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BookmarkTableViewController.h"

@interface BookmarkTableViewController ()
{
   
}
@end

@implementation BookmarkTableViewController
@synthesize mainView=_mainView;
@synthesize searchView=_searchView;
@synthesize resultView=_resultView;
@synthesize searchTextField=_searchTextField;
@synthesize rootDelegate=_rootDelegate;
@synthesize bookmarks=_bookmarks;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.bookmarks = [[DatabaseAccess sharedAccess] executeQueryForList:[PregnancyBookmark class] limit:30 withSql:@"select * from pregnancy_bookmark order by mark_time desc" withArgumentsInArray:nil];
    }
    return self;
}
- (void)dealloc
{
    [_bookmarks release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _resultView.backgroundColor = [UIColor clearColor];
    _searchView.backgroundColor = [UIColor clearColor];
    _mainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainView = nil;
    self.searchView = nil;
    self.resultView= nil;
    self.searchTextField= nil;
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
@end
