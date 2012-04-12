//
//  LabelConverter.h
//  SocialFusion
//
//  Created by 王紫川 on 12-1-22.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTodayTips          @"kTodayTips"

#define kCheckList         @"kCheckList"
#define kTodayTipsArticle    @"kCheckArticleList"
#define kTodayTipsProposal @"kCheckProposalList"

#define kQuestionAndAnswer       @"kQuestionAndAnswer"

#define kSearchInfo        @"kSearchInfo"

#define kSystemDefaultLabels    @"kSystemDefaultLabels"
#define kLabelName              @"kLabelName"
#define kLabelIsRetractable     @"kLabelIsRetractable"
#define kChildLabels            @"kChildLabels"
#define kLabelIsParent          @"kLabelIsParent"
#define kLabelBgImage         @"kLabelBgImage"

#define kParentWeiboUser        @"kParentWeiboUser"
#define kParentRenrenUser       @"kParentRenrenUser"

@interface LabelInfo : NSObject {
@private
    NSString *_identifier;
    NSString *_labelName;
    BOOL _isRemovable;
    BOOL _isSelected;
    BOOL _isReturnLabel;
    BOOL _isParent;
    
    UIImage *_bgImage;
}

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *labelName;
@property (nonatomic) BOOL isRetractable;
@property (nonatomic) BOOL isRemovable;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isReturnLabel;
@property (nonatomic) BOOL isParent;
@property (nonatomic, retain) UIImage *bgImage;



+ (LabelInfo *)labelInfoWithIdentifier:(NSString *)identifier labelName:(NSString *)name isRetractable:(BOOL)retractable isParent:(BOOL)isParent;
@end

@interface LabelConverter : NSObject {
    NSDictionary *_configMap;
}

@property (nonatomic, readonly) NSDictionary *configMap;

+ (LabelConverter *)getInstance;
+ (LabelInfo *)getLabelInfoWithIdentifier:(NSString *)identifier;
+ (NSArray *)getSystemDefaultLabelsInfo;
+ (NSArray *)getSystemDefaultLabelsIdentifier;
+ (NSArray *)getChildLabelsInfoWithParentLabelIndentifier:(NSString *)identifier andParentLabelName:(NSString *)name;
+ (NSString *)getDefaultChildIdentifierWithParentIdentifier:(NSString *)parentIdentifier;
+ (NSUInteger)getSystemDefaultLabelCount;
+ (NSUInteger)getSystemDefaultLabelIndexWithIdentifier:(NSString *)identifier;

@end
