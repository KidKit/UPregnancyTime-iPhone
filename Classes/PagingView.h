//
//  PageView.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

@interface PagingView : UIView
-(id)initWithPageSize:(int)size;

-(void)goToPage:(int)page;
@end
