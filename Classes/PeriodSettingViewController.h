//
//  PeriodSettingViewController.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PeriodSettingViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic,retain)IBOutlet UIView *contentView;
@property (nonatomic,retain)IBOutlet UILabel *noticeLabel;
@property (nonatomic,retain)IBOutlet UILabel *endDateLabel;
@property (nonatomic,retain)IBOutlet UILabel *caculateNoticeLabel;
@property (nonatomic,retain)IBOutlet UILabel *lastMensesDateLabel;
@property (nonatomic,retain)IBOutlet UILabel *mensesCycleLabel;

@property (nonatomic,retain)IBOutlet UITextField *endDateField;
@property (nonatomic,retain)IBOutlet UITextField *lastMensesDateField;
@property (nonatomic,retain)IBOutlet UITextField *mensesCycleField;

@property (nonatomic,retain)IBOutlet UIDatePicker *datePicker;

@end
