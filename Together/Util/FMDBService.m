//
//  FMDBService.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/13.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "FMDBService.h"

@implementation FMDBService
+ (instancetype)sharedInstance
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"database"];
    NSLog(@"%@",path);
    static dispatch_once_t __singletonToken;
    static id __singleton__;
    dispatch_once( &__singletonToken, ^{ __singleton__ = [FMDatabase databaseWithPath:path]; } );
    return __singleton__;
}

@end
