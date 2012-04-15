//
//  LabelConverter.h
//  SocialFusion
//
//  Created by 王紫川 on 12-1-22.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTodayTips          @"kTodayTips"

#define kTimeline         @"kTimeline"
#define kTodayTipsArticle    @"kCheckArticleList"
#define kTodayTipsProposal @"kCheckProposalList"
#define kQuestionAndAnswer       @"kQuestionAndAnswer"
#define kSearchInfo        @"kSearchInfo"
#define kBookmarks        @"kBookmarks"
#define kSettings        @"kSettings"

#define kSystemDefaultLabels    @"kSystemDefaultLabels"
#define kLabelName              @"kLabelName"
#define kLabelIsRetractable     @"kLabelIsRetractable"
#define kChildLabels            @"kChildLabels"
#define kLabelIsParent          @"kLabelIsParent"
#define kLabelBgImage         @"kLabelBgImage"

#define kParentWeiboUser        @"kParentWeiboUser"
#define kParentRenrenUser       @"kParentRenrenUser"

@interface LabelInfo : NSObject {

}

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *labelName;
@property (nonatomic) BOOL isRetractable;
@property (nonatomic) BOOL isRemovable;
@property (nonatomic) BOOL isSelected;
@property (nonatomic) BOOL isReturnLabel;
@property (nonatomic) BOOL isParent;
@property (nonatomic, retain) UIImage *bgImage;
@property (atomic) int index;



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
