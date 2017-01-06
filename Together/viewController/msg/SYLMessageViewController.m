//
//  SYLMessageViewController.m
//  Together
//
//  Created by Yue Shen on 2017/1/4.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "SYLMessageViewController.h"

@interface SYLMessageViewController ()

@end

@implementation SYLMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"消息";
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
