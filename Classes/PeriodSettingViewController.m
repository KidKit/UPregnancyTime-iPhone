//
//  PeriodSettingViewController.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PeriodSettingViewController.h"
#define END_DATE_FIELD_TAG 101
#define LAST_DATE_FIELD_TAG 102
#define CYCLE_FIELD_TAG 103

@interface PeriodSettingViewController ()
{
    int currentFieldTag;
}
-(void)setTextFieldStyle:(UITextField *)field;
-(void)showDatePickerWithAnimation:(UITextField *)sender;
-(void)hideDatePickerWithAnimation;
-(void)showCyclePickerWithAnimation:(UITextField *)sender;
-(void)hideCyclePickerWithAnimation;
-(void)caculateEndDate;
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
@synthesize cyclePicker=_cyclePicker;


@synthesize periodChangeDelegate=_periodChangeDelegate;
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
        if (_datePicker.frame.origin.y<=sender.frame.origin.y) {
            float fix = sender.frame.origin.y - _datePicker.frame.origin.y + sender.frame.size.height;
            _contentView.frame = CGRectMake(_contentView.frame.origin.x, _contentView.frame.origin.y-fix, _contentView.frame.size.width, _contentView.frame.size.height);
        }
    }];
}
-(void)hideDatePickerWithAnimation{
    [UIView animateWithDuration:0.5f animations:^(void){
        _datePicker.frame = CGRectMake(0, self.view.frame.size.height, _datePicker.frame.size.width, _datePicker.frame.size.height);
        if(_contentView.frame.origin.y!=0){
            _contentView.frame = CGRectMake(_contentView.frame.origin.x, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        }
    }];
}
-(void)showCyclePickerWithAnimation:(UITextField *)sender{
    [UIView animateWithDuration:0.5f animations:^(void){
        _cyclePicker.frame = CGRectMake(_cyclePicker.frame.origin.x,  self.view.frame.size.height-_cyclePicker.frame.size.height, _cyclePicker.frame.size.width, _cyclePicker.frame.size.height);
        if (_cyclePicker.frame.origin.y<=sender.frame.origin.y) {
            float fix = sender.frame.origin.y - _cyclePicker.frame.origin.y + sender.frame.size.height;
            _contentView.frame = CGRectMake(_contentView.frame.origin.x, _contentView.frame.origin.y-fix, _contentView.frame.size.width, _contentView.frame.size.height);
        }
    }];
}
-(void)hideCyclePickerWithAnimation{
    [UIView animateWithDuration:0.5f animations:^(void){
        _cyclePicker.frame = CGRectMake(0, self.view.frame.size.height, _cyclePicker.frame.size.width, _cyclePicker.frame.size.height);
        if(_contentView.frame.origin.y!=0){
            _contentView.frame = CGRectMake(_contentView.frame.origin.x, 0, _contentView.frame.size.width, _contentView.frame.size.height);
        }
    }];

}
-(void)caculateEndDate{
    if ([_lastMensesDateField.text length]>0&&[_mensesCycleField.text length]>0) {
        int cycle = [_mensesCycleField.text intValue];
        NSDate *lastDate = [NSDate dateFromString:_lastMensesDateField.text withFormat:[NSDate dateFormatStringCNFull]];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *monthComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:lastDate];
        [monthComponents setDay:[monthComponents day]+280-(cycle-28)];
        NSDate *endDate = [calendar dateFromComponents:monthComponents];
        _endDateField.text = [NSDate stringFromDate:endDate withFormat:[NSDate dateFormatStringCNFull]];
    }
    
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
    UIBarButtonItem *rightButton = [[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(savePeriod)] autorelease];
    if ([rightButton respondsToSelector:@selector(setBackgroundImage:)]) {
        [rightButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [rightButton setBackgroundImage:[UIImage imageNamed:@"nav-bar-button-pressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }else {
//        UIButton * btn = [[[UIButton alloc] init] autorelease];
//        [btn setImage:[UIImage imageNamed:@"nav-bar-button"] forState:UIControlStateNormal];
//        [btn setTitle:@"完成" forState:UIControlStateNormal];
//        rightButton = [[[UIBarButtonItem alloc] initWithCustomView:btn] autorelease];
    }
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _endDateLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:20.0f];
    _lastMensesDateLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:20.0f];
    _mensesCycleLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:20.0f];
    
    _noticeLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:16.0f];
    _caculateNoticeLabel.font = [UIFont fontWithName:APP_TEXT_FONT_NAME size:16.0f];
    
    [self setTextFieldStyle:_endDateField];
    [self setTextFieldStyle:_lastMensesDateField];
    [self setTextFieldStyle:_mensesCycleField];
    _endDateField.tag=END_DATE_FIELD_TAG;
    _lastMensesDateField.tag=LAST_DATE_FIELD_TAG;
    _mensesCycleField.tag=CYCLE_FIELD_TAG;
    PregnancyPeriod *period = [[CommonDataHolder instance] loadPeriod];
    if (period) {
        _endDateField.text = [[period due_date] stringWithFormat:[NSDate dateFormatStringCNFull] ];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.noticeLabel=nil;
    self.endDateLabel=nil;
    self.endDateField=nil;
    self.caculateNoticeLabel=nil;
    self.lastMensesDateLabel=nil;
    self.lastMensesDateField=nil;
    self.mensesCycleLabel=nil;
    self.mensesCycleField=nil;
    self.datePicker=nil;
    self.cyclePicker=nil;
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
    if(_cyclePicker.frame.origin.y<self.view.frame.size.height){
        [self hideCyclePickerWithAnimation];
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    currentFieldTag = textField.tag;
    if (textField.tag!=CYCLE_FIELD_TAG) {
        if(_datePicker.frame.origin.y>=self.view.frame.size.height){
            if([textField.text length]>0){
                _datePicker.date = [NSDate dateFromString:textField.text withFormat:[NSDate dateFormatStringCNFull]];
            }else {
                if (textField.tag!=END_DATE_FIELD_TAG) {
                    _datePicker.date = [NSDate date];
                    textField.text= [NSDate stringFromDate:_datePicker.date withFormat:[NSDate dateFormatStringCNFull]];
                }
            }
            [self hideCyclePickerWithAnimation];
            [self showDatePickerWithAnimation:textField];
        }
    }else {
        if(_cyclePicker.frame.origin.y>=self.view.frame.size.height){
            if([textField.text length]>0){
                [_cyclePicker selectRow:[textField.text intValue]-20 inComponent:0 animated:NO];
            }else {
                [_cyclePicker selectRow:8 inComponent:0 animated:NO];
                textField.text= [NSString stringWithFormat:@"%d",28];
            }
            [self hideDatePickerWithAnimation];
            [self showCyclePickerWithAnimation:textField];
        }
    }
    [self caculateEndDate];
    return NO;
}
#pragma mark - UIDatePicker value change
-(IBAction)onDatePickerValueChanged:(id)sender{
    UIDatePicker *picker = (UIDatePicker*)sender;
    UITextField *field = (UITextField*)[_contentView viewWithTag:currentFieldTag];
    field.text= [NSDate stringFromDate:picker.date withFormat:[NSDate dateFormatStringCNFull]];
    if (currentFieldTag!=END_DATE_FIELD_TAG) {
        [self caculateEndDate];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 30;
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d",20+row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    UITextField *field = (UITextField*)[_contentView viewWithTag:currentFieldTag];
    field.text= [NSString stringWithFormat:@"%d",20+row];
    [self caculateEndDate];
}
#pragma mark - Database operation
-(void)savePeriod{
    PregnancyPeriod *_period = [[CommonDataHolder instance] loadPeriod];
    if (_period==nil) {
        _period = [[[PregnancyPeriod alloc] init] autorelease];
    }
    [self caculateEndDate];
    
    if([_endDateField.text length]>0){
        NSDate *endDate = [NSDate dateFromString:_endDateField.text withFormat:[NSDate dateFormatStringCNFull]];
        
        NSDate *beginDate = [endDate dateByAddingTimeInterval:-280*(24*60*60)];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        hud.dimBackground = YES;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setObject:endDate forKey:PERIOD_DUE_DATE_KEY];
            [def setObject:beginDate forKey:PERIOD_BEGIN_DATE_KEY];
            [def setObject:_mensesCycleField.text forKey:PERIOD_CYCLE_KEY];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
                if ([_periodChangeDelegate respondsToSelector:@selector(completedChange)]) {
                    [_periodChangeDelegate performSelector:@selector(completedChange) withObject:nil];
                }else{
                    [self.navigationController popViewControllerAnimated:YES];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:kIASKAppSettingChanged object:self userInfo:[NSDictionary dictionaryWithObject:endDate forKey:PERIOD_DUE_DATE_KEY]];
                
            });
        });
        
    }
}
@end
