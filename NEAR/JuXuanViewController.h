//
//  JuXuanViewController.h
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuXuanViewController : BaseViewController
{
    
    UITextView *xuanView;

    void (^_callBackXuan)(NSString *xuan);
    
}

- (void)callBackXuan:(void (^)(NSString *xuan))myXuan;

@end
