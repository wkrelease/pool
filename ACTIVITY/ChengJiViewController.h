//
//  ChengJiViewController.h
//  POOL
//
//  Created by king on 15/5/14.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChengJiViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
}

@property (nonatomic,copy)NSString *activityIDStr;

@property (nonatomic,copy)NSString *titleString;



@end
