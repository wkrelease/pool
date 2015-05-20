//
//  MyDongTaiViewController.m
//  POOL
//
//  Created by king on 15/3/29.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MyDongTaiViewController.h"


#import "BianDongTaiViewController.h"

#import "DongTaiCell.h"

#import "DongTaiModel.h"

#import "WTRequestCenter.h"

@interface MyDongTaiViewController (){
    
    
}

@end

@implementation MyDongTaiViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    a = 1;
    
    self.myTitleLabel.text = @"我的动态";
    
    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray array];
    
    [self reqeustData];
    
    UIButton *bian = [UIButton buttonWithType:UIButtonTypeCustom];
    [bian setTitle:@"创建" forState:UIControlStateNormal];
    bian.titleLabel.font = [UIFont systemFontOfSize:14];
    bian.frame = CGRectMake(SCREEN_WIDTH - 50, 34, 40, 20);
    [bian addTarget:self action:@selector(bianClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:bian];
    
    
    
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        
        [self reloadFootDeals];
        
    };
    
    
    // Do any additional setup after loading the view.
}

- (void)bianClick{
    
    
    BianDongTaiViewController *bian = [[BianDongTaiViewController alloc]init];
    
    [self.navigationController pushViewController:bian animated:YES];
    
    
}



- (void)reqeustData{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"myfeed",@"list",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
      [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:[def objectForKey:HUAN_NAME] forKey:@"uid"];
    [parameters setValue:[NSString stringWithFormat:@"%d",a] forKey:@"startTime"];
    
    NSLog(@"%@",[def objectForKey:HUAN_NAME]);
    
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
                                  int aa = [state intValue];

                                  if (aa == 0) {
                                      
                                      
                                      NSDictionary *dict = [dic objectForKey:@"data"];
                                      
                                      NSArray *array = [dict objectForKey:@"feedList"];
                                      
                                      if (array.count >= 1) {
                                          
                                          
                                          for (NSDictionary *dataDic in array) {
                                              
                                              DongTaiModel *model = [[DongTaiModel alloc]init];
                                              
                                              model.feedIDStr = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"feedId"]];
                                              model.message = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"message"]];
                                              model.commentNum = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"commentNum"]];
                                              
                                              
                                              
                                              NSString *dateString = [[dataDic objectForKey:@"createTime"]stringByAppendingString:@"800"];
                                              NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                              NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                              [formatter1 setDateFormat:@"yyyy-MM-dd"];
                                              NSString *showtim = [formatter1 stringFromDate:newDate];
                                              model.dateStr = showtim;

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
                          
                          
                          
                          [self stopFoot];
                          [self stopRefresh];
                          
                          
                      }];
    

    
    
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 80;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    
    DongTaiCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        
        cell = [[DongTaiCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    
        
        
    }
    
    if (_dataArray.count >=1) {
        
        DongTaiModel *model = (DongTaiModel *)[_dataArray objectAtIndex:indexPath.row];
        
        cell.message.text = model.message;
        
        cell.time.text = model.dateStr;
        
        cell.ping.text = model.commentNum;
        
        
    }
    
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
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
        
        a = 1;
        
        [_dataArray removeAllObjects];
        
        [self reqeustData];
        
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
}


- (void)reloadFootDeals{
    
    
    if ([self isConnectionAvailable]) {
        
        a++;
        
        [_dataArray removeAllObjects];
        
        [self reqeustData];
        
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopFoot) withObject:nil afterDelay:1];
        
    }
    
    
}
- (void)stopFoot{
    
    [_footer endRefreshing];
    
}
- (void)stopRefresh{
    
    
    [_header endRefreshing];
    
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
