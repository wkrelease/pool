//
//  MePingViewController.h
//  POOL
//
//  Created by king on 15/3/30.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MePingViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
}

@end
