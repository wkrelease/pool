//
//  JuKongMessViewController.m
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuKongMessViewController.h"

#import "KongJianCell.h"

#import "KongJianModel.h"

#import "WTRequestCenter.h"


#import "JuLeBuDongTaiViewController.h"

@interface JuKongMessViewController (){
    
    
    UIImageView *DownView;
    
    UITextField *_messField;
    
}

@end

@implementation JuKongMessViewController

@synthesize name,idStr,groupID;


static BOOL isExistenceNetwork = YES;


- (void)doHid{
    
    [self.view endEditing:YES];
    
}

- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    
    [self showBack];
    
    
    self.myTitleLabel.text = name;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    
    UIImageView *upView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    _tableView.tableHeaderView = upView;
    
    _dataArray = [NSMutableArray array];
    
    
    [self requestKong];
    
    
    UITapGestureRecognizer *tabTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doHid)];
    [_tableView addGestureRecognizer:tabTap];
    
    
    
    
    DownView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    DownView.backgroundColor = [UIColor whiteColor];
    DownView.userInteractionEnabled = YES;
    [self.view addSubview:DownView];
    
    UIImageView *lin = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lin.backgroundColor = R_G_B_COLOR(221, 221, 221);
    [DownView addSubview:lin];
    
    _messField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 70, 30)];
    _messField.placeholder = @"写评论";
    _messField.borderStyle = 3;
    _messField.textColor = [UIColor grayColor];
    _messField.font = [UIFont systemFontOfSize:14];
    [DownView addSubview:_messField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 60, 10, 50, 30);
    [btn addTarget:self action:@selector(fasong) forControlEvents:UIControlEventTouchUpInside];
    [DownView addSubview:btn];
    
    
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];

    
    
    // Do any additional setup after loading the view.
}


- (void)keyboardWasHidden:(NSNotification *)not{
    
    
    DownView.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    
    
}



- (void)keyboardWillChangeFrame:(NSNotification *)not{
    
    NSLog(@"cccccccc");
    NSDictionary *userInfo = [not userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];//更改后的键盘
    
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    NSLog(@"%f",height);
    
    DownView.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - height, SCREEN_WIDTH, 50);
    
}




- (void)fasong{
    
    [self.view endEditing:YES];
    
    
    if (_messField.text.length < 1) {
      
        [MMProgressHUD showWithStatus:@"正在发送"];
        [MMProgressHUD dismissWithError:@"评论内容不能为空"];
        
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"groupSpaceComment",@"add",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:idStr forKey:@"feedId"];
    [parameters setValue:groupID forKey:@"gid"];
    [parameters setValue:_messField.text forKey:@"message"];
    
    
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
                                      
//                                      NSDictionary *dict = [dic objectForKey:@"data"];
//                                      
//                                      NSLog(@"%@",dict);
#pragma mark 图片
                                      
                                      
                                      [MMProgressHUD dismissWithSuccess:@"评论成功"];
                                      
                                      _messField.text = @"";
                                      [_dataArray removeAllObjects];
                                      [self requestKong];
                                      

                                      
                                      
                                  }else{
                                      
                                      
                                      NSString *mess = [dic objectForKey:@"msg"];

                                      
                                      NSLog(@"%@",mess);
                                      
                                      
                                      [MMProgressHUD dismissWithError:mess];
                                      
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




- (void)requestKong{
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"groupSpace",@"view",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:idStr forKey:@"feedId"];
    
    
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
                                      NSArray *arr = [dict objectForKey:@"commentList"];
                                      
                                      for (NSDictionary *comm in arr) {
                                          
                                          KongJianModel *model = [[KongJianModel alloc]init];
                                          
                                          
                                          
                                          model.headStr = [NSString stringWithFormat:@"%@",[comm objectForKey:@"avatar"]];
                                          
                                          model.nameStr = [NSString stringWithFormat:@"%@",[comm objectForKey:@"nickName"]];
                                          
                                          model.message = [NSString stringWithFormat:@"%@",[comm objectForKey:@"message"]];
                                          
                                          
                                          
                                          
                                          NSString *dateString = [[comm objectForKey:@"createTime"]stringByAppendingString:@"800"];
                                          NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                          NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                          [formatter1 setDateFormat:@"MM-dd"];
                                          NSString *showtim = [formatter1 stringFromDate:newDate];
                                          model.datestr = showtim;
                                          
//                                          model.datestr = [NSString stringWithFormat:@"%@",[comm objectForKey:@"createTime"]];
                                          
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
    
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    
    KongJianCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[KongJianCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    
    if (_dataArray.count>=1) {
        
        KongJianModel *model = (KongJianModel *)[_dataArray objectAtIndex:indexPath.row];
        
        [cell.head setImageWithURL:[NSURL URLWithString:model.headStr]];
        
        cell.name.text = model.nameStr;
        
        cell.message.text = model.message;
        
        cell.dateStr.text = model.datestr;
        
    }
    
   
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  
}










#pragma MARK refresh
-(BOOL) isConnectionAvailable{
    
    //    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
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
    
    if (isExistenceNetwork == YES) {
        
        [_dataArray removeAllObjects];
        [self requestKong];
        
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
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
