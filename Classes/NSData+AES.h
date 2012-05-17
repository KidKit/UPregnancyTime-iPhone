//
//  NSData+AES.h
//  UPregnancyTime
//
//  Created by Zhimin Jiang on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(AES)
-(NSData*)AES256EncryptWithKey:(NSString*)key;
-(NSData*)AES256DecryptWithKey:(NSString*)key; 
@end
