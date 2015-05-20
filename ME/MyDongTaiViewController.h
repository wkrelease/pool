//
//  MyDongTaiViewController.h
//  POOL
//
//  Created by king on 15/3/29.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"

@interface MyDongTaiViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>{
    
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    MJRefreshHeaderView *_header;
    MJRefreshHeaderView *_footer;
    
    BOOL isExistenceNetwork;
    int a;

    
}

@end
