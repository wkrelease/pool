//
//  ActivityNewViewController.h
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityNewViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
}

@end
