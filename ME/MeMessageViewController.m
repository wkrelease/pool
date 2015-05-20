//
//  MeMessageViewController.m
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeMessageViewController.h"

#import "WTRequestCenter.h"

#import "MyDongTaiViewController.h"

#import "ChangeMyMessageVC.h"

@interface MeMessageViewController (){
    
    
    UILabel *indexOne;
    UILabel *indexTwo;
    UILabel *indexThree;
    UILabel *indexFour;
    UILabel *indexFive;
    UILabel *indexSix;
    
}

@end

@implementation MeMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)bianji{
    
    NSLog(@"编辑");
    
    ChangeMyMessageVC *vc = [[ChangeMyMessageVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"我的资料";
    
    [self showBack];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"情感状态",@"公司",@"家乡",@"职业",@"身份",@"爱好",@"个人动态", nil];

    [self createHead];
    
    
    UIButton *rigBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rigBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 34, 50, 20);
    [rigBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rigBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rigBtn addTarget:self action:@selector(bianji) forControlEvents:UIControlEventTouchUpInside];
    rigBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.navView addSubview:rigBtn];
    
    
//    [self message];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)createHead{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    headView.backgroundColor = [UIColor lightGrayColor];
    _tableView.tableHeaderView = headView;
    
    
    UIImageView *myHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [myHead setImageWithURL:[NSURL URLWithString:[def objectForKey:MY_INFO_HEADER]]];
    myHead.contentMode = UIViewContentModeScaleAspectFill;
    myHead.clipsToBounds= YES;
    [headView addSubview:myHead];
    
    UILabel *name= [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 40, 15)];
    name.font = [UIFont systemFontOfSize:13];
    name.textColor = [UIColor whiteColor];
    name.text = [def objectForKey:MY_INFO_NAME];
    [headView addSubview:name];
//    
//    UILabel *zuo = [[UILabel alloc]initWithFrame:CGRectMake(70, 40, 60, 15)];
//    zuo.text = @"金牛座";
//    zuo.textColor = [UIColor whiteColor];
//    zuo.font = [UIFont systemFontOfSize:12];
//    [headView addSubview:zuo];
    
    UILabel *qianming = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 20, 40)];
    qianming.text = [def objectForKey:MY_INFO_BIO];
    qianming.textColor = [UIColor whiteColor];
    qianming.numberOfLines = 3;
    qianming.font = [UIFont systemFontOfSize:12];
    [headView addSubview:qianming];
    
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *pk = [[UILabel alloc]initWithFrame:CGRectMake(20 + i * 100, 120, 90, 16)];
        pk.backgroundColor = R_G_B_COLOR(246, 137, 83);
        pk.layer.cornerRadius = 8;
        pk.layer.masksToBounds = YES;
        pk.text = @"pk积分:115";
        pk.textAlignment = NSTextAlignmentCenter;
        pk.font = [UIFont systemFontOfSize:12];
        pk.textColor = [UIColor whiteColor];
        [headView addSubview:pk];
        if (i == 1) {
            
            pk.backgroundColor = R_G_B_COLOR(80, 149, 237);
            pk.text = @"同城排名:99";

            
        }else if (i == 2){
            
            pk.backgroundColor = R_G_B_COLOR(47, 203, 148);
            pk.text = @"全国排名:999";
        }
        
    }
    
    
    indexOne = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 130, NAV_HEIGHT + 150, 100, 20)];
    indexOne.backgroundColor = [UIColor clearColor];
    indexOne.textColor = [UIColor grayColor];
    indexOne.font  =[UIFont systemFontOfSize:14];
    indexOne.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:indexOne];
    
    indexTwo = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 130, NAV_HEIGHT + 200, 100, 20)];
    indexTwo.backgroundColor = [UIColor clearColor];
    indexTwo.textColor = [UIColor grayColor];
    indexTwo.font  =[UIFont systemFontOfSize:14];
    indexTwo.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:indexTwo];
   
    
    indexThree = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 130, NAV_HEIGHT + 250, 100, 20)];
    indexThree.backgroundColor = [UIColor clearColor];
    indexThree.textColor = [UIColor grayColor];
    indexThree.font  =[UIFont systemFontOfSize:14];
    indexThree.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:indexThree];
  
    
    indexFour = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 130, NAV_HEIGHT + 300, 100, 20)];
    indexFour.backgroundColor = [UIColor clearColor];
    indexFour.textColor = [UIColor grayColor];
    indexFour.font  =[UIFont systemFontOfSize:14];
    indexFour.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:indexFour];
    
    
    indexFive = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 130, NAV_HEIGHT + 350, 100, 20)];
    indexFive.backgroundColor = [UIColor clearColor];
    indexFive.textColor = [UIColor grayColor];
    indexFive.font  =[UIFont systemFontOfSize:14];
    indexFive.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:indexFive];
    
    
    indexSix = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 130, NAV_HEIGHT + 400, 100, 20)];
    indexSix.backgroundColor = [UIColor clearColor];
    indexSix.textColor = [UIColor grayColor];
    indexSix.font  =[UIFont systemFontOfSize:14];
    indexSix.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:indexSix];
    
    
    
  
    indexOne.text = [def objectForKey:MY_INFO_affectiveStatus];
    indexTwo.text = [def objectForKey:MY_INFO_company];
    indexThree.text = [def objectForKey:MY_INFO_hometown];
    indexFour.text = [def objectForKey:MY_INFO_occupation];
    indexFive.text = [def objectForKey:MY_INFO_payRole];
//    indexSix.text = [def objectForKey:MY_INFO_interest];

  
}








#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        
    }
    
    cell.accessoryType = 1;
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if (indexPath.row == 6) {
        
        MyDongTaiViewController *tai = [[MyDongTaiViewController alloc]init];
        [self.navigationController pushViewController:tai animated:YES];
        
    }
    
    
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
    [parameters setValue:@"42" forKey:@"uid"];
    
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
                                  
                                  
                                  
                                  
                                  NSString *seven = currentDateStr;
                                  
                                  
                                  
                                  
                                  
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
