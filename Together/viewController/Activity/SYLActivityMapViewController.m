//
//  SYLMapViewController.m
//  Together
//
//  Created by Yue Shen on 2017/1/4.
//  Copyright © 2017年 Yue Shen. All rights reserved.
//

#import "SYLActivityMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <objc/runtime.h>

@interface SYLActivityMapViewController ()<MAMapViewDelegate>
@property (nonatomic,strong) MAMapView *mapView;
@end

@implementation SYLActivityMapViewController
static char key;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [_mapView setZoomLevel:17.5 animated:YES];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
    objc_setAssociatedObject(pointAnnotation, &key, @"方恒国际", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [_mapView addAnnotation:pointAnnotation];
    
    
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
    pointAnnotation2.coordinate = CLLocationCoordinate2DMake(40.999631, 116.481018);
    pointAnnotation2.title = @"23333";
    pointAnnotation2.subtitle = @"阜通东大街6号";
    objc_setAssociatedObject(pointAnnotation2, &key, @"2333", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [_mapView addAnnotation:pointAnnotation2];
    
    [self.view addSubview:self.mapView];
}

#pragma mark - map delegate
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
        NSString * associatedObject = (NSString *)objc_getAssociatedObject(annotation , &key);
         objc_setAssociatedObject(annotationView, &key, associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UITapGestureRecognizer *ges = [UITapGestureRecognizer new];
        [ges addTarget:self action:@selector(test:)];
        [annotationView.leftCalloutAccessoryView addGestureRecognizer:ges];
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate {
    MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
    pointAnnotation2.coordinate = coordinate;
    pointAnnotation2.title = [NSString stringWithFormat:@"%f,%f",coordinate.latitude,coordinate.longitude];
    pointAnnotation2.subtitle = @"tap";
    objc_setAssociatedObject(pointAnnotation2, &key, @"2333", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView addAnnotation:pointAnnotation2];
    
}


- (void)test:(UITapGestureRecognizer *)sender {
    NSString * associatedObject = (NSString *)objc_getAssociatedObject(sender.view, &key);
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:associatedObject delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"活动地图";
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
