//
//  NSObject+Addition.m
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-4-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Addition.h"

@implementation NSObject (Addition)

+ (const char *) typeOfPropertyNamed: (NSString *) name
{
	objc_property_t property = class_getProperty( self, [name UTF8String] );
	if ( property == NULL )
		return ( NULL );
	
	return ( property_getTypeString(property) );
}

+ (SEL) getterForPropertyNamed: (NSString *) name
{
	objc_property_t property = class_getProperty( self, [name UTF8String] );
	if ( property == NULL )
		return ( NULL );
	
	SEL result = property_getGetter( property );
	if ( result != NULL )
		return ( NULL );
	
	if ( [self instancesRespondToSelector: NSSelectorFromString(name)] == NO )
		[NSException raise: NSInternalInconsistencyException 
					format: @"%@ has property '%@' with no custom getter, but does not respond to the default getter",
		 self, name];
	
	return ( NSSelectorFromString(name) );
}

+ (SEL) setterForPropertyNamed: (NSString *) name
{
	objc_property_t property = class_getProperty( self, [name UTF8String] );
	if ( property == NULL )
		return ( NULL );
	
	SEL result = property_getSetter( property );
	if ( result != NULL )
		return ( result );
	
	// build a setter name
	NSMutableString * str = [NSMutableString stringWithString: @"set"];
	[str appendString: [[name substringToIndex: 1] uppercaseString]];
	if ( [name length] > 1 ){
        [str appendString: [name substringFromIndex: 1]];
        [str appendString:@":"];
    }
    
	
	if ( [self instancesRespondToSelector: NSSelectorFromString(str)] == NO )
		[NSException raise: NSInternalInconsistencyException 
					format: @"%@ has property '%@' with no custom setter, but does not respond to the default setter",
		 self, str];
	
	return ( NSSelectorFromString(str) );
}
+(id) objWithDelegate:(populate_delegate_t)delegate{
    Class clazz= [self class];
    id _self = [clazz new];
    u_int p_count;
    objc_property_t *properties  = class_copyPropertyList(clazz, &p_count);
    for (int i = 0; i < p_count ; i++)   
    { 
        const char* propertyName = property_getName(properties[i]);
        NSString *pName = [NSString  stringWithUTF8String: propertyName];
        const char* propertyTypeName = property_getTypeString(properties[i]);
        NSString *pTypeName = [NSString  stringWithUTF8String: propertyTypeName];
        id pValue = delegate(pTypeName,pName);
        if (pValue != [NSNull null]) {
            SEL setter = [clazz setterForPropertyNamed:pName];
            if([_self respondsToSelector:setter]){
                [_self performSelector:setter withObject:pValue];
            }
        }
        
    }
    free(properties);
    return  [_self autorelease];
}

@end

const char * property_getTypeString( objc_property_t property )
{
	const char * attrs = property_getAttributes( property );
	if ( attrs == NULL )
		return ( NULL );
	
	static char buffer[256];
	const char * e = strchr( attrs, ',' );
	if ( e == NULL )
		return ( NULL );
	
	int len = (int)(e - attrs);
	memcpy( buffer, attrs, len );
	buffer[len] = '\0';
	
	return ( buffer );
}
SEL property_getGetter( objc_property_t property )
{
	const char * attrs = property_getAttributes( property );
	if ( attrs == NULL )
		return ( NULL );
	
	const char * p = strstr( attrs, ",G" );
	if ( p == NULL )
		return ( NULL );
	
	p += 2;
	const char * e = strchr( p, ',' );
	if ( e == NULL )
		return ( sel_getUid(p) );
	if ( e == p )
		return ( NULL );
	
	int len = (int)(e - p);
	char * selPtr = malloc( len + 1 );
	memcpy( selPtr, p, len );
	selPtr[len] = '\0';
	SEL result = sel_getUid( selPtr );
	free( selPtr );
	
	return ( result );
}

SEL property_getSetter( objc_property_t property )
{
	const char * attrs = property_getAttributes( property );
	if ( attrs == NULL )
		return ( NULL );
	
	const char * p = strstr( attrs, ",S" );
	if ( p == NULL )
		return ( NULL );
	
	p += 2;
	const char * e = strchr( p, ',' );
	if ( e == NULL )
		return ( sel_getUid(p) );
	if ( e == p )
		return ( NULL );
	
	int len = (int)(e - p);
	char * selPtr = malloc( len + 1 );
	memcpy( selPtr, p, len );
	selPtr[len] = '\0';
	SEL result = sel_getUid( selPtr );
	free( selPtr );
	
	return ( result );
}