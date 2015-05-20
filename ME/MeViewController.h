//
//  MeViewController.h
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
}

@end
