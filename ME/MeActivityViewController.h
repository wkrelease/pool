//
//  MeActivityViewController.h
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface MeActivityViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    
    MJRefreshHeaderView *_header;
    MJRefreshHeaderView *_footer;
    
    BOOL isExistenceNetwork;
    int a;
    
}

@end
