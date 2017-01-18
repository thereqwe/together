//
//  SYLSetupViewController.m
//  Together
//
//  Created by Yue Shen on 2017/1/4.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "SYLSetupViewController.h"
#import "SYLCreateActivityViewController.h"
#import "SYLARScanViewController.h"
#import "SYLMyActivityViewController.m"
@interface SYLSetupViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *ui_table_setup;
}
@property (nonatomic,strong)NSArray *array_setup ;
@end

@implementation SYLSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    ui_table_setup = [UITableView new];
    ui_table_setup.delegate = self;
    ui_table_setup.dataSource = self;
    [self.view addSubview:ui_table_setup];
    [ui_table_setup registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [ui_table_setup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(0);
    }];
}

- (NSArray *)array_setup {
    if(_array_setup==nil){
        _array_setup = @[@"发起活动",@"AR扫描",@"我发起的活动"];
    }
    return _array_setup;
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.array_setup count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.array_setup[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if(row==0){
        SYLCreateActivityViewController *vc = [SYLCreateActivityViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row==1){
        SYLARScanViewController *vc =  [SYLARScanViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row==2){
        SYLMyActivityViewController *vc =  [SYLMyActivityViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我";
        self.tabBarController.title = @"我";
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
