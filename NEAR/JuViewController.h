//
//  JuViewController.h
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"

@interface JuViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    
}

@end
