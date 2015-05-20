//
//  XianZhiViewController.h
//  POOL
//
//  Created by king on 15/3/21.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XianZhiViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    void (^_callBack)(NSString *str);
    
}

- (void)callBack:(void (^)(NSString *str))myBlock;

@end
