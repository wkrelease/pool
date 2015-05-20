//
//  ChangMessageViewController.h
//  POOL
//
//  Created by king on 15-2-27.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangMessageViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    
    UIScrollView *mainScroll;
    
    UITableView *photoTable;
    
    UILabel *titleLabel;
    UILabel *addresslabel;
    UILabel *phonelabel;
    
    NSMutableArray *imageArray;
    UILabel *priceLabel ;
    UILabel *numLabel;
    
    
    
    NSString *activityID;
    
    
    NSMutableArray *memImageArray;

    UIImageView *backVi;

    UILabel *dalabel;
    UILabel *messLab;
    UILabel *ren;
    UILabel *baom;
    
    
    
    
    UIButton *baoBtn ;
}

@property (nonatomic,strong)NSString *changID;


@end
