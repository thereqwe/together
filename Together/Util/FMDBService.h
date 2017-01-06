//
//  FMDBService.h
//  MicroBang
//
//  Created by Yue Shen on 16/7/13.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
@interface FMDBService : FMDatabase
+ (instancetype)sharedInstance;
@end
