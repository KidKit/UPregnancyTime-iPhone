//
//  MenuViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
{
    
}
@end

@implementation MenuViewController
@synthesize labelInfos=_labelInfos;
@synthesize tableView=_tableView;
@synthesize rootDelegate = _rootDelegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.labelInfos = [LabelConverter getSystemDefaultLabelsInfo];
        
    }
    return self;
}
- (void)dealloc
{
    [_labelInfos release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu-background"]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //UIImageView *chevron = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-divider"]] autorelease];
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int menuIndex = indexPath.row;
    LabelInfo *labelInfo = [_labelInfos objectAtIndex:menuIndex];
    if([_rootDelegate respondsToSelector:@selector(onMenuItemClickedWithInfo:)]){
        [_rootDelegate onMenuItemClickedWithInfo:labelInfo];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_labelInfos count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    int menuIndex = indexPath.row;
    static NSString *CellIdentifier = @"TimeLineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)  
    {  
        // Create a cell to display an ingredient.  
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        UIImageView *chevron = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu-chevron"]] autorelease];
        [cell setAccessoryView:chevron];
        UIView *dividerView = [[[UIView alloc] init] autorelease];
        dividerView.frame = CGRectMake(0, cell.frame.size.height-1, cell.frame.size.width, 1);
        UIImage *divider = [UIImage imageNamed:@"menu-divider"];
        dividerView.backgroundColor = [UIColor colorWithPatternImage:divider];
        [cell addSubview:dividerView];
        
        
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
        cell.textLabel.textColor = [UIColor whiteColor];
        LabelInfo *labelInfo = [_labelInfos objectAtIndex:menuIndex];
        UIView *bgColorView = [[UIView alloc] init];
        [bgColorView setBackgroundColor:[UIColor darkGrayColor]];
        [cell setSelectedBackgroundView:bgColorView];
        [bgColorView release];
        cell.textLabel.text= labelInfo.labelName;
        cell.imageView.image = labelInfo.bgImage;
        //= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Help"]] autorelease];
    }
    //cell.
    return cell;
}
@end
