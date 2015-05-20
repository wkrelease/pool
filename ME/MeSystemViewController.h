//
//  MeSystemViewController.h
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeSystemViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
}

@end
