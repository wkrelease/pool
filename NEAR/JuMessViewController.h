//
//  JuMessViewController.h
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuMessViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *upImageArray;
    
    NSMutableArray *memberArray;
    
}

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *idstr;

@end
