//
//  SYLARScanViewController.m
//  Together
//
//  Created by Yue Shen on 2017/1/6.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "SYLARScanViewController.h"

@interface SYLARScanViewController ()
{
    UIView *ui_view_scan_square;
    UIView *ui_view_scan_bar;
    UIButton *ui_btn_clue;
    UILabel *ui_lb_notice;
}
@end

@implementation SYLARScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self animateScanBar];
}

- (void)setupData {
   
}
- (void)setupUI {
    WS(ws);
    ui_view_scan_square = [UIView new];
    ui_view_scan_square.backgroundColor = [UIColor clearColor];
    ui_view_scan_square.layer.borderColor = [UIColor blueColor].CGColor;
    ui_view_scan_square.layer.borderWidth = 1;
    [self.view addSubview:ui_view_scan_square];
    [ui_view_scan_square mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.width.height.mas_equalTo(200);
    }];
    
    ui_view_scan_bar = [UIView new];
    ui_view_scan_bar.backgroundColor = [UIColor redColor];
    [self.view addSubview:ui_view_scan_bar];
    [ui_view_scan_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ui_view_scan_square);
        make.top.equalTo(ui_view_scan_square.mas_top);
        make.left.right.equalTo(ui_view_scan_square);
        make.height.mas_equalTo(1);
    }];
    
    ui_btn_clue = [UIButton new];
    [ui_btn_clue setBackgroundColor:BLUETHEME];
    [ui_btn_clue setBackgroundColor:COLOR(100, 100, 255, 0.5)];
    ui_btn_clue.layer.cornerRadius = 6;
    ui_btn_clue.layer.masksToBounds = YES;
    [ui_btn_clue setTitle:@"查看线索" forState:UIControlStateNormal];
    [self.view addSubview:ui_btn_clue];
    [ui_btn_clue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view.mas_bottom).offset(-50);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(150);
    }];
    
    ui_lb_notice = [UILabel new];
    [ui_lb_notice setTextColor:[UIColor whiteColor]];
    [ui_lb_notice setFont:[UIFont systemFontOfSize:12]];
    ui_lb_notice.text = @"请对准线索提示的画面,并保持几秒";
    [self.view addSubview:ui_lb_notice];
    [ui_lb_notice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ui_view_scan_square.mas_bottom).offset(8);
        make.width.equalTo(ui_view_scan_square);
    }];
    [ui_lb_notice setTextAlignment:NSTextAlignmentCenter];
    [ui_lb_notice setBackgroundColor:COLOR(0, 0, 0, 0.5)];
    ui_lb_notice.layer.cornerRadius = 6;
    ui_lb_notice.layer.masksToBounds = YES;
}

- (void)animateScanBar {
    int time = 2;
    [UIView animateWithDuration: time animations:^{
        [ui_view_scan_bar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ui_view_scan_square.mas_top).offset(199);
        }];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:time animations:^{
            [ui_view_scan_bar mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(ui_view_scan_square.mas_top);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self animateScanBar];
        }];
    }];
}
@end
