//
//  JuMessViewController.m
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuMessViewController.h"

#import "WTRequestCenter.h"

#import "JuKongViewController.h"

@interface JuMessViewController (){
    
    NSString *memberNum;
    
    NSString *userHead;
    
    NSString *userName;
    
    NSString *userId;

    NSString *xuanyan;
    
    NSString *shuoming;
    
    NSString *dateStr;
    
    
    NSString *groupID;
    
}

@end

@implementation JuMessViewController


@synthesize name,idstr; 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBack];
    
    self.myTitleLabel.text = name;
    
    upImageArray = [NSMutableArray array];
    
    memberArray = [NSMutableArray array];
    

    [self requestList];
    
    
    // Do any additional setup after loading the view.
}

- (void)creatTab{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"俱乐部积分",@"俱乐部排名",@"空间",@"成员数",@"创始人",@"宣言",@"说明",@"成立时间",@"静音", nil];
    
    UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    _tableView.tableHeaderView = mv;
    
    
    
    for (int i = 0; i < 8; i++) {
        
        UIImageView *mm = [[UIImageView alloc]initWithFrame:CGRectMake(5 + (i%4)*SCREEN_WIDTH/4, 10 + (i/4) * SCREEN_WIDTH/4, (SCREEN_WIDTH/4 - 10), (SCREEN_WIDTH/4-10))];
        mm.image = [UIImage imageNamed:@"demo"];
        [mv addSubview:mm];
        
    }
    
    
    UIImageView *downmv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    downmv.userInteractionEnabled = YES;
    _tableView.tableFooterView = downmv;

    NSArray *arr = [NSArray arrayWithObjects:@"加入",@"发消息", nil];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        btn.frame = CGRectMake(10 + SCREEN_WIDTH/2 * idx, 20, (SCREEN_WIDTH/2 - 20), 40);
        btn.tag = 130 + idx;
        if (idx == 0) {
            
            btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
            
        }else{
            
            btn.backgroundColor = R_G_B_COLOR(80, 147, 235);

        }
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [downmv addSubview:btn];
        
     }];
    
}

- (void)btnClicked:(UIButton *)button{
    
    if (button.tag == 130) {
        
        NSLog(@"加入");
        
    }else{
        
        NSLog(@"发消息");
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

    return cell.frame.size.height;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.selectionStyle = 0;
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.row == 0) {
        
        UILabel *score=  [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 10, 90, 30)];
        score.textAlignment = NSTextAlignmentRight;
        score.font = [UIFont systemFontOfSize:14];
        score.text = @"10000";
        [cell addSubview:score];
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        
    }else if (indexPath.row == 1){
        
        UILabel *score=  [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 220, 15, 100, 20)];
        score.textAlignment = NSTextAlignmentCenter;
        score.font = [UIFont systemFontOfSize:14];
        score.backgroundColor = R_G_B_COLOR(80, 149, 237);
        score.layer.cornerRadius= 10;
        score.layer.masksToBounds = YES;
        score.textColor = [UIColor whiteColor];
        score.text = @"同城排名:9";
        [cell addSubview:score];
       
        UILabel *score2 =  [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 15, 100, 20)];
        score2.textAlignment = NSTextAlignmentCenter;
        score2.font = [UIFont systemFontOfSize:14];
        score2.backgroundColor = R_G_B_COLOR(161, 169, 187);
        score2.textColor = [UIColor whiteColor];
        score2.layer.cornerRadius= 10;
        score2.layer.masksToBounds = YES;
        score2.text = @"全国排名:12";
        [cell addSubview:score2];
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        
    }else if (indexPath.row == 2){
        
        
        for (int i = 0; i < 6; i++) {
            
            UIImageView *mm = [[UIImageView alloc]initWithFrame:CGRectMake(80 + (i%3)*SCREEN_WIDTH/4, 10 + (i/3) * SCREEN_WIDTH/4, (SCREEN_WIDTH/4 - 10), (SCREEN_WIDTH/4-10))];
            mm.image = [UIImage imageNamed:@"demo"];
            [cell addSubview:mm];
            
        }
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 180);

        
    }else if (indexPath.row == 3){
        
        for (int i = 0; i < memberArray.count; i++) {
            
            UIImageView *mm = [[UIImageView alloc]initWithFrame:CGRectMake(70+ i * 30, 30, 28, 28)];
            [mm setImageWithURL:[NSURL URLWithString:[memberArray objectAtIndex:i]]];
            mm.layer.cornerRadius = 14;
            [cell addSubview:mm];
            
        }
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);

        
    }else if (indexPath.row == 4){
        
        
        UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 120, 15, 30, 30)];
        [head setImageWithURL:[NSURL URLWithString:userHead]];
        head.layer.cornerRadius = 15;
        [cell addSubview:head];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 15, 70, 30)];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentRight;
        label.text = userName;
        [cell addSubview:label];
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);

        
    }else if (indexPath.row == 5){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 10, 140, 30)];
        label.textAlignment = NSTextAlignmentRight;
        label.text = xuanyan;
        label.font = [UIFont systemFontOfSize:14];
        [cell addSubview:label];

        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);

    }else if (indexPath.row == 6){
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 10, 140, 30)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:14];
        label.text = shuoming;
        label.numberOfLines = 10;

        [cell addSubview:label];
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);

        
    }else if (indexPath.row == 7){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 150, 10, 140, 30)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:14];
        label.text = dateStr;
        [cell addSubview:label];
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);

        
        
    }else if (indexPath.row == 8){
        
        UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 60, 30)];
        sw.on = YES;
        [cell addSubview:sw];
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        
        JuKongViewController *kong = [[JuKongViewController alloc]init];
        
        kong.name = name;
        
        kong.idStr = idstr;

        [self.navigationController pushViewController:kong animated:YES];
        
    }
    
}






- (void)requestList{
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSLog(@"%@",sysString);
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"group",@"viewprofile",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:idstr forKey:@"gid"];
    
    
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
                                      
                                      NSLog(@"%@",dict);
#pragma mark 图片
                                      NSArray *imgArr = [dict objectForKey:@"images"];
                                      
                                      if (imgArr.count >= 1) {
                                          
                                          for (NSDictionary *imgDic in imgArr) {
                                              
                                              NSString *imgStr = [imgDic objectForKey:@"url"];
                                              
                                              [upImageArray addObject:imgStr];
                                              
                                          }
                                          
                                      }
                                      
                                      
                                      memberNum = [dict objectForKey:@"memberNum"];
                                      
                                      NSArray *meArray = [dict objectForKey:@"members"];
                                      
                                      for (NSDictionary *memDic in meArray) {
                                          
                                          NSString *memhead = [memDic objectForKey:@"avatar"];
                                          
                                          [memberArray addObject:memhead];
                                          
                                      }
                                      
                                      userHead = [dict objectForKey:@"founderAvatar"];
                                      
                                      userName = [dict objectForKey:@"founderNickName"];
                                      
                                      userId = [dict objectForKey:@"founderUid"];
                                      
//                                      dateStr = [dict objectForKey:@"createTime"];
                                      
                                      NSString *dateString = [[dict objectForKey:@"createTime"]stringByAppendingString:@"800"];
                                      NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                      NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                      [formatter1 setDateFormat:@"yyyy-MM-dd"];
                                      NSString *showtim = [formatter1 stringFromDate:newDate];
                                      dateStr = showtim;
                                      
                                      
                                      xuanyan = [dict objectForKey:@"announce"];
                                      
                                      shuoming = [dict objectForKey:@"area"];
                                      
                                      
                                      
                                      
                                      groupID = [dict objectForKey:@"easemobGroupId"];
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      [self creatTab];

                                      
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
