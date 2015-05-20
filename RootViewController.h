//
//  RootViewController.h
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityViewController.h"
#import "NearViewController.h"
#import "MessageViewController.h"
#import "PaiHangViewController.h"
#import "MeViewController.h"

@interface RootViewController : UIViewController{
    
    UIImageView *tabBarView;
    
    
    UIScrollView *mainScroll;
    ActivityViewController *activity;
    NearViewController *near;
    MessageViewController *mess;
    PaiHangViewController *pai;
    MeViewController *me;
    
}

@end
