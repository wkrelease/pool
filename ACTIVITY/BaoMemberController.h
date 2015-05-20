//
//  BaoMemberController.h
//  POOL
//
//  Created by king on 15/3/15.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "BaseViewController.h"

@interface BaoMemberController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;

    NSMutableArray *_dataArray;
}

@property (nonatomic,copy)NSString *canDel;

@property (nonatomic,strong)NSString *activityId;

@end
