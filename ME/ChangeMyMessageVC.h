//
//  ChangeMyMessageVC.h
//  POOL
//
//  Created by king on 15/5/17.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIFormDataRequest.h"

@interface ChangeMyMessageVC :BaseViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,ASIHTTPRequestDelegate>{
    
    
    UITableView *photoTable;
    
    NSMutableArray *_photoArray;
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    
    UILabel *titleLabel;
    
    UILabel *dateLabel;
    
    UILabel *biaoLable;
    
    UITextField *addressLabel;
    
    UILabel *priceLabel;
    
    UILabel *peopleLabel;
    
    UILabel *yaoQiuLabel;
    
    UIImageView *backView;
    
    
    UISwitch *sw;
    
    
    UITextView *tv ;
    
    UITextView *shuoming;
    
}

@end
