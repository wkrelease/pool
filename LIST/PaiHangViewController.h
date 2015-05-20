//
//  PaiHangViewController.h
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaiHangViewController : BaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    UIScrollView *scroll;
    
    UITableView *_oneTableView;
    UITableView *_twoTableView;
    UITableView *_threeTableView;
    
    NSMutableArray *oneArray;
    NSMutableArray *twoArray;
    NSMutableArray *threeArray;
    
}

@end
