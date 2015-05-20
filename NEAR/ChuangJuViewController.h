//
//  ChuangJuViewController.h
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChuangJuViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_imgArray;
    
    UITableView *photoTable;
    
    UITextField *nameField;
    UITextField *classField;
    UILabel *xuanLabel;
    UILabel *mess;
    UILabel *addressLabel;
    
    
}

@end
