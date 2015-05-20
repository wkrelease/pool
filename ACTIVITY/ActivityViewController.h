//
//  ActivityViewController.h
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"


@interface ActivityViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,MJRefreshBaseViewDelegate>{
    
    
    CLLocationManager *locationManager;
    
    CLLocation *checkinLocation;

    
    
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_twoDataArray;
    
    UIScrollView *tableScroll;
    
    UITableView *_twoTableView;

    
    UIButton *leftBtn;
    
    UIButton *rightBtn;
    
    
    UIButton *beijing;
    
    
    
    NSString *latitudeStr;
    NSString *longitudeStr;
    
    
    UILabel *classLabel;
    UILabel *dateLabel ;

    NSMutableArray *_dateArray;
    NSString *dateStr;
    NSString *classStr;
    NSMutableArray *_classArray;
    
    
    UIImageView *shaiView;
    
    
    
    
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    

    
    MJRefreshHeaderView *_anoHeader;
    MJRefreshFooterView *_anoFooter;
 
    
    
    int currentPage;
    
    
    int currentDAY;
    
    
    

    

}

@end
