//
//  PaiHangViewController.m
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "PaiHangViewController.h"
#import "OneCell.h"

#import "OneModel.h"

#import "TwoModel.h"

#import "ThreeModel.h"

#import "MemberViewController.h"

#import "WTRequestCenter.h"

@interface PaiHangViewController ()

@end

@implementation PaiHangViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}





-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    NSLog(@"Index %li", (long)Index);
    
    if (Index == 1) {
        
        if (!_twoTableView) {
            
            _twoTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scroll.frame.size.height) style:UITableViewStyleGrouped];
            _twoTableView.delegate = self;
            _twoTableView.dataSource = self;
            [scroll addSubview:_twoTableView];
            
            [self requestTwo];
            
        }
        
    }else if (Index == 2){
        
        
        if (!_threeTableView) {
            
            _threeTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, scroll.frame.size.height) style:UITableViewStyleGrouped];
            _threeTableView.delegate = self;
            _threeTableView.dataSource = self;
            [scroll addSubview:_threeTableView];
            
            [self requestThree];

            
        }
        

        
    }
    
    
    
    
    scroll.contentOffset = CGPointMake(Index * SCREEN_WIDTH, Y_OFF_SET);

    
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"朋友",@"TOP100",@"粉丝",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(50, 30, SCREEN_WIDTH - 100, 28);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"zyyy_choose_middle.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"zyyy_choose_middle_touch.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;//设置样式
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    segmentedControl.tintColor = [UIColor whiteColor];
    [self.navView addSubview:segmentedControl];
    
    
    [self createMyScroll];
    
    // Do any additional setup after loading the view.
}

- (void)createMyScroll{
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(X_OFF_SET, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - BAR_HEIGHT)];
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(SCREEN_WIDTH * 3, SCREEN_HEIGHT - NAV_HEIGHT - BAR_HEIGHT);
    scroll.pagingEnabled = YES;
    scroll.bounces = NO;
    scroll.scrollEnabled = NO;
    [self.view addSubview:scroll];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
    label.font = [UIFont systemFontOfSize:12];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"我当前排在第十位";
    label.textColor = [UIColor darkGrayColor];
    [scroll addSubview:label];
    
    _oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, scroll.frame.size.height-30) style:UITableViewStyleGrouped];
    _oneTableView.delegate = self;
    _oneTableView.dataSource = self;
    [scroll addSubview:_oneTableView];
    
    oneArray = [[NSMutableArray alloc]init];
    twoArray = [[NSMutableArray alloc]init];
    threeArray = [[NSMutableArray alloc]init];
//    
//    for (int i = 0; i < 10; i ++) {
//        
//        NSString *str = [NSString stringWithFormat:@"%d",i];
//        [oneArray addObject:str];
//        
//    }
    
    
    [self requestOne];
    
}


- (void)requestOne{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"rank",@"follow",sysString];
    
    
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
                                      
                                      NSArray *array = [dict objectForKey:@"list"];
                                      
                                      if (array.count >= 1) {
                                          
                                          for (NSDictionary *diction in array) {
                                              
                                              OneModel *model = [[OneModel alloc]init];
                                              
                                              model.age = [NSString stringWithFormat:@"%@",[diction objectForKey:@"age"]];
                                              
                                              model.avatar = [NSString stringWithFormat:@"%@",[diction objectForKey:@"avatar"]];
                                              
                                              model.bio = [NSString stringWithFormat:@"%@",[diction objectForKey:@"bio"]];
                                              
                                              model.constellation = [NSString stringWithFormat:@"%@",[diction objectForKey:@"constellation"]];
                                              
                                              model.distance = [NSString stringWithFormat:@"%@",[diction objectForKey:@"distance"]];
                                              
                                              model.evUpgrade = [NSString stringWithFormat:@"%@",[diction objectForKey:@"evUpgrade"]];
                                              
                                              model.gender = [NSString stringWithFormat:@"%@",[diction objectForKey:@"gender"]];
                                              
                                              model.lastActivity = [NSString stringWithFormat:@"%@",[diction objectForKey:@"lastActivity"]];
                                              
                                              model.nickName = [NSString stringWithFormat:@"%@",[diction objectForKey:@"nickName"]];
                                              
                                              model.payAmount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payAmount"]];
                                              
                                              model.payRole = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payRole"]];
                                              
                                              model.pkCredit = [NSString stringWithFormat:@"%@",[diction objectForKey:@"pkCredit"]];
                                              
                                              model.uid = [NSString stringWithFormat:@"%@",[diction objectForKey:@"uid"]];
                                              
                                              
                                              model.cityRank = [NSString stringWithFormat:@"%@",[diction objectForKey:@"cityRank"]];
                                              
                                              model.worldRank = [NSString stringWithFormat:@"%@",[diction objectForKey:@"worldRank"]];
                                              
                                              [oneArray addObject:model];
                                              
                                          }
                                          
                                      }
                                      
                                      
                                      [MMProgressHUD dismiss];
                                      

                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      
                                  }
                                  
                                  
                                  [_oneTableView reloadData];
                                  
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


- (void)requestTwo{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"rank",@"world",sysString];
    
    
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
                                      
                                      NSArray *array = [dict objectForKey:@"list"];
                                      
                                      if (array.count >= 1) {
                                          
                                          for (NSDictionary *diction in array) {
                                              
                                              TwoModel *model = [[TwoModel alloc]init];
                                              
                                              model.age = [NSString stringWithFormat:@"%@",[diction objectForKey:@"age"]];

                                              model.avatar = [NSString stringWithFormat:@"%@",[diction objectForKey:@"avatar"]];

                                              model.bio = [NSString stringWithFormat:@"%@",[diction objectForKey:@"bio"]];

                                              model.constellation = [NSString stringWithFormat:@"%@",[diction objectForKey:@"constellation"]];

                                              model.distance = [NSString stringWithFormat:@"%@",[diction objectForKey:@"distance"]];

                                              model.evUpgrade = [NSString stringWithFormat:@"%@",[diction objectForKey:@"evUpgrade"]];

                                              model.gender = [NSString stringWithFormat:@"%@",[diction objectForKey:@"gender"]];

                                              model.lastActivity = [NSString stringWithFormat:@"%@",[diction objectForKey:@"lastActivity"]];

                                              model.nickName = [NSString stringWithFormat:@"%@",[diction objectForKey:@"nickName"]];

                                              model.payAmount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payAmount"]];

                                              model.payRole = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payRole"]];

                                              model.pkCredit = [NSString stringWithFormat:@"%@",[diction objectForKey:@"pkCredit"]];

                                              model.uid = [NSString stringWithFormat:@"%@",[diction objectForKey:@"uid"]];

                                              
                                              
                                              model.cityRank = [NSString stringWithFormat:@"%@",[diction objectForKey:@"cityRank"]];
                                              
                                              model.worldRank = [NSString stringWithFormat:@"%@",[diction objectForKey:@"worldRank"]];
                                              
                                              [twoArray addObject:model];
                                              
                                          }
                                          
                                      }
                                      
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      
                                  }
                                  
                                  [_twoTableView reloadData];
                                  
                                  
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


- (void)requestThree{
    
    
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"follow",@"myFolloweds",sysString];
    
    
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
                                      
                                      if (array.count >= 1) {
                                          
                                          for (NSDictionary *diction in array) {
                                              
                                              ThreeModel *model = [[ThreeModel alloc]init];
                                              
                                              model.age = [NSString stringWithFormat:@"%@",[diction objectForKey:@"age"]];
                                              
                                              
                                              
                                              model.avatar = [NSString stringWithFormat:@"%@",[diction objectForKey:@"avatar"]];
                                              
                                              model.bio = [NSString stringWithFormat:@"%@",[diction objectForKey:@"bio"]];
                                              
                                              model.constellation = [NSString stringWithFormat:@"%@",[diction objectForKey:@"constellation"]];
                                              
                                              model.distance = [NSString stringWithFormat:@"%@",[diction objectForKey:@"distance"]];
                                              
                                              model.evUpgrade = [NSString stringWithFormat:@"%@",[diction objectForKey:@"evUpgrade"]];
                                              
                                              model.gender = [NSString stringWithFormat:@"%@",[diction objectForKey:@"gender"]];
                                              
                                              model.lastActivity = [NSString stringWithFormat:@"%@",[diction objectForKey:@"lastActivity"]];
                                              
                                              model.nickName = [NSString stringWithFormat:@"%@",[diction objectForKey:@"nickName"]];
                                              
                                              model.payAmount = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payAmount"]];
                                              
                                              model.payRole = [NSString stringWithFormat:@"%@",[diction objectForKey:@"payRole"]];
                                              
                                              model.pkCredit = [NSString stringWithFormat:@"%@",[diction objectForKey:@"pkCredit"]];
                                              
                                              model.uid = [NSString stringWithFormat:@"%@",[diction objectForKey:@"uid"]];
                                              
                                              
                                              model.cityRank = [NSString stringWithFormat:@"%@",[diction objectForKey:@"cityRank"]];
                                              
                                              model.worldRank = [NSString stringWithFormat:@"%@",[diction objectForKey:@"worldRank"]];

                                              
                                              [threeArray addObject:model];
                                              
                                          }
                                          
                                      }
                                      
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      
                                  }
                                  
                                  [_threeTableView reloadData];
                                  
                                  
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


















#pragma mark tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:_oneTableView]) {
        
        return oneArray.count;

    }else if ([tableView isEqual:_twoTableView]){
        
        return twoArray.count;

        
    }else{
        
        return threeArray.count;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_oneTableView]) {
        
        static NSString *myCell = @"cell";
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[OneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            
        }
        
        OneModel *model  = (OneModel *)[oneArray objectAtIndex:indexPath.row];
        
        [cell.headView setImageWithURL:[NSURL URLWithString:model.avatar]];
        
        cell.name.text = model.nickName;
        
        [cell.name sizeToFit];
        
        if ([model.gender isEqualToString:@"1"]) {
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_man"];
            
        }else{
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_woman"];
            
        }
        
        cell.ageLabel.text = [NSString stringWithFormat:@"%@岁",model.age];
        
        cell.message.text = model.constellation;
        
        cell.tong.text = [NSString stringWithFormat:@"同城排名:%@",model.cityRank];
        
        cell.quan.text = [NSString stringWithFormat:@"全国排名:%@",model.worldRank];
        
        cell.numLabel.text = [NSString stringWithFormat:@"NO.%ld",(long)indexPath.row + 1];
        
        cell.selectionStyle = 0;
        
        
        return cell;

        
    }else if ([tableView isEqual:_twoTableView]){
        
        static NSString *myCell = @"cell";
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[OneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            
        }
        
        
        TwoModel *model = (TwoModel *)[twoArray objectAtIndex:indexPath.row];
        
        [cell.headView setImageWithURL:[NSURL URLWithString:model.avatar]];
        
        cell.name.text = model.nickName;
        
        [cell.name sizeToFit];
        
        if ([model.gender isEqualToString:@"1"]) {
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_man"];
            
        }else{
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_woman"];

        }
        
        cell.ageLabel.text = [NSString stringWithFormat:@"%@岁",model.age];
        
        cell.message.text = model.constellation;
        
        cell.tong.text = [NSString stringWithFormat:@"同城排名:%@",model.cityRank];
        
        cell.tong.alpha = 0;
        
        cell.numLabel.text = [NSString stringWithFormat:@"NO.%ld",(long)indexPath.row + 1];
        
        cell.quan.text = [NSString stringWithFormat:@"全国排名:%@",model.worldRank];


        cell.quan.frame = cell.tong.frame;
        
        cell.selectionStyle = 0;
        return cell;

        
        
    }else{
        
        static NSString *myCell = @"cell";
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[OneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            
        }
        
        ThreeModel *model = (ThreeModel *)[threeArray objectAtIndex:indexPath.row];
        
        [cell.headView setImageWithURL:[NSURL URLWithString:model.avatar]];
        
        cell.name.text = model.nickName;
        
        [cell.name sizeToFit];
        
        if ([model.gender isEqualToString:@"1"]) {
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_man"];
            
        }else{
            
            cell.sexImage.image = [UIImage imageNamed:@"icon_sex_woman"];
            
        }
        
        cell.ageLabel.text = [NSString stringWithFormat:@"%@岁",model.age];
        
        cell.message.text = model.constellation;
        
        cell.tong.text = [NSString stringWithFormat:@"同城排名:%@",model.cityRank];
        
        cell.quan.text = [NSString stringWithFormat:@"全国排名:%@",model.worldRank];

        
        cell.tong.alpha = 0;
        
        cell.quan.alpha = 0;
        
        cell.selectionStyle = 0;
        
        
        cell.numLabel.text = [NSString stringWithFormat:@"NO.%ld",(long)indexPath.row + 1];

        return cell;

        
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld",indexPath.row);
    
    if ([tableView isEqual:_oneTableView]) {
        
        OneModel *model = (OneModel *)[oneArray objectAtIndex:indexPath.row];
        
        MemberViewController *mem = [[MemberViewController alloc]init];
        
        mem.name = model.nickName;
        
        mem.userIdStr = model.uid;
        
        [self.navigationController pushViewController:mem animated:YES];
        
        
    }else if ([tableView isEqual:_twoTableView]){
        
        TwoModel *model = (TwoModel *)[twoArray objectAtIndex:indexPath.row];
        
        MemberViewController *mem = [[MemberViewController alloc]init];
        
        mem.name = model.nickName;
        
        mem.userIdStr = model.uid;
        
        [self.navigationController pushViewController:mem animated:YES];
        

        
        
    }else if ([tableView isEqual:_threeTableView]){
        
        
        ThreeModel *model = (ThreeModel *)[threeArray objectAtIndex:indexPath.row];
        
        MemberViewController *mem = [[MemberViewController alloc]init];
        
        mem.name = model.nickName;
        
        mem.userIdStr = model.uid;
        
        [self.navigationController pushViewController:mem animated:YES];
        

    }
    
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
