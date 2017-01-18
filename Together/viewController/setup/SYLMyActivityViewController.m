//
//  SYLMyActivityViewController.m
//  Together
//
//  Created by Yue Shen on 2017/1/17.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "SYLMyActivityViewController.h"

@interface SYLMyActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *ui_table_activity;
}
@property (nonatomic,strong) NSArray *array_activity;
@end

@implementation SYLMyActivityViewController

- (NSArray *)array_activity {
    if(_array_activity==nil){
        _array_activity = [NSArray new];
    }
    return _array_activity;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setupData {
    [[HTTPService Instance] mobilePOST:serverURL path:@"/togetherResponder.php" parameters:[@{@"action":@"get_my_activity_list"} mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        ui_table_activity.delegate = self;
        ui_table_activity.dataSource = self;
        self.array_activity = responseObject[@"data"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setupUI {
    ui_table_activity = [UITableView new];
    [self.view addSubview:ui_table_activity];
    [ui_table_activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(0);
    }];
}
@end
