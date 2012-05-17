//
//  NSObject+Addition.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#ifdef __BLOCKS__
typedef id (^populate_delegate_t)(NSString *,NSString*);
#endif

@interface NSObject (Addition)
+ (const char *) typeOfPropertyNamed: (NSString *) name;
+ (SEL) getterForPropertyNamed: (NSString *) name;
+ (SEL) setterForPropertyNamed: (NSString *) name;
+ (id) objWithDelegate:(populate_delegate_t)delegate;
@end

const char * property_getTypeString( objc_property_t property );
// getter/setter functions: unlike those above, these will return NULL unless a getter/setter is EXPLICITLY defined
SEL property_getGetter( objc_property_t property );
SEL property_getSetter( objc_property_t property );