//
//  MeAboutViewController.m
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeAboutViewController.h"

#import "MeAboutCell.h"

#import "MeAboutModel.h"

#import "WTRequestCenter.h"

@interface MeAboutViewController ()

@end

@implementation MeAboutViewController

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
    
    self.myTitleLabel.text = @"与我相关";
    
    [self showBack];

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
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

    
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self requestmydata];
    
    // Do any additional setup after loading the view.
}


- (void)requestmydata{
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"update",@"info",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
//    [parameters setValue:@"100" forKey:@"seq"];
    
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
                                  int aa = [state intValue];
                                  
                                  if (aa == 0) {
                                      
                                      NSDictionary *dict = [dic objectForKey:@"data"];
                                      
                                      NSArray *array = [dict objectForKey:@"list"];
                                      
                                      if (array.count >= 1) {
                                          
                                          
                                          for (NSDictionary *diction in array) {
                                              
                                              MeAboutModel *model = [[MeAboutModel alloc]init];
                                              
                                              model.age = [NSString stringWithFormat:@"%@",[diction objectForKey:@"age"]];

                                              model.avatar = [NSString stringWithFormat:@"%@",[diction objectForKey:@"avatar"]];

                                              model.cId = [NSString stringWithFormat:@"%@",[diction objectForKey:@"cId"]];

                                              model.constellation = [NSString stringWithFormat:@"%@",[diction objectForKey:@"constellation"]];

                                              
                                              
                                              
                                              NSString *dateString = [[diction objectForKey:@"createTime"]stringByAppendingString:@"800"];
                                              NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                              NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                              [formatter1 setDateFormat:@"MM-dd"];
                                              NSString *showtim = [formatter1 stringFromDate:newDate];
                                              model.createTime = showtim;
                                              
//                                              model.createTime = [NSString stringWithFormat:@"%@",[diction objectForKey:@"createTime"]];

                                              model.evUpgrade = [NSString stringWithFormat:@"%@",[diction objectForKey:@"evUpgrade"]];

                                              model.feedId = [NSString stringWithFormat:@"%@",[diction objectForKey:@"feedId"]];

                                              model.feedMessage = [NSString stringWithFormat:@"%@",[diction objectForKey:@"feedMessage"]];

                                              model.gender = [NSString stringWithFormat:@"%@",[diction objectForKey:@"gender"]];

                                              model.infotype = [NSString stringWithFormat:@"%@",[diction objectForKey:@"infotype"]];

                                              model.pkCredit = [NSString stringWithFormat:@"%@",[diction objectForKey:@"pkCredit"]];

                                              model.seq = [NSString stringWithFormat:@"%@",[diction objectForKey:@"seq"]];

                                              model.uid = [NSString stringWithFormat:@"%@",[diction objectForKey:@"uid"]];

                                              NSArray *array = [diction objectForKey:@"feedImage"];
                                              
                                              if (array.count >= 1) {
                                                  
                                                  [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                     
                                                      if (idx == 0) {
                                                          model.ongImageStr = obj;
                                                      }else if (idx == 1){
                                                          model.twoImageStr = obj;
                                                      }else if (idx == 2){
                                                          model.threeImageStr = obj;
                                                      }
                                                      
                                                  }];
                                                  
                                              }
                                              
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











#pragma mark tableviewDelegate 
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
    
    NSString *myCell = @"cell";
    MeAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[MeAboutCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    if (_dataArray.count >= 1) {
        
        
        MeAboutModel *model = (MeAboutModel *)[_dataArray objectAtIndex:indexPath.row];
        
        [cell.headView setImageWithURL:[NSURL URLWithString:model.avatar]];
        
        cell.nameLabel.text = model.nickName;
        
        cell.dateLabel.text = model.createTime;
        
        cell.messageLabel.text = model.message;
        
        cell.numPing.text = @"";
        
        if (model.ongImageStr.length > 1) {
            
            
            cell.oneImage.alpha = 1;
            cell.twoImage.alpha = 1;
            cell.threeImage.alpha = 1;
            
            cell.messageLabel.frame = CGRectMake(80, 90, SCREEN_WIDTH - 100, 40);
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
            
            [cell.oneImage setImageWithURL:[NSURL URLWithString:model.ongImageStr]];
            [cell.twoImage setImageWithURL:[NSURL URLWithString:model.twoImageStr]];
            [cell.threeImage setImageWithURL:[NSURL URLWithString:model.threeImageStr]];
            
            
            
        }else{
            

            cell.messageLabel.frame = CGRectMake(80, 20, SCREEN_WIDTH - 100, 40);
            
            cell.oneImage.alpha = 0;
            cell.twoImage.alpha = 0;
            cell.threeImage.alpha = 0;
            
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
            

        }
        
        
        
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
        
        [self requestmydata];
        
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
}


- (void)reloadFootDeals{
    
    
    if ([self isConnectionAvailable]) {
        
        a++;
        
        [_dataArray removeAllObjects];
        
        [self requestmydata];
        
        
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
