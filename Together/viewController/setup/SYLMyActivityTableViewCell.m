//
//  SYLMyActivityTableViewCell.m
//  Together
//
//  Created by Yue Shen on 2017/1/17.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "SYLMyActivityTableViewCell.h"

@implementation SYLMyActivityTableViewCell
{
    UIView *ui_view_container;
    UILabel *ui_lb_title;
    UILabel *ui_lb_address;
    UILabel *ui_lb_start_time;
    UILabel *ui_lb_category_title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupUI {
    ui_view_container = [UIView new];
    [self.contentView addSubview:ui_view_container];
    [ui_view_container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.height.bottom.mas_equalTo(-8);
    }];
    ui_lb_title = [UILabel new];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
@end
