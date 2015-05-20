//
//  JuKongMessViewController.h
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"

@interface JuKongMessViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,MJRefreshBaseViewDelegate>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    
    MJRefreshHeaderView *_header;

}

@property (nonatomic,strong)NSString *groupID;

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *idStr;

@end
