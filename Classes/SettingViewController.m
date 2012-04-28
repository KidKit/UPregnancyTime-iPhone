//
//  SettingViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
{
    
}
@end

@implementation SettingViewController
@synthesize rootDelegate=_rootDelegate;
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
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"settingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = @"test";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}// Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger) section{
    return [NSString stringWithFormat:@"test-%d",section];
}

@end
