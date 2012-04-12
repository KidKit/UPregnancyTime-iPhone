//
//  DatabaseAccess.m
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatabaseAccess.h"
#import "NSObject+Properties.h"
@interface DatabaseAccess(){
    
}
-(id)parseObj:(Class)clazz FromResultset:(FMResultSet *)result;
@end
@implementation DatabaseAccess

+ (DatabaseAccess *)sharedAccess

// See comment in header.

{    
    static DatabaseAccess * databaseAccess;    
    if (databaseAccess == nil) {        
        @synchronized (self) {            
            databaseAccess = [[DatabaseAccess alloc] init];            
            assert(databaseAccess != nil);            
        }        
    }    
    return databaseAccess;    
}

+(NSString *)dbFilePath{
    return [[NSBundle mainBundle] pathForResource:@"ubabytime" ofType:@"sqlite"];
}

- (id)init
{
    self = [super init];
    if (self) {
        _db = [[FMDatabase databaseWithPath:[DatabaseAccess dbFilePath]] retain];
        _db.logsErrors = YES;
    }
    return self;
}

- (void)dealloc
{
    [_db close];
    [_db release];
    [super dealloc];
}

-(id)parseObj:(Class)clazz fromResultset:(FMResultSet *)result{
    id obj = [clazz new];
    u_int p_count;   
    objc_property_t *properties  = class_copyPropertyList(clazz, &p_count);
    for (int i = 0; i < p_count ; i++)   
    {  
        const char* propertyName = property_getName(properties[i]);
        NSString *pName = [NSString  stringWithUTF8String: propertyName];
        const char* propertyTypeName = [obj typeOfPropertyNamed:pName];
        NSString *pTypeName = [NSString  stringWithUTF8String: propertyTypeName];
        //NSLog(@"propertyTypeName:%@",pTypeName);
        id pValue = nil;
        
        if([pTypeName rangeOfString:@"Number"].length>0){
            pValue = [result objectForColumnName:pName];
        }
        if([pTypeName rangeOfString:@"String"].length>0){
            pValue = [result stringForColumn:pName];
        }
        if([pTypeName rangeOfString:@"NSDate"].length>0){
            pValue = [result dateForColumn:pName];
        }
        if([pTypeName rangeOfString:@"NSData"].length>0){
            pValue = [result dataForColumn:pName];
        }
        if(!pValue){
            pValue = [result objectForColumnName:pName];
        }
        SEL setter = [obj setterForPropertyNamed:pName];
        if([obj respondsToSelector:setter]){
            [obj performSelector:setter withObject:pValue];
        }
        //[obj setValue:pValue forKey:pName];
    }
    free(properties);
    return [obj autorelease];
}

-(id)executeQueryForUnique:(Class) clazz withSql:(NSString *)sql withArgumentsInArray:(NSArray *)args{
    [_db open];
    FMResultSet *result = (args==nil)?[_db executeQuery:sql]:[_db executeQuery:sql withArgumentsInArray:args];
    id obj = nil;
    while([result next]){
        obj = [self parseObj:clazz fromResultset:result];
        break;
    }
    [_db close];
    return  obj;
}

-(NSArray*)executeQueryForList:(Class) clazz limit:(int)limit withSql:(NSString *)sql withArgumentsInArray:(NSArray *)args{
    [_db open];
    FMResultSet *result = (args==nil)?[_db executeQuery:sql]:[_db executeQuery:sql withArgumentsInArray:args];
    NSMutableArray *array = [NSMutableArray array];
    int i=0;
    while([result next]){
        if(i<limit){
            id obj = [self parseObj:clazz fromResultset:result];
            [array addObject:obj];
            i++;
        }else {
            break;
        }
        
    }
    [_db close];
    return array;
}

-(BOOL)insertObject:(id<Entity>)obj{
    NSString *tableName = [obj tableName];
    u_int p_count;   
    objc_property_t *properties  = class_copyPropertyList([obj class], &p_count);
    NSMutableString *sql_1 = [NSMutableString stringWithFormat:@"insert into %@ (",tableName];
    NSMutableString *sql_2 = [NSMutableString stringWithFormat:@"values ("];
    NSMutableArray *vArray = [NSMutableArray array];
    for (int i = 0; i < p_count ; i++){
        const char* propertyName = property_getName(properties[i]);
        NSString *pName = [NSString  stringWithUTF8String: propertyName];
        id pValue = [obj performSelector:@selector(valueForKey:) withObject:pName];
        if(pValue!=nil){
            [vArray addObject:pValue];
            //NSLog(@"pName:%@,pValue:%@",pName,pValue);
            [sql_1 appendString:pName];
            [sql_2 appendString:@"?"];
            [sql_1 appendString:@","];
            [sql_2 appendString:@","];
        }
    }
    if([sql_1 hasSuffix:@","]){
        sql_1 = [NSMutableString stringWithString:[sql_1 substringToIndex:[sql_1 length]-1]];
    }
    if([sql_2 hasSuffix:@","]){
        sql_2 = [NSMutableString stringWithString:[sql_2 substringToIndex:[sql_2 length]-1]];
    }
    [sql_1 appendString:@")"];
    [sql_2 appendString:@")"];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"%@ %@",sql_1,sql_2];
    NSLog(@"insert sql:%@",sql);
    free(properties);
    [_db open];
    [_db beginTransaction];
    BOOL flag = [_db executeUpdate:sql withArgumentsInArray:vArray];
    [_db commit];
    [_db close];
    return flag;
}
-(BOOL)updateObjectWithUniqueId:(id<Entity>)obj{
    bool flag = NO;
    NSString *idPropertyName = [obj uniqueIdPropertyName];
    id idPropertyValue = nil;
    NSString *tableName = [obj tableName];
    NSMutableString *sql_1 = [NSMutableString stringWithFormat:@"update %@ set ",tableName];
    NSMutableString *sql_2 = [NSMutableString stringWithFormat:@" where %@=?",idPropertyName];
    u_int p_count;   
    objc_property_t *properties  = class_copyPropertyList([obj class], &p_count);
    NSMutableArray *vArray = [NSMutableArray array];
    for (int i = 0; i < p_count ; i++){
        const char* propertyName = property_getName(properties[i]);
        NSString *pName = [NSString  stringWithUTF8String: propertyName];
        id pValue = [obj performSelector:@selector(valueForKey:) withObject:pName];
        if([pName isEqualToString:idPropertyName]){
            if(pValue==nil){
                NSLog(@"obj:%@ unique id can not be null",obj);
                break;
            }else {
                idPropertyValue = pValue;
            }
        }else {
            if(pValue!=nil){
                [vArray addObject:pValue];
                [sql_1 appendString:pName];
                [sql_1 appendString:@"=?"];
                [sql_1 appendString:@","];
            }
        }
    }
    free(properties);
    if([sql_1 hasSuffix:@","]){
        sql_1 = [NSMutableString stringWithString:[sql_1 substringToIndex:[sql_1 length]-1]];
    }
    NSMutableString *sql = [NSMutableString stringWithFormat:@"%@ %@",sql_1,sql_2];
    [vArray addObject:idPropertyValue];
    NSLog(@"update sql:%@",sql);
    [_db open];
    [_db beginTransaction];
    [_db executeUpdate:sql withArgumentsInArray:vArray];
    [_db commit];
    [_db close];
    return flag;
}

@end
