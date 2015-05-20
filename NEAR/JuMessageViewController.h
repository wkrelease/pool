//
//  JuMessageViewController.h
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuMessageViewController : BaseViewController{
    
    UITextView *messView;
    
    void (^_callBackMessage)(NSString *message);
    
}

- (void)callBackMessage:(void (^)(NSString *message))str;

@end
