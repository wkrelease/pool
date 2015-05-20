//
//  ChanWantVC.h
//  POOL
//
//  Created by king on 15/5/17.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChanWantVC : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;

    NSMutableArray *_dataArray;
}

@end
