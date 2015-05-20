//
//  LuRuViewController.h
//  POOL
//
//  Created by king on 15/3/21.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LuRuViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    
    UILabel *titLabel;
    
    
    
    NSMutableArray *oneArray;
    NSMutableArray *twoArray;
    NSMutableArray *threeArray;
    NSMutableArray *fourArray;
    NSMutableArray *fiveArray;
    NSMutableArray *sixArray;
    NSMutableArray *sevenArray;
    
    NSString *String1;
    NSString *String2;
    NSString *String3;
    NSString *String4;
    NSString *String5;
    NSString *String6;
    NSString *String7;
    NSString *String8;
    NSString *String9;
    NSString *String10;
    NSString *String11;
    NSString *String12;
    NSString *String13;
    NSString *String14;
    NSString *String15;
    NSString *String16;
    NSString *String17;
    NSString *String18;
    NSString *String19;
    NSString *String20;
    NSString *String21;
    NSString *String22;
    NSString *String23;
    NSString *String24;
    NSString *String25;
    NSString *String26;
    NSString *String27;
    NSString *String28;
    NSString *String29;
    NSString *String30;
    NSString *String31;
    NSString *String32;
    NSString *String33;
    NSString *String34;
    NSString *String35;
    NSString *String36;
    NSString *String37;
    NSString *String38;
    NSString *String39;
    NSString *String40;
    NSString *String41;
    NSString *String42;
    NSString *String43;
    NSString *String44;
    NSString *String45;
    NSString *String46;
    NSString *String47;
    NSString *String48;
    NSString *String49;
    NSString *String50;
    NSString *String51;
    NSString *String52;
    NSString *String53;
    NSString *String54;
    NSString *String55;
    NSString *String56;
    NSString *String57;
    NSString *String58;
    NSString *String59;
    NSString *String60;
    NSString *String61;
    NSString *String62;
    NSString *String63;
    NSString *String64;

    
    void (^_callRefresh)();
    
}

- (void)callRefresh:(void (^)())myRefresh;


@property (nonatomic,strong)NSString *activityIdStr;

@property (nonatomic,strong)NSString *theTitle;

@property (nonatomic,strong)NSString *dateStr;

@end
