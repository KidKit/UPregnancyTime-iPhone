

#import "LabelConverter.h"
@implementation LabelInfo

@synthesize identifier = _identifier;
@synthesize labelName = _labelName;
@synthesize isRetractable = _isRetractable;
@synthesize isRemovable = _isRemovable;
@synthesize isSelected = _isSelected;
@synthesize isReturnLabel = _isReturnLabel;
@synthesize isParent = _isParent;
@synthesize bgImage = _bgImage;
@synthesize index=_index;


- (void)dealloc {
    [_labelName release];
    [_identifier release];
    [_bgImage release];
    [super dealloc];
}

+ (LabelInfo *)labelInfoWithIdentifier:(NSString *)identifier labelName:(NSString *)name isRetractable:(BOOL)retractable isParent:(BOOL)isParent{
    LabelInfo *info = [[[LabelInfo alloc] init] autorelease];
    info.identifier = identifier;
    info.labelName = name;
    info.isRetractable = retractable;
    info.isParent = isParent;
    return info;
}

- (void)setBgImage:(UIImage *)bgImage {
    if(_bgImage != bgImage) {
        [_bgImage release];
        _bgImage = [bgImage retain];
    }
}
@end
static LabelConverter *instance = nil;

@implementation LabelConverter

@synthesize configMap = _configMap;

- (void)dealloc {
    [_configMap release];
    [super dealloc];
}

+ (LabelConverter *)getInstance {
    if(instance == nil) {
        instance = [[LabelConverter alloc] init];
    }
    return instance;
}


- (void)configureLabelToContentMap {
    NSString *configFilePath = [[NSBundle mainBundle] pathForResource:@"LabelProperty-Config" ofType:@"plist"];  
    _configMap = [[NSDictionary alloc] initWithContentsOfFile:configFilePath]; 
}

- (id)init {
    self = [super init];
    if(self) {
        [self configureLabelToContentMap];
    }
    return self;
}

+ (NSArray *)getLabelsInfoWithLabelKeyArray:(NSArray *)labelKeyArray{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:labelKeyArray.count];
    int i=0;
    for(NSString *labelKey in labelKeyArray) {
        LabelInfo *info = [LabelConverter getLabelInfoWithIdentifier:labelKey];
        info.index = i;
        [result addObject:info];
        i++;
    }
    return result;
}

+ (NSArray *)getSystemDefaultLabelsIdentifier {
    LabelConverter *converter = [LabelConverter getInstance];
    return [converter.configMap objectForKey:kSystemDefaultLabels];
}

+ (NSArray *)getSystemDefaultLabelsInfo {
    NSArray *labelKeyArray = [LabelConverter getSystemDefaultLabelsIdentifier];
    return [self getLabelsInfoWithLabelKeyArray:labelKeyArray];
}

+ (NSArray *)getChildLabelsInfoWithParentLabelIndentifier:(NSString *)identifier andParentLabelName:(NSString *)name {
    LabelConverter *converter = [LabelConverter getInstance];
    NSMutableDictionary *parentLabelConfig = [NSMutableDictionary dictionaryWithDictionary:[converter.configMap objectForKey:identifier]];
    NSMutableArray *labelKeyArray = [NSMutableArray arrayWithObject:identifier];
    [labelKeyArray addObjectsFromArray:[parentLabelConfig objectForKey:kChildLabels]];
    NSArray *result = [self getLabelsInfoWithLabelKeyArray:labelKeyArray];
    LabelInfo *returnLabelInfo = [result objectAtIndex:0];
    returnLabelInfo.isReturnLabel = YES;
    if([identifier isEqualToString:kParentRenrenUser] || [identifier isEqualToString:kParentWeiboUser]) {
        returnLabelInfo.labelName = name;
    }
    return result;
}

+ (NSString *)getDefaultChildIdentifierWithParentIdentifier:(NSString *)identifier {
    LabelConverter *converter = [LabelConverter getInstance];
    NSDictionary *parentLabelConfig = [converter.configMap objectForKey:identifier];
    NSArray *childLabels = [parentLabelConfig objectForKey:kChildLabels];
    NSString *result = nil;
    if(childLabels) {
        result = [childLabels objectAtIndex:0];
    }
    else {
        result = identifier;
    }
    return result;
}

+ (LabelInfo *)getLabelInfoWithIdentifier:(NSString *)identifier {
    LabelConverter *converter = [LabelConverter getInstance];
    NSDictionary *labelConfig = [converter.configMap objectForKey:identifier];
    NSString *labelName = NSLocalizedString([labelConfig objectForKey:kLabelName],@"");
    NSNumber *isRetractable = [labelConfig objectForKey:kLabelIsRetractable];
    NSNumber *isParent = [labelConfig objectForKey:kLabelIsParent];
    NSString *bgImage = [labelConfig objectForKey:kLabelBgImage];
    LabelInfo *info = [LabelInfo labelInfoWithIdentifier:identifier labelName:labelName isRetractable:isRetractable.boolValue isParent:isParent.boolValue];
    [info setBgImage:[UIImage imageNamed:bgImage]];
    return info;
}

+ (NSUInteger)getSystemDefaultLabelCount {
    NSArray *systemDefaultLabelsIdentifier = [LabelConverter getSystemDefaultLabelsIdentifier];
    return systemDefaultLabelsIdentifier.count;
}

+ (NSUInteger)getSystemDefaultLabelIndexWithIdentifier:(NSString *)identifier {
    __block NSUInteger result = 0;
    NSArray *systemDefaultLabelsIdentifier = [LabelConverter getSystemDefaultLabelsIdentifier];
    [systemDefaultLabelsIdentifier enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *systemDefaultIdentifier = obj;
        if([identifier isEqualToString:systemDefaultIdentifier]) {
            result = idx;
            *stop = YES;
        }
    }];
    return result;
}

@end
