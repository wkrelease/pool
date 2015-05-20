//
//  ActivityMessageViewController.h
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityMessageViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>{
    
    UITableView *photoTable;
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *_dataMessageArray;
    
    UILabel *titleLabel;
    UILabel *addresslabel;
    UILabel *phonelabel;
    
    
    UIImageView *head;
    NSMutableArray *imageArray;
    
    NSMutableArray *userImageArray;
    
    NSString *isOwner;
    
    NSString *ISPK;
    
    
    
    void (^_callBackDelete)();
    
}

@property (nonatomic,strong)NSString *actString;


- (void)callBackDelete:(void (^)())myDelete;





@end
