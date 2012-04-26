//
//  PeriodSettingViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PeriodSettingViewController.h"

@interface PeriodSettingViewController ()
{
    
}
-(void)setTextFieldStyle:(UITextField *)field;
-(void)showDatePickerWithAnimation:(UITextField *)sender;
-(void)hideDatePickerWithAnimation;
@end

@implementation PeriodSettingViewController
@synthesize contentView=_contentView;

@synthesize noticeLabel=_noticeLabel;
@synthesize endDateLabel=_endDateLabel;
@synthesize caculateNoticeLabel=_caculateNoticeLabel;
@synthesize lastMensesDateLabel=_lastMensesDateLabel;
@synthesize mensesCycleLabel=_mensesCycleLabel;

@synthesize endDateField=_endDateField;
@synthesize lastMensesDateField=_lastMensesDateField;
@synthesize mensesCycleField=_mensesCycleField;

@synthesize datePicker=_datePicker;

#pragma mark - private method

-(void)setTextFieldStyle:(UITextField *)field{
    field.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:16.0f];
    field.layer.cornerRadius=4.0f;
    field.layer.masksToBounds=YES;
    field.layer.borderColor=[UIColor brownColor].CGColor;
    field.layer.borderWidth= 1.0f;
}

-(void)showDatePickerWithAnimation:(UITextField *)sender{
    [UIView animateWithDuration:0.5f animations:^(void){
        _datePicker.frame = CGRectMake(0, self.view.frame.size.height-_datePicker.frame.size.height, _datePicker.frame.size.width, _datePicker.frame.size.height);
        [_datePicker addTarget:self action:NULL forControlEvents:      UIControlEventValueChanged];
        if (_datePicker.frame.origin.y<=sender.frame.origin.y) {
            float fix = sender.frame.origin.y - _datePicker.frame.origin.y + sender.frame.size.height;
            _contentView.frame = CGRectMake(_contentView.frame.origin.x, _contentView.frame.origin.y-fix, _contentView.frame.size.width, _contentView.frame.size.height);
        }
    }];
}
-(void)hideDatePickerWithAnimation{
    [UIView animateWithDuration:0.5f animations:^(void){
        _datePicker.frame = CGRectMake(0, self.view.frame.size.height, _datePicker.frame.size.width, _datePicker.frame.size.height);
        [_datePicker addTarget:self action:NULL forControlEvents:      UIControlEventValueChanged];
        if(_contentView.frame.origin.y!=0){
            _contentView.frame = CGRectMake(_contentView.frame.origin.x, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        }
    }];
}
#pragma mark - view life cycle
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
    _contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_bg"]];
    self.navigationItem.title = @"预产期设置";
    UIBarButtonItem *rightButton = [[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:nil action:NULL] autorelease];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button-pressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _endDateLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:20.0f];
    _lastMensesDateLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:20.0f];
    _mensesCycleLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:20.0f];
    
    _noticeLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:16.0f];
    _caculateNoticeLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:16.0f];
    
    [self setTextFieldStyle:_endDateField];
    [self setTextFieldStyle:_lastMensesDateField];
    [self setTextFieldStyle:_mensesCycleField];
    
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
#pragma mark - override UIView touche event method
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_datePicker.frame.origin.y<self.view.frame.size.height){
        [self hideDatePickerWithAnimation];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(_datePicker.frame.origin.y>=self.view.frame.size.height){
        [self showDatePickerWithAnimation:textField];
    }
    return NO;
}


@end
