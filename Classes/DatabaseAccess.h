//
//  DatabaseAccess.h
//  UBabyTime
//
//  Created by Zhimin Jiang on 12-4-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "unistd.h"
#import "FMDatabase.h"
#import <objc/runtime.h>
#import "Entity.h"
#import "NSObject+Addition.h"

@interface DatabaseAccess : NSObject
{
    FMDatabase *_db;
}
+ (DatabaseAccess *)sharedAccess;
+(NSString *)dbFilePath;

-(id)executeQueryForUnique:(Class) clazz withSql:(NSString *)sql withArgumentsInArray:(NSArray *)args;
-(NSArray*)executeQueryForList:(Class) clazz limit:(int)limit withSql:(NSString *)sql withArgumentsInArray:(NSArray *)args;
-(BOOL)insertObject:(id<Entity>)obj;
-(BOOL)updateObjectWithUniqueId:(id<Entity>)obj;

@end


@protocol DatabaseAccessQueryDelegate <NSObject>



@end

