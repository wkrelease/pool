//
//  ActivityMessageViewController.m
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ActivityMessageViewController.h"
#import "faBuCell.h"

#import "BaoMingCell.h"
#import "BaoMingModel.h"

#import "UMSocialWechatHandler.h"

#import "WTRequestCenter.h"

#import "BaoMemberController.h"

#import "LuRuViewController.h"


#import "ActivityPhotoViewController.h"

#import "LookPhotoViewController.h"


#import "JuAddressViewController.h"

#import "ChengJiViewController.h"

@interface ActivityMessageViewController ()

@end

@implementation ActivityMessageViewController{
    
    
    NSString *myActivityState;
    
    
    NSString *actiZhuTiStr;
    
}


@synthesize actString;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    self.myTitleLabel.text = @"活动详情";
    
    
    imageArray = [NSMutableArray array];
    
    userImageArray = [NSMutableArray array];
    
    _dataMessageArray = [NSMutableArray array];
    
    [self showBack];
    
    
    UIButton *fen  = [UIButton buttonWithType:UIButtonTypeCustom];

    fen.frame =   CGRectMake(SCREEN_WIDTH - 35, 36, 25, 20);
    
    [fen setImage:[UIImage imageNamed:@"nav_more@2x"] forState:UIControlStateNormal];
    
    [fen addTarget:self action:@selector(fenClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.navView addSubview:fen];
    
    [self refreshtable];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)fenClicked{
    
    NSLog(@"分数");
    
    //    [UMSocialWechatHandler setWXAppId:@"wx11010f821017277f" appSecret:@"f11e97c78b570f89966e5fe54a8ec907" url:[NSString stringWithFormat:@"http://115.28.86.228/concern/share_news.php?id=%@",myIdStr]];
    
    [UMSocialWechatHandler setWXAppId:@"wx11010f821017277f" appSecret:@"f11e97c78b570f89966e5fe54a8ec907" url:[NSString stringWithFormat:@"http://115.28.86.228/concern/share_news.php?id=%@",@"12"]];
    
    
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"54efc2a7fd98c528530003c9"
                                      shareText:@"你要分享的文字"
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self];
    
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"name";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"name";
    
    [UMSocialData defaultData].extConfig.qqData.title = @"name";
    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"http://115.28.86.228/concern/share_news.php?id=%@",@"12"];
    
    [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"http://115.28.86.228/concern/share_news.php?id=%@",@"12"];
    
    
    
    [[UMSocialControllerService defaultControllerService] setShareText:@"name" shareImage:nil socialUIDelegate:self];        //设置分享内容和回调对象
    
}




#pragma mark data

- (void)refreshtable{
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"view",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:actString forKey:@"activityId"];
    
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
                                      
                                      
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      NSDictionary *dict = [dic objectForKey:@"data"];
                                      NSArray *imArr = [dict objectForKey:@"images"];
                                      for (NSDictionary *dd in imArr) {
                                          
                                          [imageArray addObject:[dd objectForKey:@"url"]];
                                          
                                      }
                                      
                                      isOwner = [dict objectForKey:@"isOwner"];
                                      
                                      ISPK = [dict objectForKey:@"isPk"];
                                      
                                      NSLog(@"%@",isOwner);
                                      NSString *zhuti = [dict objectForKey:@"title"];
                                      NSString *didian = [dict objectForKey:@"area"];
                                
                                      
                                      NSString *str = [dict objectForKey:@"startTime"];
//                                      NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
                                     
                                      NSTimeInterval time=[str doubleValue];
                                      
                                      NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                                      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                      [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                      NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
                                      
                                      NSString *date = currentDateStr;

                                      
                                      NSString *cost = [dict objectForKey:@"cost"];
                                      
                                      NSString *apply = [dict objectForKey:@"applyNum"];
                                      NSString *max = [dict objectForKey:@"maxNum"];
                                      NSString *renshu = [NSString stringWithFormat:@"%@/%@",apply,max];
                                      
                                      NSString *yaoQiu = [dict objectForKey:@"require"];
                                      
                                      NSString *shuo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"message"]];
                                      
                                      
                                      actiZhuTiStr = zhuti;
                                      
                                      
                                      myActivityState = [dict objectForKey:@"status"];
                                      
                                      [_dataMessageArray addObject:zhuti];
                                      [_dataMessageArray addObject:didian];
                                      [_dataMessageArray addObject:date];
                                      [_dataMessageArray addObject:cost];
                                      [_dataMessageArray addObject:renshu];
                                      [_dataMessageArray addObject:yaoQiu];
                                      [_dataMessageArray addObject:shuo];
                                      [_dataMessageArray addObject:@""];
                                      
                                      [self createOne];
                                      [self refreshHead];

                                      NSArray *myAr = [dict objectForKey:@"userList"];
                                      
                                      for (NSDictionary *dd in myAr) {
                                          
                                          [userImageArray addObject:[dd objectForKey:@"avatar"]];
                                          
                                      }
                                      
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




- (void)refreshHead{
    
    int cc = SCREEN_WIDTH/4;
    
   
    for (int i = 0; i < imageArray.count; i++) {
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(cc * ((i)%4) + 5, 5 + cc * (i/4), cc - 10, cc - 10)];
        [mv setImageWithURL:[NSURL URLWithString:[imageArray objectAtIndex:i]]];
        mv.userInteractionEnabled  = YES;
        mv.tag = 30  + i;
        mv.contentMode = UIViewContentModeScaleAspectFill;
        mv.clipsToBounds = YES;
        
        UITapGestureRecognizer *tao = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mvClick:)];
        [mv addGestureRecognizer:tao];
        
        [head addSubview:mv];
        
        
        if (i == 7) {
            break;
        }
        
    }
    
    
}

- (void)mvClick:(UITapGestureRecognizer *)tap{
    
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








- (void)createOne{
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    _tableView.backgroundColor = R_G_B_COLOR(221, 221, 221);
    [self.view addSubview:_tableView];
    
    
    head = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    head.backgroundColor = [UIColor clearColor];
    head.userInteractionEnabled = YES;
    
    
//    photoTable = [[UITableView alloc]initWithFrame:CGRectMake(120, -120, 70, SCREEN_WIDTH)style:UITableViewStylePlain];
//    photoTable.backgroundColor = [UIColor clearColor];
//    photoTable.showsVerticalScrollIndicator = NO;
//    photoTable.showsHorizontalScrollIndicator = NO;
//    photoTable.transform = CGAffineTransformMakeRotation(-M_PI / 2);
//    photoTable.separatorStyle = 0;
//    photoTable.delegate = self;
//    photoTable.dataSource = self;
//    [head addSubview:photoTable];
    
  
    _tableView.tableHeaderView = head;
    
    _dataArray = [NSMutableArray arrayWithObjects:@"主题",@"场馆",@"时间",@"费用",@"人数",@"要求",@"说明",@"已报名成员", nil];
    
    
    UIImageView *footer = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    footer.backgroundColor = R_G_B_COLOR(221, 221, 221);
    footer.userInteractionEnabled = YES;
    _tableView.tableFooterView = footer;
    
    
    
    NSLog(@"%@",myActivityState);
    
    if ([myActivityState isEqualToString:@"0"]) {
        
        self.myTitleLabel.text = @"活动详情(报名中)";

    }else if ([myActivityState isEqualToString:@"1"]){
        
        self.myTitleLabel.text = @"活动详情(进行中)";
        
    }
    
    
    if ([myActivityState isEqualToString:@"2"]) {
        
        self.myTitleLabel.text = @"活动详情(已结束)";
        
        if (ISPK) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"查看成绩" forState:UIControlStateNormal];
            button.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 40);
            button.backgroundColor = R_G_B_COLOR(50, 221, 161);
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(LookClick:) forControlEvents:UIControlEventTouchUpInside];
            [footer addSubview:button];
            
        }else{
            
            footer.frame = CGRectZero;
            _tableView.tableFooterView = footer;
            
        }
        
     
        
        
        return;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([isOwner isEqualToString:@"0"]) {
        
        [btn setTitle:@"报名" forState:UIControlStateNormal];
        btn.backgroundColor = R_G_B_COLOR(50, 221, 161);

        
    }else{
        
        
        if ([ISPK isEqualToString:@"1"]) {

            btn.backgroundColor = R_G_B_COLOR(50, 221, 161);

        }else{

            btn.backgroundColor = [UIColor grayColor];

        }
        
        [btn setTitle:@"录入成绩" forState:UIControlStateNormal];
        
        
        //增加删除活动
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"删除活动" forState:UIControlStateNormal];
        button.frame = CGRectMake(20, 80, SCREEN_WIDTH - 40, 40);
        button.backgroundColor = R_G_B_COLOR(50, 221, 161);
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(DeleteClick:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:button];


    }
    
//    [btn setTitle:@"报名" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(BaoClick:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:btn];
    
    
    
}


- (void)LookClick:(UIButton *)look{
    
    NSLog(@"查看成绩");
    
    ChengJiViewController *cheng = [[ChengJiViewController alloc]init];
    
    cheng.activityIDStr = actString;
    
    cheng.titleString = actiZhuTiStr;
    
    [self.navigationController pushViewController:cheng animated:YES];
    
}


- (void)DeleteClick:(UIButton *)bbtn{
    
  
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除此活动" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        
    }else if (buttonIndex == 1){
        
        [self deleHUODONG];

    }
    
}

- (void)deleHUODONG{
    
    [MMProgressHUD showWithStatus:@"正在删除活动"];
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"delete",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:actString forKey:@"activityId"];
 
    
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
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismissWithSuccess:@"删除活动成功"];

                                      _callBackDelete();
                                      
                                      
                                      [self.navigationController popViewControllerAnimated:YES];
                                      
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




- (void)callBackDelete:(void (^)())myDelete{
    
    _callBackDelete = myDelete;
    
}


- (void)BaoClick:(UIButton *)bbtn{
    
    
    if ([isOwner isEqualToString:@"0"]) {
        
        NSLog(@"报名");
        
        if ([myActivityState isEqualToString:@"1"]) {
            
            [MMProgressHUD showWithStatus:@"活动已开始，无法报名"];
            
            [MMProgressHUD dismissWithError:@"活动已开始，无法报名"];
            
            return;
        }
        
        
        [self baoMing];

    }else{
        
        NSLog(@"录入成绩 ");
        
        if (bbtn.backgroundColor == [UIColor grayColor]) {
            
            [MMProgressHUD showWithStatus:@"活动还未开始请稍候录入成绩"];
            [MMProgressHUD dismissWithError:@"活动还未开始请稍候录入成绩"];

            
            return;
        }else{
            
        }
        
        
        if ([myActivityState isEqualToString:@"1"]) {

            LuRuViewController *lu = [[LuRuViewController alloc]init];
            lu.theTitle = @"";
            lu.dateStr = @"";
            lu.activityIdStr = actString;
            
            [lu callRefresh:^{
               

                [self refreshtable];
                
            }];
            
            [self.navigationController pushViewController:lu animated:YES];

                                       
        }else{
            
            [MMProgressHUD showWithStatus:@""];
            [MMProgressHUD dismissWithError:@"不在活动时间内"];
            
        }
        
        
        
    }
}



#pragma mark tableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([tableView isEqual:_tableView]) {
        
       return  _dataArray.count;
        
    }else{
        
        return 10;

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        
        if (indexPath.row == 7) {
            return 100;
        }else if (indexPath.row == 6){
            
            return 160;
            
        }
        
        return 60;
        
    }else
    {
        return 70;

        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        
        
        static NSString *myCell = @"cell";
        
        BaoMingCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        
        
        if (cell == nil) {
            cell = [[BaoMingCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        }
        
        cell.name.text = [_dataArray objectAtIndex:indexPath.row];
        
        cell.message.text = [_dataMessageArray objectAtIndex:indexPath.row];
        
        cell.selectionStyle = 0;
        
        cell.backgroundColor = [UIColor whiteColor];
        
        
        if (indexPath.row == 7) {
            cell.line.backgroundColor = [UIColor clearColor];
            cell.message.text = @"";
            for (int i = 0; i < userImageArray.count; i ++) {
                
                UIImageView *mm = [[UIImageView alloc]initWithFrame:CGRectMake(10 + i * 40, 50, 30, 30)];
                [mm setImageWithURL:[NSURL URLWithString:[userImageArray objectAtIndex:i]]];
                if (mm.image == nil) {
                    mm.image = [UIImage imageNamed:@"demo"];
                }
                mm.layer.cornerRadius = 15;
                mm.layer.masksToBounds = YES;
                [cell addSubview:mm];
                
                if (i == 5) {
                    break;
                }
            }
            
            UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
            [bt setTitle:@"查看更多" forState:UIControlStateNormal];
            bt.titleLabel.font = [UIFont systemFontOfSize:12];
            [bt setTitleColor:R_G_B_COLOR(45, 69, 130) forState:UIControlStateNormal];
            bt.frame = CGRectMake(SCREEN_WIDTH - 70, 55, 60, 20);
            [bt addTarget:self action:@selector(moreand) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:bt];
            
        }else if (indexPath.row == 6){

            cell.message.textAlignment = NSTextAlignmentLeft;
            
            cell.message.frame = CGRectMake(80, 10, SCREEN_WIDTH - 90, 100);
            
            cell.line.frame = CGRectMake(0, 149, SCREEN_WIDTH, 1);
            
            
        }else if (indexPath.row == 5){
            
            cell.message.textAlignment = NSTextAlignmentLeft;

            cell.message.frame = CGRectMake(80, 10, SCREEN_WIDTH - 90, 60);

        
            
        }else{
            
            cell.message.textAlignment = NSTextAlignmentRight;

            
        }
        
        return cell;
        
    }else{
        
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
    
   
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 1) {
        
        JuAddressViewController *addre = [[JuAddressViewController alloc]init];
        
        addre.addressType = @"look";
        
        [addre callBackAdress:^(NSString *str) {
            
//            addressLabel.text = str;
            
        }];
        [self.navigationController pushViewController:addre animated:YES];
        
    }
    
}



- (void)moreand{
    
    NSLog(@"more");
    
    BaoMemberController *mem = [[BaoMemberController alloc]init];
    if ([isOwner isEqualToString:@"0"]) {
       
        mem.canDel = @"";

    }else{
    
        mem.canDel = @"can";

    }
    mem.activityId = actString;
    [self.navigationController pushViewController:mem animated:YES];
    
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
    
    [parameters setValue:actString forKey:@"activityId"];
    
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
