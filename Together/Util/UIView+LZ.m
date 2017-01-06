//
//  UIView+LZ.m
//  
//
//  Created by teacher on 14-6-6.
//  Copyright (c) 2014年 帶頭二哥. All rights reserved.
//

#import "UIView+LZ.h"

@implementation UIView (LZ)


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)fadeOut {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation new];
    animation.keyPath = @"position";
    CGFloat x = self.layer.position.x;
    CGFloat y =self.layer.position.y;
    animation.values = @[
        [NSValue valueWithCGPoint:CGPointMake(x, y)],
        [NSValue valueWithCGPoint:CGPointMake(x+50, y+50)],
        [NSValue valueWithCGPoint:CGPointMake(x+500,y+500)]
                         ];
    animation.duration = 5.5;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)setRoundCorner
{
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

@end
