//
//  LoginViewController.h
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController :BaseViewController<UITextFieldDelegate>{
    
    UITextField *_nameField;
    
    UITextField *_passWordField;
    
}

@end
