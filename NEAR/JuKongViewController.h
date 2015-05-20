//
//  JuKongViewController.h
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuKongViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    
}


@property (nonatomic,strong)NSString *name;


@property (nonatomic,strong)NSString *idStr;


@end
