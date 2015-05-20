//
//  RegisterViewController.h
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSLocateView.h"

@interface RegisterViewController : BaseViewController<UIActionSheetDelegate>{
    
    UITextField *phoneField;
    
    UITextField *phonePassField;
    
    UITextField *passField;
    
    UITextField *passTwoField;
    
    
    UITextField *namField;
    
    UILabel *addressLabel;
    NSString *addressCodeString;
    
    NSString *sexString;
    
    
    
    
}
@end
