//
//  NSDate+quick.m
//  MicroBang
//
//  Created by Yue Shen on 16/7/15.
//  Copyright © 2016年 leon. All rights reserved.
//

#import "NSDate+quick.h"

@implementation NSDate (quick)
+(NSString*)now
{
    NSDate *date = [self date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *str = [fmt stringFromDate:date];
    return str;
}
@end
