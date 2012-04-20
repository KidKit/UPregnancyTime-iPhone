//
//  DaliyTipsViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DaliyTipsViewController.h"

@interface DaliyTipsViewController ()

@end

@implementation DaliyTipsViewController
@synthesize calendarView=_calendarView;
@synthesize scrollView=_scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *catagoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 260)];
    catagoryView.center = _scrollView.center;
    UIImage *labelImage = [UIImage imageNamed:@"main_folder1"];
    UIImageView *labelView = [[[UIImageView alloc] initWithImage:labelImage] autorelease];
    [catagoryView addSubview:labelView];
    UIImage *iconImage = [UIImage imageNamed:@"1"];
    UIImageView *iconView = [[[UIImageView alloc] initWithImage:iconImage] autorelease];
    [catagoryView addSubview:iconView];
    UILabel *labelText = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelImage.size.width, labelImage.size.height)] autorelease];
    labelText.backgroundColor = [UIColor clearColor];
    labelText.text=@"看看效果";
    labelText.textColor = [UIColor whiteColor];
    labelText.font = [UIFont boldSystemFontOfSize:18];
    [catagoryView addSubview:labelView];
    [_scrollView addSubview:catagoryView];
    
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

@end
