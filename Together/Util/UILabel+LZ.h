//
//  UILabel.h
//  MicroBang
//
//  Created by leon on 2016/二月/19.
//  Copyright © 2016年 leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(MB)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font ;
@end
