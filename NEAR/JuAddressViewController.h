//
//  JuAddressViewController.h
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

#import <CoreLocation/CoreLocation.h>

@interface JuAddressViewController : BaseViewController<CLLocationManagerDelegate>

{
    
    MKMapView *myView;
    
    UILabel *addressLabel;
    
    CLLocationManager *locationManager;
    CLLocation *checkinLocation;

    void (^_callBackAdress)(NSString *str);
    
}

- (void)callBackAdress:(void (^)(NSString *str))myBlock;



@property (nonatomic,copy)NSString *addressType;



@end
