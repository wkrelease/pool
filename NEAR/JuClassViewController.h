//
//  JuClassViewController.h
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuClassViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    void (^_callBackClass)(NSString *claStr);
    
}

- (void)callBackClass:(void (^)(NSString *claStr))myClass;

@end
