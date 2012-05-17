//
//  SearchResultViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()
{
    
}

@end

@implementation SearchResultViewController
@synthesize resultView=_resultView;
@synthesize resultSet=_resultSet;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithResult:(NSArray *)result;{
    self = [self init];
    if (self) {
        self.resultSet = result;
    }
    return self;
}
- (void)dealloc
{
    [_resultSet release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.resultView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_resultSet count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellIdentifier = @"searchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        QuestionInfo *info = [_resultSet objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.text  = info.questionTitle;
        cell.detailTextLabel.text = info.questionTags;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionInfo *info = [_resultSet objectAtIndex:indexPath.row];
    QuestionDetailViewController *detailController = [[[QuestionDetailViewController alloc] initWithIdentifier:info._id] autorelease];
    [self.navigationController pushViewController:detailController animated:YES];
}



@end
