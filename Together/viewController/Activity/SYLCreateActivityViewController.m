//
//  SYLCreateActivityViewController.m
//  Together
//
//  Created by Yue Shen on 2017/1/4.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "SYLCreateActivityViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface SYLCreateActivityViewController ()<MAMapViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIScrollView *ui_scroll_create;
    UIView *ui_view_container;
    UIPickerView *ui_picker_category;
    
    UITextField *ui_tf_title;
    UITextField *ui_tf_address;
    UITextView *ui_tv_info;
    UIDatePicker *ui_dp_start_time;
    UIButton *ui_btn_confirm;
    UIButton *ui_btn_back;
    
    UILabel *ui_lb_category;
    UILabel *ui_lb_title;
    UILabel *ui_lb_address;
    UILabel *ui_lb_info;
    UILabel *ui_lb_start_time;
    UILabel *ui_lb_start_corodinate;

}
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) NSMutableArray *array_category_all;
@property (nonatomic,strong) NSMutableArray *array_category_level_0;
@property (nonatomic,strong) NSMutableArray *array_category_level_1;
@property (nonatomic,strong) NSNumber *lat;
@property (nonatomic,strong) NSNumber *lng;
@end

@implementation SYLCreateActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupData];
}

- (NSNumber *)lat {
    if(_lat==nil){
        _lat = @0;
    }
    return _lat;
}

- (NSNumber *)lng {
    if(_lng==nil){
        _lng = @0;
    }
    return _lng;
}

- (NSMutableArray *)array_category_all {
    if(_array_category_all==nil){
        _array_category_all = [NSMutableArray new];
    }
    return _array_category_all;
}

- (NSMutableArray *)array_category_level_0 {
    if(_array_category_level_0==nil){
        _array_category_level_0 = [NSMutableArray new];
    }
    return _array_category_level_0;
}

- (NSMutableArray *)array_category_level_1 {
    if(_array_category_level_1==nil){
        _array_category_level_1 = [NSMutableArray new];
    }
    return _array_category_level_1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component==0){
        [self.array_category_level_1 removeAllObjects];
        NSString *idx = self.array_category_level_0[row][@"idx"];
        for (NSDictionary *dict in self.array_category_all) {
            if([dict[@"parent_idx"] isEqualToString:idx]){
                [self.array_category_level_1 addObject:dict];
            }
        }
        [ui_picker_category reloadComponent:1];
        [ui_picker_category selectRow:0 inComponent:1 animated:NO];
    }
}

- (void)setupData {
    [[HTTPService Instance] mobilePOST:serverURL path:@"/togetherResponder.php" parameters:[@{@"action":@"get_category"} mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            self.array_category_all = responseObject[@"data"];
            for (NSDictionary *dict in self.array_category_all) {
                if([dict[@"category_level"] isEqualToString:@"0"]){
                    [self.array_category_level_0 addObject:dict];
                }
                if([dict[@"category_level"] isEqualToString:@"1"]&&
                   [dict[@"parent_idx"] isEqualToString:self.array_category_level_0[0][@"idx"]]){
                    [self.array_category_level_1 addObject:dict];
                }
            }
        [ui_picker_category setDataSource:self];
        ui_picker_category.delegate = self;
        [ui_picker_category reloadAllComponents];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    NSLog(@"123");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0){
        return [self.array_category_level_0 count];
    }else if(component == 1){
        return [self.array_category_level_1 count];
    }else{
        return 0;
    }
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component==0){
        return self.array_category_level_0[row][@"title"];
    }else if (component==1){
        return self.array_category_level_1[row][@"title"];
    }else{
        return @"error";
    }
}

- (void)setupUI {
    ui_scroll_create = [UIScrollView new];
    [self.view addSubview:ui_scroll_create];
    [ui_scroll_create mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    ui_view_container = [UIView new];
    [ui_view_container setBackgroundColor:BGCOLOR];
    ui_view_container.frame = CGRectMake(0, 0, kScreenWidth, 1500);
    [ui_scroll_create setContentSize:CGSizeMake(ui_view_container.width, ui_view_container.height)];
    [ui_scroll_create setScrollEnabled:YES];
    [ui_scroll_create setUserInteractionEnabled:YES];
    [ui_scroll_create addSubview:ui_view_container];
    
    
    ui_lb_category = [UILabel new];
    [ui_view_container addSubview:ui_lb_category];
    ui_lb_category.text = @"选择分类";
    [ui_lb_category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(8);
    }];

    ui_picker_category = [[UIPickerView alloc]init];
    
    [ui_view_container addSubview:ui_picker_category];
    [ui_picker_category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_lb_category.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(100);
    }];
    
//    ui_picker_category1 = [[UIPickerView alloc]init];
//    ui_picker_category1.delegate = self;
//    ui_picker_category1.dataSource = self;
//    [ui_view_container addSubview:ui_picker_category1];
//    [ui_picker_category1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(ui_lb_category.mas_bottom).offset(8);
//        make.right.mas_equalTo(-8);
//        make.width.mas_equalTo(kScreenWidth/2-8);
//        make.height.mas_equalTo(44);
//    }];
    
    ui_lb_title = [UILabel new];
    [ui_view_container addSubview:ui_lb_title];
    ui_lb_title.text = @"活动标题";
    [ui_lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_picker_category.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
    }];
    
    ui_tf_title = [UITextField new];
    ui_tf_title.text = @"party happy";
    ui_tf_title.borderStyle = UITextBorderStyleRoundedRect;
    [ui_view_container addSubview:ui_tf_title];
    [ui_tf_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_lb_title.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(200);
    }];
    
    ui_lb_address = [UILabel new];
    [ui_view_container addSubview:ui_lb_address];
    ui_lb_address.text = @"活动地址";
    [ui_lb_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_title.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
    }];
    
    ui_tf_address = [UITextField new];
    ui_tf_address.text = @"红中路256号";
    ui_tf_address.borderStyle = UITextBorderStyleRoundedRect;
    [ui_view_container addSubview:ui_tf_address];
    [ui_tf_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_lb_address.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(200);
    }];
    
    ui_lb_info = [UILabel new];
    [ui_view_container addSubview:ui_lb_info];
    ui_lb_info.text = @"备注";
    [ui_lb_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tf_address.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
    }];
    
    ui_tv_info = [UITextView new];
    ui_tv_info.layer.borderWidth = 1;
    ui_tv_info.text = @"一定要来哦";
    [ui_view_container addSubview:ui_tv_info];
    [ui_tv_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_lb_info.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
        make.right.mas_equalTo(-8);
        make.height.mas_equalTo(150);
    }];
    
    ui_lb_start_time = [UILabel new];
    [ui_view_container addSubview:ui_lb_start_time];
    ui_lb_start_time.text = @"集合时间";
    [ui_lb_start_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_tv_info.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
    }];

    ui_dp_start_time = [[UIDatePicker alloc]init];
    ui_dp_start_time.datePickerMode = UIDatePickerModeDateAndTime;
    ui_dp_start_time.minuteInterval = 5;
    [ui_view_container addSubview:ui_dp_start_time];
    [ui_dp_start_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_lb_start_time.mas_bottom).offset(8);
        make.left.right.mas_equalTo(8);
        make.right.right.mas_equalTo(-8);
        make.height.mas_equalTo(44);
    }];
    
    ui_lb_start_corodinate = [UILabel new];
    [ui_view_container addSubview:ui_lb_start_corodinate];
    ui_lb_start_corodinate.text = @"集合地点(点选)";
    [ui_lb_start_corodinate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ui_dp_start_time.mas_bottom).offset(8);
        make.left.mas_equalTo(8);
    }];
    
    [ui_view_container layoutIfNeeded];
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, ui_lb_start_corodinate.y+ui_lb_start_corodinate.height+8, kScreenWidth, 250)];
    [ui_view_container addSubview:self.mapView];
    self.mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    [_mapView setZoomLevel:12.5 animated:YES];
    [_mapView setShowsCompass:NO];
    [_mapView setShowsScale:NO];
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    ui_btn_confirm = [UIButton new];
    [ui_btn_confirm setBackgroundColor:BLUETHEME];
    [ui_btn_confirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [ui_btn_confirm setTitle:@"发起活动" forState:UIControlStateNormal];
    [ui_view_container addSubview:ui_btn_confirm];
    [ui_btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_mapView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(ui_view_container);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(100);
    }];
}

#pragma mark - amap delegate
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
    pointAnnotation2.coordinate = coordinate;
    pointAnnotation2.title = [NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude];
    self.lat = @(coordinate.latitude);
    self.lng = @(coordinate.longitude);
    pointAnnotation2.subtitle = @"tap";
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotation:pointAnnotation2];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}


- (void)confirm {
    NSString *category_idx = self.array_category_level_1[ [ui_picker_category selectedRowInComponent:1]][@"idx"];
    NSString *title = ui_tf_title.text;
    NSString *address = ui_tf_address.text;
    NSString *info = ui_tv_info.text;
    NSString *start_time  = [NSString stringWithFormat:@"%f",[ui_dp_start_time.date timeIntervalSince1970]];
    [[HTTPService Instance] mobilePOST:serverURL path:@"/togetherResponder.php" parameters:[@{@"action":@"create_activity",@"lng":self.lng,@"lat":self.lat,@"title":title,@"address":address,@"info":info,@"start_time":start_time,@"category_idx":category_idx} mutableCopy] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"创建活动";
    }
    return self;
}

@end
