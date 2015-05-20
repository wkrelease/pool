//
//  MeJuLeBuViewController.m
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeJuLeBuViewController.h"

#import "JuCell.h"

#import "JuModel.h"

#import "WTRequestCenter.h"


#import "JuMessViewController.h"


@interface MeJuLeBuViewController ()

@end

@implementation MeJuLeBuViewController

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
    
    self.myTitleLabel.text = @"我的俱乐部";
    
    [self showBack];

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(X_OFF_SET, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate= self;
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
    
    
    
    self.view.backgroundColor = DEFAULT_COLOR;
    
    _dataArray = [[NSMutableArray alloc]init];
    
    
    
    [self requestJuLeBu];

    
    // Do any additional setup after loading the view.
}


- (void)requestJuLeBu{
    
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"group",@"near",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:[NSString stringWithFormat:@"%d",a] forKey:@"start"];
    
    
    
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
                                      
                                      NSLog(@"%@",dict);
                                      
                                      NSArray *array = [dict objectForKey:@"groupList"];
                                      
                                      if (array.count >= 1) {
                                          
                                          for (NSDictionary *diction in array) {
                                              
                                              JuModel *model = [[JuModel alloc]init];
                                              
                                              model.category = [NSString stringWithFormat:@"%@",[diction objectForKey:@"category"]];
                                              
                                              model.distance = [NSString stringWithFormat:@"%@",[diction objectForKey:@"distance"]];
                                              
                                              model.easemobGroupId = [NSString stringWithFormat:@"%@",[diction objectForKey:@"easemobGroupId"]];
                                              
                                              model.gid = [NSString stringWithFormat:@"%@",[diction objectForKey:@"gid"]];
                                              
                                              model.logo = [NSString stringWithFormat:@"%@",[diction objectForKey:@"logo"]];
                                              
                                              model.name = [NSString stringWithFormat:@"%@",[diction objectForKey:@"name"]];
                                              
                                              model.nameCityCode = [NSString stringWithFormat:@"%@",[diction objectForKey:@"nameCityCode"]];
                                              
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

















#pragma mark tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    JuCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[JuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    cell.selectionStyle = 0;
    
    if (_dataArray.count >= 1) {
        
        JuModel *model = (JuModel *)[_dataArray objectAtIndex:indexPath.row];
        
        [cell.headView setImageWithURL:[NSURL URLWithString:model.logo]];
        
        cell.name.text = model.name;
        
        cell.address.text = [NSString stringWithFormat:@"距离%@km",model.distance];
        
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld",indexPath.row);
    
    JuModel *model = (JuModel *)[_dataArray objectAtIndex:indexPath.row];
    
    
    
    JuMessViewController *mess = [[JuMessViewController alloc]init];
    
    mess.idstr = model.gid;
    
    mess.name = model.name;
    
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
        
        [self requestJuLeBu];
        
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
}


- (void)reloadFootDeals{
    
    
    if ([self isConnectionAvailable]) {
        
        a++;
        
        [_dataArray removeAllObjects];
        
        [self requestJuLeBu];
        
        
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
