//
//  MeStoreGoodsViewController.h
//  POOL
//
//  Created by king on 15-3-7.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeStoreGoodsViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
}

@property (nonatomic,strong)NSString *goodStr;


@end
