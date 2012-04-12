//
//  HomeView.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PregnancyDaliyTips.h"
#import "PagingView.h"

@protocol AHomeViewDelegate;
@interface AHomeView : UIView



@property (nonatomic,retain)IBOutlet UILabel *tips1Label;
@property (nonatomic,retain)IBOutlet UITextView *tips1TextView;
@property (nonatomic,retain)IBOutlet UIButton *tips1DetailButton;
@property (nonatomic,retain)IBOutlet UILabel *tips2Label;
@property (nonatomic,retain)IBOutlet UITextView *tips2TextView;
@property (nonatomic,retain)IBOutlet UIButton *tips2DetailButton;
@property (nonatomic,retain)IBOutlet UILabel *tips3Label;
@property (nonatomic,retain)IBOutlet UITextView *tips3TextView;
@property (nonatomic,retain)IBOutlet UIButton *tips3DetailButton;
@property (nonatomic,retain)IBOutlet UILabel *tips4Label;
@property (nonatomic,retain)IBOutlet UITextView *tips4TextView;
@property (nonatomic,retain)IBOutlet UIButton *tips4DetailButton;
@property (nonatomic,assign)id<AHomeViewDelegate>delegate;

-(IBAction)onDetailButtonClicked:(id)sender;

-(void)populateTipsViewWithDataArray:(NSArray*)dataArray atPageIndex:(int)pageIndex pageCount:(int) pageCount;
@end


@protocol AHomeViewDelegate <NSObject>

-(void)onDetailButtonClicked:(id)sender;

@end