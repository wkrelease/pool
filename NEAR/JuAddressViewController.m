//
//  JuAddressViewController.m
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuAddressViewController.h"

@interface JuAddressViewController ()

@end

@implementation JuAddressViewController


- (void)callBackAdress:(void (^)(NSString *))myBlock{
    
    _callBackAdress = myBlock;
    
}


- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    CGPoint point = [tap locationInView:myView];
    //屏幕坐标转成经纬度
    CLLocationCoordinate2D coordinate = [myView convertPoint:point toCoordinateFromView:myView];
    
    NSLog(@"%f",coordinate.latitude);
    
    NSLog(@"%f",coordinate.longitude);
    
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    CLGeocoder*  geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError * error){
        
        
        for (CLPlacemark *placeMark in placemarks)
        {
            
            NSLog(@"地址name:%@ ",placeMark.name);
            
            
            addressLabel.text = placeMark.name;
            
            
            NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"City"]);
            NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"Name"]);
            NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"State"]);
            NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"Street"]);
            NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"SubLocality"]);
            NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"Thoroughfare"]);
            
            NSLog(@"+++++++%@",placeMark.addressDictionary);
            
            
            NSLog(@"地址thoroughfare:%@",placeMark.thoroughfare);
            NSLog(@"地址subThoroughfare:%@",placeMark.subThoroughfare);
            NSLog(@"地址locality:%@",placeMark.locality);
            NSLog(@"地址subLocality:%@",placeMark.subLocality);
            NSLog(@"地址administrativeArea:%@",placeMark.administrativeArea);
            NSLog(@"地址subAdministrativeArea:%@",placeMark.subAdministrativeArea);
            NSLog(@"地址postalCode:%@",placeMark.postalCode);
            NSLog(@"地址ISOcountryCode:%@",placeMark.ISOcountryCode);
            NSLog(@"地址country:%@",placeMark.country);
            NSLog(@"地址inlandWater:%@",placeMark.inlandWater);
            NSLog(@"地址ocean:%@",placeMark.ocean);
            NSLog(@"地址areasOfInterest:%@",placeMark.areasOfInterest);
            
            
            break;
            
        }
        
        
        
        
    }];
    
    
}

- (void)yesClick{

    
    _callBackAdress(addressLabel.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self showBack];
    
    self.myTitleLabel.text = @"地址";
    
    if ([_addressType isEqualToString:@"look"]) {
        
    }else{
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"确定 " forState:UIControlStateNormal];
        btn.frame = CGRectMake(SCREEN_WIDTH - 55, 35, 40, 20);
        btn.backgroundColor = [UIColor clearColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn addTarget:self action:@selector(yesClick) forControlEvents:UIControlEventTouchUpInside];
        [self.navView addSubview:btn];
        
    }
    

    
    myView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    myView.showsUserLocation=YES;
    
    [self.view addSubview:myView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [myView addGestureRecognizer:tap];
    
    
    
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, SCREEN_WIDTH - 40, 30)];
    addressLabel.textAlignment = NSTextAlignmentCenter;
    addressLabel.font = [UIFont systemFontOfSize:13];
    [myView addSubview:addressLabel];
    
    
    
    
    //定位
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
        NSLog(@"没有GPS服务");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"没有GPS服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    }else{
        
        
        locationManager = [[CLLocationManager alloc] init];//初始化
        locationManager.delegate = self;//委托自己
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;//精度设定
        locationManager.distanceFilter = 1.0f;
        
        if (SYSTEM_VERSION > 7.0) {
            
            [locationManager requestAlwaysAuthorization];
            
        }else{
            
        }
        [locationManager startUpdatingLocation];//开启位置更新
        
        
    }
    

    
    // Do any additional setup after loading the view.
}



#pragma mark location


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    NSLog(@"a");
    
    NSLog(@"%u",status);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    checkinLocation = [locations lastObject];
    
    
    NSLog(@"%@",locations);
    
    NSLog(@"%@",checkinLocation);
    
    // CLLocation类是一个位置的一个类 里面有一个结构体
    
    double latitude =  checkinLocation.coordinate.latitude;
    
    double longitude = checkinLocation.coordinate.longitude;
    
    NSLog(@"%f=================%f",latitude,longitude);
    
    
    //    [locationManager stopUpdatingLocation];
    
    
    
    
    
#pragma mark 11111
    
    
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude=latitude;
    theCoordinate.longitude=longitude;
    
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.05;
    theSpan.longitudeDelta=0.05;
    
    
    MKCoordinateRegion theRegion;
    theRegion.center=theCoordinate;
    theRegion.span=theSpan;
    
    
    [myView setMapType:MKMapTypeStandard];
    [myView setRegion:theRegion];
    
    
    
    
#pragma mark eeeee
    
    
    
    CLGeocoder*  geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:checkinLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error) {
             NSLog(@"error: %@",error.description);
         }
         else{
             NSLog(@"placemarks count %ld",placemarks.count);
             for (CLPlacemark *placeMark in placemarks)
             {
                 NSLog(@"地址name:%@ ",placeMark.name);
                 
                 
                 addressLabel.text = placeMark.name;
                 
                 
                 NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"City"]);
                 NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"Name"]);
                 NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"State"]);
                 NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"Street"]);
                 NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"SubLocality"]);
                 NSLog(@"-------%@",[placeMark.addressDictionary objectForKey:@"Thoroughfare"]);
                 
                 NSLog(@"+++++++%@",placeMark.addressDictionary);
                 
                 
                 NSLog(@"地址thoroughfare:%@",placeMark.thoroughfare);
                 NSLog(@"地址subThoroughfare:%@",placeMark.subThoroughfare);
                 NSLog(@"地址locality:%@",placeMark.locality);
                 NSLog(@"地址subLocality:%@",placeMark.subLocality);
                 NSLog(@"地址administrativeArea:%@",placeMark.administrativeArea);
                 NSLog(@"地址subAdministrativeArea:%@",placeMark.subAdministrativeArea);
                 NSLog(@"地址postalCode:%@",placeMark.postalCode);
                 NSLog(@"地址ISOcountryCode:%@",placeMark.ISOcountryCode);
                 NSLog(@"地址country:%@",placeMark.country);
                 NSLog(@"地址inlandWater:%@",placeMark.inlandWater);
                 NSLog(@"地址ocean:%@",placeMark.ocean);
                 NSLog(@"地址areasOfInterest:%@",placeMark.areasOfInterest);
                 
                 
                 break;
                 
             }
             
             
         }
         
         
     }];
    
    [locationManager stopUpdatingLocation];
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
