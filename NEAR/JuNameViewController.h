//
//  JuNameViewController.h
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuNameViewController : BaseViewController

{
    
    UITextField *name;
    
    void (^_callBackName)(NSString *str);
    
}

- (void)callBackName:(void (^)(NSString *str))myName;

@end
