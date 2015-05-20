//
//  MemberViewController.m
//  POOL
//
//  Created by king on 15/3/15.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MemberViewController.h"

#import "WTRequestCenter.h"


#import "ChatViewController.h"


#import "MeActivityViewController.h"

#import "MeJuLeBuViewController.h"

@interface MemberViewController (){
    
    UILabel *myName;
    
    UILabel *zuo;
    
    UILabel *qianming;

    UILabel *latestFeeds;
    
    UIImageView *qiuJI;
    
    NSString *isFollow;
    
    UIButton *guanbutton;

    
    NSMutableArray *wantArray;
    
}

@end

@implementation MemberViewController

@synthesize name,userIdStr;

- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self showBack];

    self.myTitleLabel.text = [NSString stringWithFormat:@"%@",name];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"情感状态",@"公司",@"职业",@"I WANT",@"爱好",@"家乡",@"注册日期", nil];
    
    _twoArray = [[NSMutableArray alloc]initWithObjects:@"个人描述",@"个人动态",@"参加的活动",@"加入的俱乐部", nil];
    
    _dataMessageArray = [NSMutableArray array];
    
    wantArray = [NSMutableArray array];
    
    [self createHead];
    
    UIImageView *foot = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    foot.backgroundColor = [UIColor clearColor];
    foot.userInteractionEnabled = YES;
    _tableView.tableFooterView = foot;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发消息" forState:UIControlStateNormal];
    btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, 40);
    [foot addSubview:btn];
    
    guanbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [guanbutton setTitle:@"关注" forState:UIControlStateNormal];
    guanbutton.titleLabel.font = [UIFont systemFontOfSize:12];
    guanbutton.frame = CGRectMake(SCREEN_WIDTH - 60, 34, 50, 20);
    [guanbutton addTarget:self action:@selector(navClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:guanbutton];
    
    [self message];
    
    for (int i = 0 ;i < 7; i ++) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(80, 445+155 + i * 50, 200, 20)];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:12];
        lab.tag = 20 + i;
        lab.textColor = [UIColor grayColor];
        [_tableView addSubview:lab];
        
    }
    
    // Do any additional setup after loading the view.
}

- (void)navClicked{
    
    if ([guanbutton.titleLabel.text isEqualToString:@"关注"]) {
        
        [MMProgressHUD showWithStatus:@"正在刷新"];
        
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
        
        NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
        
        NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
        
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
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"follow",@"add",sysString];
        
        
        NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:urlStringUse];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        [parameters setValue:sigString forKey:@"sig"];
        [parameters setValue:userIdStr forKey:@"uid"];
        
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
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      
                                      
                                      
                                      NSLog(@"%@",[dic objectForKey:@"msg"]);
                                      
                                      if (a == 0) {
                                          
                                          [MMProgressHUD dismissWithSuccess:@"添加关注成功"];
                                          
                                          [guanbutton setTitle:@"取消关注" forState:UIControlStateNormal];
                                          
                                      }else{
                                          
                                          NSString *str = [dic objectForKey:@"msg"];
                                          
                                          [MMProgressHUD dismissWithError:str];
                                          
                                          
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
        
        
        
    }else{
        
        
        [MMProgressHUD showWithStatus:@"正在刷新"];
        
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
        
        NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
        
        NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
        
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
        
        
        NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"follow",@"delete",sysString];
        
        
        NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:urlStringUse];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        
        [parameters setValue:sigString forKey:@"sig"];
        [parameters setValue:userIdStr forKey:@"uid"];
        
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
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      
                                      NSLog(@"%@",[dic objectForKey:@"msg"]);
                                      
                                      if (a == 0) {
                                          
                                          [MMProgressHUD dismissWithSuccess:@"取消关注成功"];
                                          
                                          [guanbutton setTitle:@"关注" forState:UIControlStateNormal];

                                          
                                      }else{
                                          
                                          NSString *str = [dic objectForKey:@"msg"];
                                          
                                          [MMProgressHUD dismissWithError:str];
                                          
                                          
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
    
}

#pragma mark 关注

- (void)guanZhu{
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"follow",@"add",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:userIdStr forKey:@"uid"];
    
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
                                  NSLog(@"%@",[[dic objectForKey:@"data"]class]);

                                  
                                  
                                  NSLog(@"%@",[dic objectForKey:@"msg"]);
                                  
                                  [MMProgressHUD dismiss];
                                      
                                  
                                  
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


- (void)message{
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"member",@"profile",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:userIdStr forKey:@"uid"];
    
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
                                  NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                  
                                  NSDictionary *dataDic = [dic objectForKey:@"data"];
                                  
                                  
                                  NSString *one = [dataDic objectForKey:@"affectiveStatus"];
                                  NSLog(@"%@",one);
                                  NSString *two = [dataDic objectForKey:@"company"];
                                  NSLog(@"%@",two);
                                  NSString *three = [dataDic objectForKey:@"occupation"];
                                  NSLog(@"%@",three);
                                  NSString *four = [dataDic objectForKey:@"payRole"];
                                  NSLog(@"%@",four);
//                                  NSString *five = [dataDic objectForKey:@"interest"];
                                  NSString *five = @"";
                                  
                                  NSString *six = [dataDic objectForKey:@"hometown"];
                                  
                                  
                                  
                                  NSString *str = [dataDic objectForKey:@"regTime"];
                                  NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
                                  NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                                  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                  
                                  [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                  
                                  NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
                                  
                                  
                                  myName.text = [dataDic objectForKey:@"nickName"];
                                  
                                  zuo.text = [dataDic objectForKey:@"occupation"];
                                  
                                  
                                  zuo.text = @"天枰座";
                                  
                                  qianming.text = [dataDic objectForKey:@"bio"];
                                  
//                                  latestFeeds = [dataDic objectForKey:@""];
                                  
                                  
                                  NSString *seven = currentDateStr;
                                  
                                  isFollow = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"isFollow"]];
                                  
                                  if ([isFollow isEqualToString:@"1"]) {

                                      [guanbutton setTitle:@"取消关注" forState:UIControlStateNormal];
                                      
                                  }else{
                                      
                                      [guanbutton setTitle:@"关注" forState:UIControlStateNormal];
                                      
                                  }
                                  
                                  
                                  [_dataMessageArray addObject:one];
                                  [_dataMessageArray addObject:two];
                                  [_dataMessageArray addObject:three];
                                  [_dataMessageArray addObject:four];
                                  [_dataMessageArray addObject:five];
                                  [_dataMessageArray addObject:six];
                                  [_dataMessageArray addObject:seven];
                                  
                                  
                                  
                                  wantArray = [dataDic objectForKey:@"interest"];
                                  
                                  
                                  
                                  [self createLabel];
                                  
                                  /*
                                   
                                   avatars   头像
                                   nickName
                                   gender
                                   age
                                   constellation   星座
                                   sigHtml   个性签名 
                                   
                                   pkCredit  pk积分
                                   
                                   cityRank 同城排名  99
                                   
                                   worldRank 全国
                                   
                                   evUpgrade 评级
                                   
                                   
                                   affectiveStatus  情感
                                   
                                   company
                                   
                                   occupation
                                   
                                   
                                   payRole    I WANT
                                   
                                   
                                   爱好   interest

                                   hometown
                                   
                                   
                                   regTime   注册日期
                                   
                                   bio  个人描述
                                   
                                   latestFeeds  个人动态
                                   
                                   
                                   lastActivity 上次登录
                                   
                                   
                                   */
                                  
                                  
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      
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


- (void)btnClicked{
    
    NSLog(@"a");
    
    
    
    
#pragma mark CHAT-CHAT-CHAT-CHAT-CHAT-CHAT-CHAT-CHAT-CHAT-CHAT
    
    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:@"13" isGroup:NO];
    [self.navigationController pushViewController:chatVC animated:YES];
    
    
}

- (void)createHead{
    
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 360)];
    headView.backgroundColor = [UIColor lightGrayColor];
//    headView.image = [UIImage imageNamed:@"dbj11"];
    headView.backgroundColor = R_G_B_COLOR(45, 69, 130);

    
    
    
    
    
    _tableView.tableHeaderView = headView;
    
    
//    UIImageView *myHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10+170, 50, 50)];
//    myHead.image = [UIImage imageNamed:@"demo"];
//    [headView addSubview:myHead];

    
    
//    myName = [[UILabel alloc]initWithFrame:CGRectMake(70-50, 15+170, 70, 15)];
//    myName.font = [UIFont systemFontOfSize:13];
//    myName.textColor = [UIColor whiteColor];
//    myName.text = @"小白";
//    [headView addSubview:myName];
    
    
    UIImageView *seximg = [[UIImageView alloc]initWithFrame:CGRectMake(10,170, 20, 20)];
    seximg.backgroundColor = [UIColor redColor];
    seximg.image = [UIImage imageNamed:@""];
    [headView addSubview:seximg];
    
    UILabel *age = [[UILabel alloc]initWithFrame:CGRectMake(35, 170, 60, 20)];
    age.font = [UIFont systemFontOfSize:13];
    age.textColor = [UIColor whiteColor];
    age.text = @"25";
    [headView addSubview:age];
    
    
    UILabel *howfar = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 170, 90, 20)];
    howfar.font = [UIFont systemFontOfSize:13];
    howfar.textAlignment = NSTextAlignmentRight;
    howfar.textColor = [UIColor whiteColor];
    howfar.text = @"1000km";
    [headView addSubview:howfar];
    
    
    
    
    zuo = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, 60, 15)];
    zuo.text = @"金牛座";
    zuo.textColor = [UIColor whiteColor];
    zuo.font = [UIFont systemFontOfSize:12];
    [headView addSubview:zuo];
    
    
    latestFeeds = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 200, 90, 20)];
    latestFeeds.font = [UIFont systemFontOfSize:13];
    latestFeeds.textAlignment = NSTextAlignmentRight;
    latestFeeds.textColor = [UIColor whiteColor];
    latestFeeds.text = @"13123123";
    [headView addSubview:latestFeeds];
    
    
    
    
    qianming = [[UILabel alloc]initWithFrame:CGRectMake(10, 70+150, SCREEN_WIDTH - 20, 40)];
    qianming.text = @"个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名个性签名";
    qianming.textColor = [UIColor whiteColor];
    qianming.numberOfLines = 3;
    qianming.font = [UIFont systemFontOfSize:12];
    [headView addSubview:qianming];
    
    
    
    
    int cc = SCREEN_WIDTH/4;
    
    
    for (int i = 0; i < 8; i++) {
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(cc * ((i)%4) + 5, 10 + cc * (i/4), cc - 10, cc - 10)];
        mv.image = [UIImage imageNamed:@"demo"];
        mv.userInteractionEnabled  = YES;
        mv.tag = 30  + i;
      
        [headView addSubview:mv];
        
        
        if (i == 7) {
            break;
        }
        
    }
    
    
    
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *pk = [[UILabel alloc]initWithFrame:CGRectMake(20 + i * 100, 120 + 160, 90, 16)];
        pk.backgroundColor = R_G_B_COLOR(246, 137, 83);
        pk.layer.cornerRadius = 8;
        pk.layer.masksToBounds = YES;
        pk.text = @"pk积分:115";
        pk.textAlignment = NSTextAlignmentCenter;
        pk.font = [UIFont systemFontOfSize:12];
        pk.textColor = [UIColor whiteColor];
        [headView addSubview:pk];
        
        
    }
    
    
    UIImageView *ci = [[UIImageView alloc]initWithFrame:CGRectMake(20, 157 + 160, SCREEN_WIDTH- 40, 26)];
    ci.backgroundColor = [UIColor whiteColor];
    ci.alpha = 0.2;
    ci.layer.cornerRadius = 13;
    ci.layer.masksToBounds = YES;
    [headView addSubview:ci];
    
    UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(30, 155 + 160, SCREEN_WIDTH - 40, 30)];
    labe.backgroundColor = [UIColor clearColor];
//    labe.alpha = 0.6;
    labe.text = @"竞技等级";
    labe.layer.cornerRadius = 15;
    labe.font = [UIFont systemFontOfSize:13];
    labe.textColor = [UIColor whiteColor];
    [headView addSubview:labe];
    
    
    qiuJI = [[UIImageView alloc]initWithFrame:CGRectMake(60, 5, 20, 20)];
    qiuJI.image = [UIImage imageNamed:@"icon_billiards_1"];
    [labe addSubview:qiuJI];
    
    
    for (int i = 0; i < 5; i ++) {
    
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(100 + 20 * i, 7, 15, 15)];
        mv.image = [UIImage imageNamed:@"icon_xing_kong"];
        [labe addSubview:mv];
    }
   
    for (int i = 0; i < 3; i ++) {
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(100 + 20 * i, 7, 15, 15)];
        mv.image = [UIImage imageNamed:@"icon_xing_shi"];
        [labe addSubview:mv];
    }
    
}








#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return _twoArray.count;
    }else{
        
        return _dataArray.count;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = [_twoArray objectAtIndex:indexPath.row];
        if (indexPath.row == 2 || indexPath.row == 3) {
            cell.accessoryType = 1;
        }

    }else{
        
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
        
    }
    
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 2) {
            
            MeActivityViewController *me = [[MeActivityViewController alloc]init];
            [self.navigationController pushViewController:me animated:YES];
            
        }else if (indexPath.row == 3){
            
            MeJuLeBuViewController *me = [[MeJuLeBuViewController alloc]init];
            [self.navigationController pushViewController:me animated:YES];

        }
        
    }
    
}


- (void)createLabel{
    
//    NSLog(@"%@",[_dataMessageArray objectAtIndex:1]);
    
    for (int i = 20; i < 27; i ++) {
        
        UILabel *lab = (UILabel *)[self.view viewWithTag:i];
        
        lab.text = [_dataMessageArray objectAtIndex:(i - 20)];
        
    }
    
    [wantArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(60 + (60*idx), 800, 59, 20)];
        lab.text = [self getStringWithNum:[obj intValue]];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = [UIColor lightGrayColor];
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = [UIColor whiteColor];
        [_tableView addSubview:lab];
        
    }];
 
}






- (NSString *)getStringWithNum:(int)num{
    
    switch (num) {
        case 1:
        {
            return @"台球";
        }
            break;
        case 2:
        {
            return @"羽毛球";
        }
            break;
        case 3:
        {
            return @"网球";

        }
            break;
        case 4:
        {
            return @"乒乓球";

        }
            break;
        case 5:
        {
            return @"golf";

        }
            break;
        case 6:
        {
            return @"足球";

        }
            break;
        case 7:
        {
            return @"篮球";
   
        }
            break;
        case 8:
        {
            return @"游泳";

        }
            break;
        case 9:
        {
            return @"保龄";

        }
            break;
        case 10:
        {
            return @"滑雪";

        }
            break;
        case 11:
        {
            return @"射箭";

        }
            break;
        case 12:
        {
            return @"骑马";

        }
            break;
        case 13:
        {
            return @"户外";

        }
            break;
        case 14:
        {
            return @"跑步";

        }
            break;
        case 15:
        {
            return @"桌游";

        }
            break;
        case 16:
        {
            return @"摄影";

        }
            break;
        case 17:
        {
            return @"KTV";

        }
            break;
        case 18:
        {
            return @"聚餐";

        }
            break;
        case 19:
        {
            return @"培训";

        }
            break;
        default:
            return @"台球";
            break;
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
