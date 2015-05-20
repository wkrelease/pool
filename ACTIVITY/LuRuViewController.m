//
//  LuRuViewController.m
//  POOL
//
//  Created by king on 15/3/21.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "LuRuViewController.h"

#import "ChangeUserViewController.h"

#import "BaoMemberController.h"

#import "ChanMemViewController.h"


#import "MemberModel.h"

#import "LuRuCell.h"

#import "LuRuTwoCell.h"

#import "WTRequestCenter.h"

#import "LuRuModel.h"

@interface LuRuViewController (){
    
    UILabel *name;
    
    UILabel *date;
    
    NSString *MAX_NUM;
    
    int currentCell;
    
    NSMutableArray *theNumArray;
    
}

@end

@implementation LuRuViewController

@synthesize theTitle,dateStr,activityIdStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"录入成绩";
    
    [self showBack];
    
    String1 = @"";
    String2 = @"";
    String3 = @"";
    String4 = @"";
    String5 = @"";
    String6 = @"";
    String7 = @"";
    String8 = @"";
    String9 = @"";
    String10 = @"";
    String11 = @"";
    String12 = @"";
    String13 = @"";
    String14 = @"";
    String15 = @"";
    String16 = @"";
    String17 = @"";
    String18 = @"";
    String19 = @"";
    String20 = @"";
    String21 = @"";
    String22 = @"";
    String23 = @"";
    String24 = @"";
    String25 = @"";
    String26 = @"";
    String27 = @"";
    String28 = @"";
    String29 = @"";
    String30 = @"";
    String31 = @"";
    String32 = @"";
    
    
    theNumArray = [NSMutableArray array];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"冠军",@"亚军",@"4强",@"8强",@"16强",@"32强",@"64强",nil];
    
    UIImageView *hea = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    _tableView.tableHeaderView = hea;
    
    NSArray *teArr = [NSArray arrayWithObjects:@"    活动主题",@"    开始时间", nil];
    
    [teArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 + idx * 40, SCREEN_WIDTH, 39)];
        lab.backgroundColor = [UIColor whiteColor];
        lab.text = obj;
        lab.font = [UIFont systemFontOfSize:14];
        lab.textColor = [UIColor grayColor];
        [hea addSubview:lab];
        
    }];
    
    UILabel *mi = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 80, 30)];
    mi.text = @"名次";
    mi.backgroundColor = R_G_B_COLOR(161, 169, 187);
    mi.textColor = [UIColor whiteColor];
    mi.font = [UIFont systemFontOfSize:14];
    mi.textAlignment = NSTextAlignmentCenter;
    [hea addSubview:mi];
    
    
    UILabel *man = [[UILabel alloc]initWithFrame:CGRectMake(80, 100, SCREEN_WIDTH - 80, 30)];
    man.text = @"用户名";
    man.backgroundColor = R_G_B_COLOR(161, 169, 187);
    man.textColor = [UIColor whiteColor];
    man.font = [UIFont systemFontOfSize:12];
    man.textAlignment = NSTextAlignmentCenter;
    [hea addSubview:man];
    // Do any additional setup after loading the view.
    
    
    UIImageView *footVi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 80)];
    footVi.userInteractionEnabled = YES;
    _tableView.tableFooterView = footVi;
    
    
    UIButton *tibtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tibtn setTitle:@"确认提交" forState:UIControlStateNormal];
    tibtn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    tibtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [tibtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tibtn.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, 40);
    [tibtn addTarget:self action:@selector(TiJiao) forControlEvents:UIControlEventTouchUpInside];
    [footVi addSubview:tibtn];
    
    
    name = [[UILabel alloc]initWithFrame:CGRectMake(100, 20, 200, 20)];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:12];
    name.textColor = [UIColor grayColor];
    [hea addSubview:name];
    
    date = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 200, 20)];
    date.backgroundColor = [UIColor clearColor];
    date.font = [UIFont systemFontOfSize:12];
    date.textColor = [UIColor grayColor];
    [hea addSubview:date];
    
    
    
    [self reauestCheng];
}


- (void)reauestCheng{
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSString *sigString =@"";
    
#pragma mark 更改算法!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    
    if ([def objectForKey:USER_NAME]) {
        
        sigString = [[NSString stringWithFormat:@"%@%d%@%@",sysString,CURRENT_TIME,CURRENT_SIGN_KEY,[def objectForKey:CURRENT_AUTH_KEY]]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }else{
        
        sigString = [[NSString stringWithFormat:@"%@%d%@",sigString,CURRENT_TIME,CURRENT_SIGN_KEY]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
    }
    
    sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
    
    NSLog(@"two=============%@",sigString);
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"score",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:activityIdStr forKey:@"activityId"];
    
    
    
    NSLog(@"========%@",url);
    NSLog(@"========%@",parameters);
    
    [WTRequestCenter postWithURL:url
                      parameters:parameters completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                          
                          if (!error) {
                              NSError *jsonError = nil;
                              
                              id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                              
                              
                              if (!jsonError) {
                                  
                                  NSDictionary *dic = (NSDictionary *)obj;
                                  
                                  NSLog(@"%@",dic);
                                  
                                  
                                  NSString *state = [dic objectForKey:@"code"];
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                     
                                      NSDictionary *dataDic = [dic objectForKey:@"data"];
                                      
                                      NSLog(@"%@",dataDic);
                                      
                                      NSString *tt = [dataDic objectForKey:@"startTime"];
                                      NSTimeInterval time=[tt doubleValue];//因为时差问题要加8小时 == 28800 sec
                                      NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                                      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                      NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
                                      
                                      date.text = currentDateStr;
                                      name.text = [dataDic objectForKey:@"title"];
                                      MAX_NUM = [dataDic objectForKey:@"maxNum"];
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      NSString *acz = [dic objectForKey:@"msg"];

                                      NSLog(@"%@",acz);
                                  }
                                  
                                  [_tableView reloadData];
                                  
                              }else
                              {
                                  NSLog(@"jsonError:%@",jsonError);
                                  [MMProgressHUD dismiss];
                                  
                              }
                              
                          }else
                          {
                              NSLog(@"error:%@",error);
                              [MMProgressHUD dismiss];
                              
                          }
                          
                      }];
    
}







- (void)TiJiao{
    
    NSLog(@"提交");
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSString *sigString =@"";
    
    
#pragma mark 更改算法!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    
    if ([def objectForKey:USER_NAME]) {
        
        sigString = [[NSString stringWithFormat:@"%@%d%@%@",sysString,CURRENT_TIME,CURRENT_SIGN_KEY,[def objectForKey:CURRENT_AUTH_KEY]]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }else{
        
        sigString = [[NSString stringWithFormat:@"%@%d%@",sigString,CURRENT_TIME,CURRENT_SIGN_KEY]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }
    
    sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
    
    NSLog(@"two=============%@",sigString);
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"scoreSubmit",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
 
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:activityIdStr forKey:@"activityId"];

    
    if ([MAX_NUM isEqualToString:@"4"]) {
        
        [parameters setValue:@"champion,runnerup,strong4,strong4" forKey:@"rankingList"];
        
        
        MemberModel *model = (MemberModel *)[oneArray lastObject];
        String1 = model.userId;
        MemberModel *model2 = (MemberModel *)[twoArray lastObject];
        String2 = model2.userId;
        [threeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
         
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String3 = model3.userId;
            }else if (idx == 1){
                String4 = model3.userId;
            }
            
            
        }];

        
        [parameters setValue:[NSString stringWithFormat:@"%@,%@,%@,%@",String1,String2,String3,String4] forKey:@"uidList"];


    }else if ([MAX_NUM isEqualToString:@"8"]){
        
        [parameters setValue:@"champion,runnerup,strong4,strong4,strong8,strong8,strong8,strong8" forKey:@"rankingList"];

        MemberModel *model = (MemberModel *)[oneArray lastObject];
        String1 = model.userId;
        
        NSLog(@"%@",String1);
        
        MemberModel *model2 = (MemberModel *)[twoArray lastObject];
        String2 = model2.userId;
        [threeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String3 = model3.userId;
            }else if (idx == 1){
                String4 = model3.userId;
            }
            
            
        }];
        [fourArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String5 = model3.userId;
            }else if (idx == 1){
                String6 = model3.userId;
            }else if (idx == 2){
                String7 = model3.userId;
            }else if (idx == 3){
                String8 = model3.userId;
            }

        }];
        
        
        
        [parameters setValue:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@",String1,String2,String3,String4,String5,String6,String7,String8] forKey:@"uidList"];

    }else if ([MAX_NUM isEqualToString:@"16"]){
        
        [parameters setValue:@"champion,runnerup,strong4,strong4,strong8,strong8,strong8,strong8,strong16,strong16,strong16,strong16,strong16,strong16,strong16,strong16" forKey:@"rankingList"];

        
        MemberModel *model = (MemberModel *)[oneArray lastObject];
        String1 = model.userId;
        MemberModel *model2 = (MemberModel *)[twoArray lastObject];
        String2 = model2.userId;
        [threeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String3 = model3.userId;
            }else if (idx == 1){
                String4 = model3.userId;
            }
            
            
        }];
        [fourArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String5 = model3.userId;
            }else if (idx == 1){
                String6 = model3.userId;
            }else if (idx == 2){
                String7 = model3.userId;
            }else if (idx == 3){
                String8 = model3.userId;
            }
            
        }];
        [fiveArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String9 = model3.userId;
            }else if (idx == 1){
                String10 = model3.userId;
            }else if (idx == 2){
                String11 = model3.userId;
            }else if (idx == 3){
                String12 = model3.userId;
            }else if (idx == 4){
                String13 = model3.userId;
            }else if (idx == 5){
                String14 = model3.userId;
            }else if (idx == 6){
                String15 = model3.userId;
            }else if (idx == 7){
                String16 = model3.userId;
            }
            
 
            
        }];
        
        
        [parameters setValue:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",String1,String2,String3,String4,String5,String6,String7,String8,String9,String10,String11,String12,String13,String14,String15,String16] forKey:@"uidList"];

    }else if ([MAX_NUM isEqualToString:@"32"]){
        
        [parameters setValue:@"champion,runnerup,strong4,strong4,strong8,strong8,strong8,strong8,strong16,strong16,strong16,strong16,strong16,strong16,strong16,strong16,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32" forKey:@"rankingList"];


        MemberModel *model = (MemberModel *)[oneArray lastObject];
        String1 = model.userId;
        MemberModel *model2 = (MemberModel *)[twoArray lastObject];
        String2 = model2.userId;
        [threeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String3 = model3.userId;
            }else if (idx == 1){
                String4 = model3.userId;
            }
            
            
        }];
        [fourArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String5 = model3.userId;
            }else if (idx == 1){
                String6 = model3.userId;
            }else if (idx == 2){
                String7 = model3.userId;
            }else if (idx == 3){
                String8 = model3.userId;
            }
            
        }];
        [fiveArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String9 = model3.userId;
            }else if (idx == 1){
                String10 = model3.userId;
            }else if (idx == 2){
                String11 = model3.userId;
            }else if (idx == 3){
                String12 = model3.userId;
            }else if (idx == 4){
                String13 = model3.userId;
            }else if (idx == 5){
                String14 = model3.userId;
            }else if (idx == 6){
                String15 = model3.userId;
            }else if (idx == 7){
                String16 = model3.userId;
            }
            
        }];
        [sixArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           
            MemberModel *model3 = (MemberModel *)obj;
            if (idx == 0) {
                String17 = model3.userId;
            }else if (idx == 1){
                String18 = model3.userId;
            }else if (idx == 2){
                String19 = model3.userId;
            }else if (idx == 3){
                String20 = model3.userId;
            }else if (idx == 4){
                String21 = model3.userId;
            }else if (idx == 5){
                String22 = model3.userId;
            }else if (idx == 6){
                String23 = model3.userId;
            }else if (idx == 7){
                String24 = model3.userId;
            }else if (idx == 8){
                String25 = model3.userId;
            }else if (idx == 9){
                String26 = model3.userId;
            }else if (idx == 10){
                String27 = model3.userId;
            }else if (idx == 11){
                String28 = model3.userId;
            }else if (idx == 12){
                String29 = model3.userId;
            }else if (idx == 13){
                String30 = model3.userId;
            }else if (idx == 14){
                String31 = model3.userId;
            }else if (idx == 15){
                String32 = model3.userId;
            }
            
        }];
        
        [parameters setValue:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@",String1,String2,String3,String4,String5,String6,String7,String8,String9,String10,String11,String12,String13,String14,String15,String16,String17,String18,String19,String20,String21,String22,String23,String24,String25,String26,String27,String28,String29,String30,String31,String32] forKey:@"uidList"];
        
    }else if ([MAX_NUM isEqualToString:@"64"]){

        [parameters setValue:@"champion,runnerup,strong4,strong4,strong8,strong8,strong8,strong8,strong16,strong16,strong16,strong16,strong16,strong16,strong16,strong16,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong32,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64,strong64" forKey:@"rankingList"];

        MemberModel *model = (MemberModel *)[oneArray lastObject];
        String1 = model.userId;
        
        [parameters setValue:[NSString stringWithFormat:@"%@,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,",String1] forKey:@"uidList"];
        
    }
    
    
    
    NSLog(@"========%@",url);
    NSLog(@"========%@",parameters);
    
    [WTRequestCenter postWithURL:url
                      parameters:parameters completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                          
                          if (!error) {
                              NSError *jsonError = nil;
                              
                              id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                              
                              
                              if (!jsonError) {
                                  
                                  NSDictionary *dic = (NSDictionary *)obj;
                                  
                                  NSLog(@"%@",dic);
                                  
                                  
                                  NSString *state = [dic objectForKey:@"code"];
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismissWithSuccess:@"提交成绩成功"];
                                      
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      
                                      NSDictionary *dataDic = [dic objectForKey:@"data"];
                                      
                                      NSLog(@"%@",dataDic);
                                      
                                      _callRefresh();
                                      
                                      [self.navigationController popViewControllerAnimated:YES];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismissWithError:@"提交成绩失败"];
                                      
                                  }
                                  
                                  
                              }else
                              {
                                  NSLog(@"jsonError:%@",jsonError);
                                  [MMProgressHUD dismiss];
                                  
                              }
                              
                          }else
                          {
                              NSLog(@"error:%@",error);
                              [MMProgressHUD dismiss];
                              
                          }
                          
                      }];
    
    
    
    
}




- (void)callRefresh:(void (^)())myRefresh{
    
    _callRefresh = myRefresh;
    
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([MAX_NUM isEqualToString:@"4"]) {
        return 3;
    }else if ([MAX_NUM isEqualToString:@"8"]){
        return 4;
    }else if ([MAX_NUM isEqualToString:@"16"]){
        return 5;
    }else if ([MAX_NUM isEqualToString:@"32"]){
        return 6;
    }

    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        return 50;
    }else if (indexPath.row == 1){
        return 50;
    }else if (indexPath.row == 2){
        return 50;
    }else if (indexPath.row == 3){
        return 50;
    }else if (indexPath.row == 4){
        return 100;
    }else if (indexPath.row == 5){
        return 150;
    }else{
        return 300;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < 4) {
        
        static NSString *myCell = @"cell";
        
        LuRuCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        
        if (cell == nil) {
            
            cell = [[LuRuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            
        }
        
        if (indexPath.row == currentCell) {
            
            if (theNumArray.count >= 1) {
                
                MemberModel *model = (MemberModel *)[theNumArray lastObject];
                
                [cell.oneImg setImageWithURL:[NSURL URLWithString:model.headStr]];
                
                cell.oneImg.backgroundColor = [UIColor redColor];
                
            }

        }
        
        
        cell.accessoryType = 1;
        
        cell.theClass.text = [_dataArray objectAtIndex:indexPath.row];
        
        return cell;

        
    }else{
        
        static NSString *myCell = @"cell2";
        
        LuRuTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        
        if (cell == nil) {
            cell = [[LuRuTwoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            
            
        }
        
        
        cell.accessoryType = 1;
        
        cell.theClass.text = [_dataArray objectAtIndex:indexPath.row];
        
        
        return cell;

        
    }

    
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
//    BaoMemberController *mem = [[BaoMemberController alloc]init];
//    mem.activityId = activityIdStr;
//    [self.navigationController pushViewController:mem animated:YES];
    
    ChanMemViewController *mem = [[ChanMemViewController alloc]init];
    
    
    [mem callMemArray:^(NSMutableArray *array) {
    
        [_tableView reloadData];
        
        theNumArray = [NSMutableArray arrayWithArray:array];
        
        
        if (currentCell == 0) {
            
            oneArray = [NSMutableArray arrayWithArray:array];
            
        }else if (currentCell == 1){
        
            twoArray = [NSMutableArray arrayWithArray:array];

            
        }else if (currentCell == 2){
            
            threeArray = [NSMutableArray arrayWithArray:array];

            
        }else if (currentCell == 3){
            
            fourArray = [NSMutableArray arrayWithArray:array];

            
        }else if (currentCell == 4){
            
            fiveArray = [NSMutableArray arrayWithArray:array];

            
        }else if (currentCell == 5){
            
            
            sixArray = [NSMutableArray arrayWithArray:array];
            

        }else if (currentCell == 6){
            
            sevenArray = [NSMutableArray arrayWithArray:array];
            
        }
        
    }];
    
    
    
    
    if (indexPath.row == 0) {
    
        mem.numPeople = @"1";
    }else if (indexPath.row == 1){
        mem.numPeople = @"1";
    }else if (indexPath.row == 2){
        mem.numPeople = @"2";
    }
    else if (indexPath.row == 3){
        mem.numPeople = @"4";
    }else if (indexPath.row == 4){
        mem.numPeople = @"8";
    }else if (indexPath.row == 5){
        mem.numPeople = @"16";
    }else{
        mem.numPeople = @"32";
    }
    
    mem.activityId = activityIdStr;
    
    currentCell = (int)indexPath.row;
    
    [self.navigationController pushViewController:mem animated:YES];
    
    
//    ChangeUserViewController *change = [[ChangeUserViewController alloc]init];
//    [self.navigationController pushViewController:change animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
