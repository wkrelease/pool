//
//  ChanMemViewController.m
//  POOL
//
//  Created by king on 15/4/22.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChanMemViewController.h"

#import "WTRequestCenter.h"

#import "MemberModel.h"

@interface ChanMemViewController ()

@end

@implementation ChanMemViewController

@synthesize activityId;


- (void)callMemArray:(void (^)(NSMutableArray *))myMem{
    
    _callMemArray = myMem;
    
}

- (void)qued{
    
    NSLog(@"确定");
    
    NSMutableArray *memArray = [NSMutableArray array];
    
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
         
            UIButton *btn = (UIButton *)view;
            
            if (btn.selected) {
                
                NSLog(@"%ld",(long)btn.tag);
                
                MemberModel *model = (MemberModel *)[_dataArray objectAtIndex:btn.tag - 190];
                
                [memArray addObject:model];

                
            }
            
        }
        
    }
    
    
    if (memArray.count > [_numPeople intValue]) {
        
        [MMProgressHUD showWithStatus:@""];
        
        [MMProgressHUD dismissWithError:@"选择人数超过该等级要求人数"];
        
        return;
    }
    
    
    _callMemArray(memArray);
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"成员";
    
    [self showBack];
    
    [self member];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(qued) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 23, 50, 30);
    [self.navView addSubview:rightBtn];
    _dataArray = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
    
}

- (void)imgBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
}

- (void)createMyView{
    
    int cub = SCREEN_WIDTH/4 - 10;
    
    int bu = SCREEN_WIDTH/4 - 5;
    
    for (int i = 0; i < _dataArray.count; i ++) {
        
        MemberModel *model = (MemberModel *)[_dataArray objectAtIndex:i];
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(10 + bu*(i%4), NAV_HEIGHT + 10 + (i/4)*bu, cub, cub)];
        mv.backgroundColor = [UIColor lightGrayColor];
        [mv setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.headStr]]];
        [self.view addSubview:mv];
        
        UILabel *nam = [[UILabel alloc]initWithFrame:CGRectMake(0, cub - 15, cub, 15)];
        nam.text = model.nameStr;
        nam.backgroundColor = [UIColor grayColor];
        nam.textColor = [UIColor whiteColor];
        nam.font = [UIFont systemFontOfSize:12];
        nam.textAlignment = NSTextAlignmentCenter;
        [mv addSubview:nam];
        
        
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        imgBtn.frame = CGRectMake(10 + bu*(i%4), NAV_HEIGHT + 10 + (i/4)*bu, cub, cub);
        imgBtn.tag = 190 + i;
        [imgBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [imgBtn setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateSelected];
        [imgBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:imgBtn];
        
    }

    
    
}




- (void)member{
    
    [_dataArray removeAllObjects];
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"member",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:activityId forKey:@"activityId"];
    
    //    [parameters setValue:@"" forKey:@"startTime"];
    //    [parameters setValue:@"" forKey:@"endTime"];
    
    
    
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
                                      
                                      NSArray *userArray = [dataDic objectForKey:@"userList"];
                                      
                                      for (NSDictionary *diction in userArray) {
                                          
                                          MemberModel *model = [[MemberModel alloc]init];
                                          model.userId = [diction objectForKey:@"uid"];
                                          model.headStr = [diction objectForKey:@"avatar"];
                                          model.nameStr = [diction objectForKey:@"nickName"];
                                          model.sexStr = [diction objectForKey:@"gender"];
                                          //1  是男   2是女
                                          model.ageStr = [NSString stringWithFormat:@"%@岁",[diction objectForKey:@"age"]];
                                          model.qiuStr = [diction objectForKey:@"evUpgrade"];
                                          //等级
                                          
                                          model.scoreStr = [diction objectForKey:@"pkCredit"];
                                          
                                          [_dataArray addObject:model];
                                          
                                          
                                      }
                                      
                                      [self createMyView];

                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      
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
