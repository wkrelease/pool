//
//  MeActivityViewController.m
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeActivityViewController.h"

#import "MyActivityCell.h"
#import "MyActivityModel.h"

#import "WTRequestCenter.h"

#import "ActivityMessageViewController.h"

@interface MeActivityViewController ()

@end

@implementation MeActivityViewController

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
    
    self.myTitleLabel.text = @"我的活动";
    
    [self showBack];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        
        [self reloadFootDeals];
        
    };
    UIButton *mo = [UIButton buttonWithType:UIButtonTypeCustom];
    mo.frame = CGRectMake(SCREEN_WIDTH - 80, 36, 70, 20);
    [mo setTitle:@"更多活动" forState:UIControlStateNormal];
    mo.titleLabel.font = [UIFont systemFontOfSize:14];
    [mo addTarget:self action:@selector(moreAct) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:mo];

    
    
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self requestAct];
    
    // Do any additional setup after loading the view.
}


- (void)moreAct{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"moreAct" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}






- (void)requestAct{
    
    
    if (a == -1) {
        
        [MMProgressHUD showWithStatus:@"正在刷新"];
        
        [MMProgressHUD dismissWithError:@"已无最新数据"];
        
        [self stopFoot];

        
        return;
    }
    
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"my",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    
    if (a == 1) {
        
    }else{
        
        [parameters setValue:[NSString stringWithFormat:@"%d",a] forKey:@"start"];

        
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
                                  int aa = [state intValue];
                                  NSLog(@"%d",aa);
                                  
                                  if (aa == 0) {
                                      
                                      NSDictionary *dict = [dic objectForKey:@"data"];
                                      

                                      
                                      NSArray *array = [dict objectForKey:@"list"];
                                      
                                      
                                      a = [[dict objectForKey:@"nextStart"] intValue];
                                      
                                      
                                      

                                      
                                      
                                      for (NSDictionary *diction in array) {
                                          
                                          MyActivityModel *model = [[MyActivityModel alloc]init];
                                          
                                          model.idStr = [diction objectForKey:@"activityId"];
                                          
                                          NSLog(@"%@",model.idStr);
                                          
                                          model.headStr = [diction objectForKey:@"image"];
                                          
                                          model.nameStr = [diction objectForKey:@"title"];
                                          
                                          NSString *dateString = [[diction objectForKey:@"startTime"]stringByAppendingString:@"800"];
                                          NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                          NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                          [formatter1 setDateFormat:@"yyyy-MM-dd"];
                                          NSString *showtim = [formatter1 stringFromDate:newDate];
                                          model.dateStr = showtim;
//                                          model.dateStr = [diction objectForKey:@"startTime"];
                                          
                                          model.stateStr = [diction objectForKey:@"status"];
                                          
                                          [_dataArray addObject:model];
                                          
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










#pragma mark tableviewdelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    MyActivityCell *cell= [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[MyActivityCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    if (_dataArray.count >= 1) {
        
        
        MyActivityModel *model = (MyActivityModel *)[_dataArray objectAtIndex:indexPath.row];
        
        [cell.headView setImageWithURL:[NSURL URLWithString:model.headStr]];
        
        cell.titelLabel.text = model.nameStr;
        
        cell.dateLabel.text = model.dateStr;
        
        if ([model.stateStr isEqualToString:@"0"]) {
            
            cell.stateLabel.text = @"未开始";
            cell.stateLabel.textColor = R_G_B_COLOR(45, 69, 130);

        }else if ([model.stateStr isEqualToString:@"1"]){
            
            cell.stateLabel.text = @"进行中";
            cell.stateLabel.textColor = R_G_B_COLOR(50, 219, 159);
            
        }else if ([model.stateStr isEqualToString:@"2"]){
            
            cell.stateLabel.text = @"已结束";
            cell.stateLabel.textColor = [UIColor grayColor];
            
        }
        
        
    }

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    MyActivityModel *model = (MyActivityModel *)[_dataArray objectAtIndex:indexPath.row];
    
    ActivityMessageViewController *mess = [[ActivityMessageViewController alloc]init];
    
    mess.actString = model.idStr;
    
    [self.navigationController pushViewController:mess animated:YES];
    
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
        
        [self requestAct];
        
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
}


- (void)reloadFootDeals{
    
    
    if ([self isConnectionAvailable]) {
        
        [self requestAct];
        
        
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
