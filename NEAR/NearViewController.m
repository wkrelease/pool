//
//  NearViewController.m
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "NearViewController.h"
#import "NearCell.h"
#import "NearModel.h"
#import "JuViewController.h"

#import "WTRequestCenter.h"

#import "MemberViewController.h"

@interface NearViewController (){
    
    BOOL isExistenceNetwork;
    
    NSString *next_start;
}

@end

@implementation NearViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"附近";
    
    self.view.backgroundColor = DEFAULT_COLOR;
    
    UIButton *fuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fuBtn setTitle:@"俱乐部" forState:UIControlStateNormal];
    fuBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    fuBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 34, 60, 20);
    [fuBtn addTarget:self action:@selector(juLeBu) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:fuBtn];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(X_OFF_SET, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        
        [self reloadFootDeals];
        
    };

    
    
    _dataArray = [[NSMutableArray alloc]init];
    
//    for (int i = 0; i < 10; i ++) {
//        
//        NSString *str = [NSString stringWithFormat:@"%d",i];
//        [_dataArray addObject:str];
//        
//    }
//    
    
    [self nearRequest];
    
    // Do any additional setup after loading the view.
}






-(BOOL) isConnectionAvailable{
    
    //    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            NSLog(@"3G");
            
            break;
    }
    
    return isExistenceNetwork;
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    
    if ([self isConnectionAvailable]) {
        
        [self reloadDeals];
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
}
- (void)reloadDeals{
    
    if (isExistenceNetwork == YES) {
        
        [_dataArray removeAllObjects];
        
        next_start = @"";
        
        [self nearRequest];
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
    
}

- (void)reloadFootDeals{
    
//    [self nearRequest];
    
    [self performSelector:@selector(stopFoot) withObject:nil afterDelay:1];

    
}
- (void)stopFoot{
    
    [_footer endRefreshing];
    
    
}
- (void)stopRefresh{
    
    [_header endRefreshing];
    
    
}









- (void)juLeBu{
    
    NSLog(@"俱乐部");
    
    JuViewController *ju = [[JuViewController alloc]init];
    [self.navigationController pushViewController:ju animated:YES];
    
}

#pragma mark tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    NearCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[NearCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        
    }
    
    if (_dataArray.count >= 1) {
        
        
        NearModel *model = (NearModel *)[_dataArray objectAtIndex:indexPath.row];
        
        [cell.headView setImageWithURL:[NSURL URLWithString:model.headStr]];
        
        cell.dateLabel.text = model.lastActivity;
        
        
        
        if (model.headStr.length < 1) {
            
            cell.headView.image  = [UIImage imageNamed:@"demo"];
            
        }
        
        cell.nameLabel.text = model.nickName;
        
        if ([model.gender isEqualToString:@"2"]) {
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_woman"];
            
        }else{
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_man"];
            
        }
        
        cell.ageLabel.text = model.ageStr;
        
        
        cell.message.text = model.conStr;
        
        
        cell.address.text = [NSString stringWithFormat:@"距离%@km",model.distance];
        
        
        if ([model.payRole isEqualToString:@"1"]) {
            
            cell.paiLabel.text = @"裁判";
            
        }else if ([model.payRole isEqualToString:@"2"]){
            
            cell.paiLabel.text = @"教练";
            
        }else if ([model.payRole isEqualToString:@"3"]){
            
            cell.paiLabel.text = @"陪练";
            
            
        }else if ([model.payRole isEqualToString:@"4"]){
            cell.paiLabel.text = @"PK";
            
            
        }else{
            
            cell.paiLabel.text = @"";
            
        }
        
        if ([model.evUpgrade isEqualToString:@"1"]) {
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_1"];
            
        }else if ([model.evUpgrade isEqualToString:@"2"]){
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_2"];
            
        }else if ([model.evUpgrade isEqualToString:@"3"]){
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_3"];
            
        }else if ([model.evUpgrade isEqualToString:@"4"]){
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_4"];
            
        }else if ([model.evUpgrade isEqualToString:@"5"]){
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_5"];
            
        }else if ([model.evUpgrade isEqualToString:@"6"]){
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_6"];
            
        }else if ([model.evUpgrade isEqualToString:@"7"]){
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_7"];
            
        }else if ([model.evUpgrade isEqualToString:@"8"]){
            
            cell.twoImage.image = [UIImage imageNamed:@"icon_billiards_8"];
            
            
        }
        
        
        cell.message.text = model.bioStr;
        
    }

    
    cell.selectionStyle = 0;

    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld",indexPath.row);
    
    NearModel *model = (NearModel *)[_dataArray objectAtIndex:indexPath.row];
    
    MemberViewController *mem = [[MemberViewController alloc]init];
    
    mem.userIdStr = model.idStr;
    
    mem.name = model.nickName;
    
    [self.navigationController pushViewController:mem animated:YES];
    
    
}



- (void)nearRequest{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"member",@"nearUser",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [parameters setValue:sigString forKey:@"sig"];
    
    
    
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
                                      
                                      NSArray *array = [dict objectForKey:@"userList"];
                                      
                                      next_start = [dict objectForKey:@"nextStart"];
                                      
                                      if (array.count >= 1) {
                                          
                                          for (NSDictionary *diction in array) {
                                              
                                              NearModel *model = [[NearModel alloc]init];
                                              model.idStr = [NSString stringWithFormat:@"%@",[diction objectForKey:@"uid"]];
                                              model.headStr = [NSString stringWithFormat:@"%@",[diction objectForKey:@"avatar"]];
                                              model.ageStr = [NSString stringWithFormat:@"%@",[diction objectForKey:@"age"]];
                                              model.bioStr = [NSString stringWithFormat:@"%@",[diction objectForKey:@"bio"]];
                                              model.conStr = [NSString stringWithFormat:@"%@",[diction objectForKey:@"constellation"]];
                                              model.distance = [NSString stringWithFormat:@"%@",[diction objectForKey:@"distance"]];
                                              model.evUpgrade = [NSString stringWithFormat:@"%@",[diction objectForKey:@"evUpgrade"]];
                                              model.gender = [NSString stringWithFormat:@"%@",[diction objectForKey:@"gender"]];
                                              
                                              
                                              
//                                              model.lastActivity = [NSString stringWithFormat:@"%@",[diction objectForKey:@"lastActivity"]];
                                              
                                              NSString *dateString = [[diction objectForKey:@"lastActivity"]stringByAppendingString:@"800"];
                                              NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                              NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                              [formatter1 setDateFormat:@"yyyy-MM-dd"];
                                              NSString *showtim = [formatter1 stringFromDate:newDate];
                                              model.lastActivity = showtim;
                                              

                                              
                                              
                                              model.nickName = [NSString stringWithFormat:@"%@",[diction objectForKey:@"nickName"]];
                                              model.payAmount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payAmount"]];
                                              model.payRole = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payRole"]];
                                              model.pkCredit = [NSString stringWithFormat:@"%@",[diction objectForKey:@"pkCredit"]];
                                              
                                              [_dataArray addObject:model];
                                              
                                          }
                                          
                                      }
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      
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
                          
                          
                          [self stopRefresh];
                          
                          [self stopFoot];
                          
                      }];
    
    
    

    
    
}



- (void)jingwei{
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d||",CURRENT_UUID,CURRENT_API,CURRENT_TIME];
    
    NSLog(@"%@",sysString);
    
    /******
     *a
     *c
     *sys
     ******
     */
    
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
    NSString *sigString = [NSString stringWithFormat:@"%@%@%@%@%@",@"location",@"member",[def objectForKey:USER_LAT],[def objectForKey:USER_LONG],sysString];
    
    NSLog(@"%@",sigString);
    
    //    sigString = @"sendSmsmember15555555555F44ADF05-F827-4E85-B48A-036F4A297D5D|1|1423635492||";
    
    
    sigString = [[NSString stringWithFormat:@"%@%d%@",sigString,CURRENT_TIME,CURRENT_SIGN_KEY]MD5Hash];
    
    NSLog(@"one=============%@",sigString);
    
    sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
    
    
    NSLog(@"two=============%@",sigString);
    
    //    sigString = [[NSString stringWithFormat:@"%@%@%@",sigString,@"1423635492",CURRENT_SIGN_KEY]MD5Hash];
    //    NSLog(@"%@",sigString);
    //    sigString = [[NSString stringWithFormat:@"%@%@",sigString,@"1423635492"]MD5Hash];
    
    NSLog(@"%@",sigString);
    
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?c=%@&a=%@&sig=%@&sys=%@",DEBUG_HOST_URL,@"member",@"sendSms",sigString,sysString]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@&lat=%@&lng=%@",DEBUG_HOST_URL,@"member",@"location",sysString,[def objectForKey:USER_LAT],[def objectForKey:USER_LONG]];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?sig=%@",DEBUG_HOST_URL,sigString]];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    
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
                                  NSLog(@"%@",[dic objectForKey:@"data"]);
                                  
                                  if (a == 0) {
                                      
                                      [self nearRequest];
                                      
                                      
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
