//
//  ActivityMessageViewController.m
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChangMessageViewController.h"
#import "faBuCell.h"

#import "WTRequestCenter.h"

#import "LookPhotoViewController.h"

#import "BaoMemberController.h"

@interface ChangMessageViewController (){
    
    
    
    BOOL haveAct;
    
}

@end

@implementation ChangMessageViewController

@synthesize changID;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    haveAct = NO;
    
    self.myTitleLabel.text = @"场馆详情";
    
    imageArray = [NSMutableArray array];
    
    memImageArray = [NSMutableArray array];
    
    [self showBack];
    
    [self reques];
    
    
    [self createOne];
    
    // Do any additional setup after loading the view.
}


- (void)createImage{
    
    int cc = SCREEN_WIDTH/4;
    
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(cc * ((i)%4) + 5, 5 + cc * (i/4), cc - 10, cc - 10)];
        [mv setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:i]]];
        mv.userInteractionEnabled  = YES;
        mv.tag = 30  + i;
        
        UITapGestureRecognizer *tao = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mvCli:)];
        [mv addGestureRecognizer:tao];
        
        [mainScroll addSubview:mv];
        
        
        if (i == 7) {
            break;
        }
        
    }

    
    
}
- (void)mvCli:(UITapGestureRecognizer *)tap{
    
    
    NSLog(@"%ld",(long)tap.view.tag);
    LookPhotoViewController *lo = [[LookPhotoViewController alloc]init];
    lo.photoArray = imageArray;
    lo.currentIndex = tap.view.tag - 30;
    CATransition *transition = [CATransition animation];
    transition.type = @"rippleEffect";
    transition.duration = 0.7;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:lo animated:NO];

    
}



- (void)reques{
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    //    NSString *sysString = [NSString stringWithFormat:@"%@|%@|mn|15911177069|",CURRENT_UUID,CURRENT_API];
    //    NSString *sysString = [NSString stringWithFormat:@"%@|%@|mn||",CURRENT_UUID,CURRENT_API];
    
    
    NSLog(@"%@",sysString);
    
    /******
     *a
     *c
     *sys
     ******
     */
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"venues",@"view",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:changID forKey:@"vId"];
    
    
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
                                      
                                      NSDictionary *dict = [dic objectForKey:@"data"];
                                      
                                      
                                      titleLabel.text = [dict objectForKey:@"name"];
//                                      addresslabel.text = [dict objectForKey:@"description"];
                                      addresslabel.text = [dict objectForKey:@"area"];

                                      phonelabel.text = [dict objectForKey:@"phone"];
                                      priceLabel.text = [dict objectForKey:@"percapita"];;
                                      numLabel.text = [dict objectForKey:@"percapita"];
                                      
                                      
                                      ren.text = [NSString stringWithFormat:@"人均费用:%@元",[dict objectForKey:@"percapita"]];
                                      
                                      
                                      NSLog(@"%@",[dict objectForKey:@"logo"]);
                                      
                                      imageArray = [dict objectForKey:@"logo"];
                                      
                                      
                                     
                                      NSArray *actArr = [dict objectForKey:@"latestActivity"];
                                      
                                      
                                      if (actArr.count >= 1) {
                                          
                                          for (NSDictionary *diction in actArr) {
                                              
                                              activityID = [diction objectForKey:@"activityId"];
                                              
                                              
                                              
                                              
                                              //                                          NSString *str = [dict objectForKey:@"startTime"];
                                              //                                          NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
                                              //                                          NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                                              //                                          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                              //                                          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                              //                                          NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
                                              //                                          dalabel.text = currentDateStr;
                                              
                                              
                                              NSString *dateString = [[diction objectForKey:@"startTime"]stringByAppendingString:@"800"];
                                              NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                              NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                              [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                              NSString *showtim = [formatter1 stringFromDate:newDate];
                                              
                                              NSLog(@"%@",showtim);
                                              
                                              dalabel.text = showtim;
                                              
                                              
                                              
                                              
                                              
                                              
                                              messLab.text = [diction objectForKey:@"title"];
                                              
                                              baom.text = [NSString stringWithFormat:@"报名人数:%@/%@人",[diction objectForKey:@"applyNum"],[diction objectForKey:@"maxNum"]];
                                              
                                              
                                              
                                              NSArray *memArray = [diction objectForKey:@"applyMember"];
                                              
                                              for (NSDictionary *imgDic in memArray) {
                                                  
                                                  [memImageArray addObject:[imgDic objectForKey:@"avatar"]];
                                                  
                                              }
                                              
                                              
                                          }

                                          
                                          
                                          haveAct = YES;
                                          baoBtn.alpha = 1;
                                          
                                      }else{
                                          
                                          haveAct = NO;
                                          
                                          backVi.alpha = 0;
                                          
                                          baoBtn.alpha = 0;
                                          
                                      }
                                      
                                      
                                      
                                      

                                      [self createImage];
                                      [self createMember];
                                      
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




- (void)telClick{
    
    
    UIAlertView *ale = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您将要拨打此电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [ale show];
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        NSString *str = [NSString stringWithFormat:@"tel://%@",phonelabel.text];
        NSURL *muUrl = [NSURL URLWithString:str];
        [[UIApplication sharedApplication]openURL:muUrl];

    }else{
        
        
    }
    
}




- (void)createOne{
    
    
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH, 800);
    mainScroll.showsHorizontalScrollIndicator = NO;
    mainScroll.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:mainScroll];
    
    
    
//    photoTable = [[UITableView alloc]initWithFrame:CGRectMake(120, -120, 70, SCREEN_WIDTH)style:UITableViewStylePlain];
//    photoTable.backgroundColor = [UIColor clearColor];
//    photoTable.showsVerticalScrollIndicator = NO;
//    photoTable.showsHorizontalScrollIndicator = NO;
//    photoTable.transform = CGAffineTransformMakeRotation(-M_PI / 2);
//    photoTable.separatorStyle = 0;
//    photoTable.delegate = self;
//    photoTable.dataSource = self;
//    [mainScroll addSubview:photoTable];
    
    
    
    
    UIImageView *oneBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 80)];
    oneBack.backgroundColor = [UIColor whiteColor];
    [mainScroll addSubview:oneBack];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
    titleLabel.text = @"";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [oneBack addSubview:titleLabel];
    
    addresslabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 35, SCREEN_WIDTH - 20, 40)];
    addresslabel.font = [UIFont systemFontOfSize:13];
    addresslabel.text = @"";
    addresslabel.numberOfLines = -1;
    addresslabel.textColor = [UIColor lightGrayColor];
    [oneBack addSubview:addresslabel];
    
    UIImageView *twoBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 260, SCREEN_WIDTH, 40)];
    twoBack.backgroundColor = [UIColor whiteColor];
    twoBack.userInteractionEnabled = YES;
    [mainScroll addSubview:twoBack];
    
    phonelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 20)];
    phonelabel.backgroundColor = [UIColor clearColor];
    phonelabel.font = [UIFont systemFontOfSize:14];
    phonelabel.text= @"";
    [twoBack addSubview:phonelabel];
    
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    telBtn.backgroundColor = [UIColor clearColor];
    [telBtn setImage:[UIImage imageNamed:@"icon_call"] forState:UIControlStateNormal];
    telBtn.frame = CGRectMake(SCREEN_WIDTH - 35, 10, 20, 20);
    [telBtn addTarget:self action:@selector(telClick) forControlEvents:UIControlEventTouchUpInside];
    [twoBack addSubview:telBtn];
    
    NSArray *array = [NSArray arrayWithObjects:@"资费标准 (元/小时)",@"人均消费 (元/小时)",@"配套设施", nil];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 320 + idx * 60, 150, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = obj;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        [mainScroll addSubview:label];
        
    }];
    
    
    
    priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 350, 100, 20)];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = [UIFont systemFontOfSize:12];
    [mainScroll addSubview:priceLabel];
    
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 405, 100, 20)];
    numLabel.backgroundColor=  [UIColor clearColor];
    numLabel.font  = [UIFont systemFontOfSize:12];
    [mainScroll addSubview:numLabel];
    
    
    
    
    
    NSArray *ar = [NSArray arrayWithObjects:@"icon_ptss_wifi",@"icon_ptss_stop",@"icon_ptss_TV",@"icon_ptss_chess",@"icon_ptss_food",@"icon_ptss_room", nil];
    NSArray *arr = [NSArray arrayWithObjects:@"Wifi",@"停车",@"电视",@"棋牌",@"餐饮",@"包房", nil];
    for (int i = 0; i < 6; i ++ ) {
        
        UIImageView *mn = [[UIImageView alloc]initWithFrame:CGRectMake(20 + i * 30 ,470, 18, 18)];
        mn.image = [UIImage imageNamed:[ar objectAtIndex:i]];
        [mainScroll addSubview:mn];
        
        
        UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(20 + i * 30, 490, 20, 10)];
        la.font = [UIFont systemFontOfSize:8];
        la.text = [arr objectAtIndex:i];
        la.textColor = [UIColor grayColor];
        [mainScroll addSubview:la];
        
    }

    UILabel *mes = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, 200, 10)];
    mes.textColor = [UIColor grayColor];
    mes.text = @"本场馆采取分时计价方式，且需提前预约";
    mes.font  = [UIFont systemFontOfSize:10];
    [mainScroll addSubview:mes];
    
    NSArray *btnArray = [NSArray arrayWithObjects:@"抢购",@"预定", nil];
    [btnArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        btn.frame = CGRectMake(10 + ((SCREEN_WIDTH/2) * idx), 450 + 80, SCREEN_WIDTH/2 - 20, 30);
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = 40 + idx;
        if (idx == 0) {
            btn.backgroundColor = R_G_B_COLOR(246, 137, 83);
        }else{
            btn.backgroundColor = R_G_B_COLOR(80, 149, 237);
        }
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [mainScroll addSubview:btn];
        
    }];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 580, 150, 15)];
    label.textColor = [UIColor grayColor];
    label.text = @"该场馆近期活动";
    label.font = [UIFont systemFontOfSize:12];
    [mainScroll addSubview:label];
    
    backVi = [[UIImageView alloc]initWithFrame:CGRectMake(0, 600, SCREEN_WIDTH, 180)];
    backVi.backgroundColor = [UIColor whiteColor];
    backVi.userInteractionEnabled = YES;
    [mainScroll addSubview:backVi];
    
    
    UIImageView *li = [[UIImageView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH, 1)];
    li.backgroundColor = R_G_B_COLOR(221, 221, 221);
    [backVi addSubview:li];
    
    UIImageView *lin = [[UIImageView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 1)];
    lin.backgroundColor = R_G_B_COLOR(221, 221, 221);
    [backVi addSubview:lin];
    
    
    
    dalabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 20)];
    dalabel.text = @"8月30日18:30";
    dalabel.font = [UIFont systemFontOfSize:13];
    [backVi addSubview:dalabel];
    
    
    messLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 200, 10, 180, 20)];
    messLab.text = @"俱乐部16彩周赛";
    messLab.textAlignment = NSTextAlignmentRight;
    messLab.textColor = [UIColor grayColor];
    messLab.font = [UIFont systemFontOfSize:14];
    [backVi addSubview:messLab];
    
    
    
    
    ren = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 100, 20)];
    ren.text = @"人均费用:";
    ren.font = [UIFont systemFontOfSize:12];
    ren.textColor = [UIColor grayColor];
    [backVi addSubview:ren];
    
    baom = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 40, 100, 20)];
    baom.text = @"报名人数:";
    baom.textColor = [UIColor grayColor];
    baom.font = [UIFont systemFontOfSize:12];
    [backVi addSubview:baom];
    
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(SCREEN_WIDTH - 70, 80, 60, 20);
    [moreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreBtn setTitleColor:R_G_B_COLOR(80, 149, 237) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [moreBtn addTarget:self action:@selector(moreCli) forControlEvents:UIControlEventTouchUpInside];
    [backVi addSubview:moreBtn];
    
    
//    UILabel *bbb = [[UILabel alloc]initWithFrame:CGRectMake(20, 650, SCREEN_WIDTH - 20, 50)];
//    bbb.text = @"该场馆近期没有活动";
//    [mainScroll addSubview:bbb];
    

    baoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baoBtn setTitle:@"我要报名 " forState:UIControlStateNormal];
    baoBtn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    [baoBtn addTarget:self action:@selector(baoming) forControlEvents:UIControlEventTouchUpInside];
    baoBtn .frame = CGRectMake(20, 730, SCREEN_WIDTH - 40, 30);
    [mainScroll addSubview:baoBtn];
    
    
}


- (void)createMember{
    
    
    
    for (int i = 0; i < memImageArray.count; i ++) {
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i * 35, 70, 30, 30)];
        mv.image = [UIImage imageNamed:@"demo"];
        [mv setImageWithURL:[NSURL URLWithString:[memImageArray objectAtIndex:i]]];
        mv.layer.cornerRadius = 15;
        mv.clipsToBounds = YES;
        [backVi addSubview:mv];
        
    }

    
    
}


- (void)moreCli{
    
    NSLog(@"查看更多");
    BaoMemberController *mem = [[BaoMemberController alloc]init];
    mem.activityId = activityID;
    [self.navigationController pushViewController:mem animated:YES];
    
}

- (void)baoming{
    
   
    
    [self baoMing];
    
    
}









- (void)baoMing{
    
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    //    NSString *sysString = [NSString stringWithFormat:@"%@|%@|mn|15911177069|",CURRENT_UUID,CURRENT_API];
    //    NSString *sysString = [NSString stringWithFormat:@"%@|%@|mn||",CURRENT_UUID,CURRENT_API];
    
    
    NSLog(@"%@",sysString);
    
    /******
     *a
     *c
     *sys
     ******
     */
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"apply",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:activityID forKey:@"activityId"];
    
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
                                  
                                  
                                  
                                  NSString *stateStr = [dic objectForKey:@"msg"];
                                  
                                  NSLog(@"%@",stateStr);
                                  
                                  
                                  if (a == 0) {
                                      
                                      
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      
                                      [MMProgressHUD dismissWithSuccess:@"报名成功"];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismissWithError:stateStr];
                                      
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





























- (void)btnClicked:(UIButton *)button{
    
    NSLog(@"%ld",(long)button.tag);
    
}



#pragma mark tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *myCell = @"cell";
    
    faBuCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    
    
    if (cell == nil) {
        cell = [[faBuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    cell.selectionStyle = 0;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
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
