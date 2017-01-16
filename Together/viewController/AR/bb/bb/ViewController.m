//
//  ViewController.m
//  bb
//
//  Created by Yue Shen on 2017/1/12.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    UIImageView *view = [UIImageView new];
    view.frame  = CGRectZero;
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    view.tag = 22;
    
    [view stopAnimating];
    [self.view removeFromSuperview];
    UIColor *color = [UIColor redColor];
    Boolean rst = YES;
    [NSArray arrayWithObjects:@"123",@2 ,nil];
    [NSArray arrayWithContentsOfURL:[NSURL URLWithString:@"123"]];
    NSString *str = @"123";
    [str respondsToSelector:@selector(selectName)];
    
}


@end
