//
//  JingDengViewController.h
//  POOL
//
//  Created by king on 15/5/14.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JingDengViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
}

@property (nonatomic,copy)NSString *persionIDStr;



@property (nonatomic,copy)NSString *activID;

@end
