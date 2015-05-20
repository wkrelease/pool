//
//  MemberViewController.h
//  POOL
//
//  Created by king on 15/3/15.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_dataMessageArray;
    
    NSMutableArray *_twoArray;
}

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *userIdStr;

@end
