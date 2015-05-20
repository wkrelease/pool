//
//  ChanMemViewController.h
//  POOL
//
//  Created by king on 15/4/22.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChanMemViewController : BaseViewController{
    
    NSMutableArray *_dataArray;
    
    
    void (^_callMemArray)(NSMutableArray *array);
    
}


- (void)callMemArray:(void (^)(NSMutableArray *array))myMem;



@property (nonatomic,copy)NSString *activityId;

@property (nonatomic,copy)NSString *numPeople;

@end
