//
//  ActivityViewController.m
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ActivityViewController.h"
#import "HuoDongJuHuiCell.h"
#import "HuoDongChangCell.h"


#import "HuoDongChangModel.h"
#import "HuoDongJuHuiModel.h"

#import "FaBuViewController.h"

#import "ActivityNewViewController.h"
#import "ActivityNewMessageViewController.h"

#import "ActivityMessageViewController.h"
#import "ChangMessageViewController.h"


#import "WTRequestCenter.h"



@interface ActivityViewController (){
    
    
    NSString *oneNext;
    
    NSString *twoNext;
    
}

@end

@implementation ActivityViewController

static long chang = -1;

static BOOL isExistenceNetwork = NO;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)refreshChang{
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSLog(@"%@",sysString);
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
    NSString *sigString = [NSString stringWithFormat:@"%@%@%@",@"list",@"activity",sysString];
    
    NSLog(@"%@",sigString);
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"venues",@"near",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:twoNext forKey:@"start"];
    
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
                                  
                                  NSLog(@"%@",dataDic);
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      NSArray *array = [dataDic objectForKey:@"list"];
                                      
                                      twoNext = [dataDic objectForKey:@"nextStart"];
                                      
                                      
                                      for (NSDictionary *diction in array) {
                                          
                                          HuoDongChangModel *model = [[HuoDongChangModel alloc]init];
                                          model.changIdStr = [NSString stringWithFormat:@"%@",[diction objectForKey:@"vId"]];
                                          model.name = [diction objectForKey:@"name"];
                                          model.imageStr = [diction objectForKey:@"logo"];
                                          model.price = [diction objectForKey:@"percapita"];
                                          model.address = [NSString stringWithFormat:@"%@km",[diction objectForKey:@"distance"]];
                                          NSArray *huo = [diction objectForKey:@"latestActivity"];
                                          for (NSDictionary *dicc in huo) {
                                              
                                              model.huodong = [dicc objectForKey:@"title"];
                                              
                                          }
                                          
                                          [_twoDataArray addObject:model];
                                          
                                      }
                                      
                                      [_twoTableView reloadData];
                                      
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
                          
                          
                          [self stopRefresh];
                          
                          [self stopFoot];
                          
                          
                      }];
    
  
    
}








-(void)segmentAction:(UISegmentedControl *)Seg{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    
    NSLog(@"Index %li", (long)Index);
    
    if (Index == 0) {
        
        currentPage = 1;
        
        
        tableScroll.contentOffset = CGPointMake(0, 0);
        rightBtn.alpha = 1;
        
        leftBtn.alpha = 1;
        
        beijing.alpha = 0;
        
    }else if (Index == 1){
        
        if (!_twoTableView) {
            
            _twoTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - BAR_HEIGHT) style:UITableViewStylePlain];
            _twoTableView.delegate= self;
            _twoTableView.dataSource = self;
            _twoTableView.backgroundColor = [UIColor clearColor];
            _twoTableView.separatorStyle = 0;
            [tableScroll addSubview:_twoTableView];
            

            _anoHeader = [MJRefreshHeaderView header];
            _anoHeader.scrollView = _twoTableView;
            _anoHeader.delegate = self;
            _anoFooter = [MJRefreshFooterView footer];
            _anoFooter.scrollView = _twoTableView;
            _anoFooter.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
                
                [self reloadFootDeals];
                
            };

            
            
            
            
            [self refreshChang];
            
        }
        
        tableScroll.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        rightBtn.alpha = 0;
        
        leftBtn.alpha = 0;
        
        beijing.alpha = 1;
        
        
        
        
        currentPage = 2;

    }
    
    
    
}

- (void)shaiHide{
    
    shaiView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 150);

    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.view.backgroundColor = DEFAULT_COLOR;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    oneNext = @"";
    
    twoNext = @"";
    
    
    currentPage = 1;
    
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"球友聚会",@"场馆活动",nil];
    //初始化UISegmentedControl
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(60, 30, SCREEN_WIDTH - 120, 28);
    segmentedControl.selectedSegmentIndex = 0;//设置默认选择项索引
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"zyyy_choose_middle.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"zyyy_choose_middle_touch.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;//设置样式
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    segmentedControl.tintColor = [UIColor whiteColor];
    [self.navView addSubview:segmentedControl];

    
    [self createTable];
    
    
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"  发布" forState:UIControlStateNormal];
    rightBtn.showsTouchWhenHighlighted  = YES;
    [rightBtn addTarget:self action:@selector(rightClicked) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 28, 40, 30);
    [self.navView addSubview:rightBtn];
    
    
    leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.showsTouchWhenHighlighted = YES;
    [leftBtn setImage:[UIImage imageNamed:@"nav_shaixuan"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    leftBtn.frame = CGRectMake(5, 30, 40, 25);
    [self.navView addSubview:leftBtn];

    
    // Do any additional setup after loading the view.

    beijing = [UIButton buttonWithType:UIButtonTypeCustom];
    [beijing setTitle:@"北京" forState:UIControlStateNormal];
    beijing.alpha = 0;
    beijing.titleLabel.font = [UIFont systemFontOfSize:12];
    [beijing addTarget:self action:@selector(beijingClick) forControlEvents:UIControlEventTouchUpInside];
    beijing.frame = CGRectMake(10, 34, 30, 20);
    [self.navView addSubview:beijing];

    
    
    [self location];
    
//    [self jingwei];

//    [self startActivity];
    
    
    shaiView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 150)];
    shaiView.backgroundColor = R_G_B_COLOR(234, 234, 234);
    shaiView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *shaiTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shaiHide)];
    [shaiView addGestureRecognizer:shaiTap];
    
    
    
    [self.view addSubview:shaiView];
    
    NSArray *array = [NSArray arrayWithObjects:@"活动日期",@"活动类型",nil];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 20 + idx * 40, 60, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13];
        label.text = obj;
        label.textColor = [UIColor grayColor];
        [shaiView addSubview:label];
        
        UIImageView *lin = [[UIImageView alloc]initWithFrame:CGRectMake(105, 40 + idx * 40, SCREEN_WIDTH - 140, 1)];
        lin.backgroundColor = [UIColor lightGrayColor];
        [shaiView addSubview:lin];
        
    }];
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 20, 150, 20)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.text = @"不限";
    dateLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateClick)];
    [dateLabel addGestureRecognizer:tap];
    dateLabel.font = [UIFont systemFontOfSize:13];
    [shaiView addSubview:dateLabel];
    
    classLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 60, 150, 20)];
    classLabel.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *clasTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clasClick)];
    [classLabel addGestureRecognizer:clasTap];
    classLabel.textColor = [UIColor grayColor];
    classLabel.userInteractionEnabled = YES;
    classLabel.text = @"不限";
    classLabel.font = [UIFont systemFontOfSize:13];
    [shaiView addSubview:classLabel];

    
    UIButton *shaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shaiBtn setTitle:@"筛选" forState:UIControlStateNormal];
    shaiBtn.backgroundColor = R_G_B_COLOR(45, 69, 130);
    shaiBtn.frame = CGRectMake(100, 100, SCREEN_WIDTH - 200,30);
    shaiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    [shaiBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [shaiBtn addTarget:self action:@selector(shaiXuan) forControlEvents:UIControlEventTouchUpInside];
    [shaiView addSubview:shaiBtn];
    
    
    
    
    dateStr = @"";
    classStr = @"";

    _dateArray = [NSMutableArray arrayWithObjects:@"今天",@"明天",@"后天",@"周六",@"周日", nil];
    _classArray = [NSMutableArray arrayWithObjects:@"台球",@"羽毛球",@"网球",@"乒乓球",@"Golf",@"足球",@"篮球",@"游泳",@"保龄",@"滑雪",@"射箭",@"骑马",@"户外",@"跑步",@"桌游",@"摄影",@"KTV",@"聚餐",@"培训", nil];
    
}

- (void)shaiXuan{
    
    
    NSLog(@"筛选");
    
    shaiView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 150);
    
    
    [_dataArray removeAllObjects];
    
    oneNext = @"";
    
    [self startActivity];
    
    
    
}




- (void)dateClick{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"不限" destructiveButtonTitle:nil otherButtonTitles:@"今天",@"明天",@"后天",@"周六",@"周日", nil];
    sheet.tag = 91;
    [sheet showInView:self.view];
}

- (void)clasClick{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"不限" destructiveButtonTitle:nil otherButtonTitles:@"台球",@"羽毛球",@"网球",@"乒乓球",@"Golf",@"足球",@"篮球",@"游泳",@"保龄",@"滑雪",@"射箭",@"骑马",@"户外",@"跑步",@"桌游",@"摄影",@"KTV",@"聚餐",@"培训", nil];
    sheet.tag = 92;
    [sheet showInView:self.view];

    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 91) {
        
        if (buttonIndex == _dateArray.count) {
            
            dateLabel.text = @"不限";
            
            dateStr = @"";
            
            
            currentDAY = (int)buttonIndex;
            
            
            return;
            
        }
        
        dateLabel.text = [_dateArray objectAtIndex:buttonIndex];
        
        currentDAY = (int)buttonIndex;
        
        
    }else if(actionSheet.tag == 92){
        
        if (buttonIndex == _classArray.count) {
            
            classLabel.text = @"不限";
            
            classStr = @"";
            
            return;
        }
        
        classLabel.text = [_classArray objectAtIndex:buttonIndex];
        
        classStr = [NSString stringWithFormat:@"%ld",(long)(buttonIndex + 1)];
        
        NSLog(@"%@",classStr);
        
    }
    
}





- (void)location{
    
    
    [MMProgressHUD showWithStatus:@"正在获取附近活动"];
    
    //定位
    
    if ([CLLocationManager locationServicesEnabled] == NO) {
        
        NSLog(@"没有GPS服务");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"没有GPS服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    }else{
        
        
        locationManager = [[CLLocationManager alloc] init];//初始化
        locationManager.delegate = self;//委托自己
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;//精度设定
        locationManager.distanceFilter = 1.0f;
        
        if (SYSTEM_VERSION > 7.0) {
            
            [locationManager requestAlwaysAuthorization];
            
        }else{
            
        }
        [locationManager startUpdatingLocation];//开启位置更新
        
        
    }

    
    
    
}


- (void)jingwei{
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];

    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d||",CURRENT_UUID,CURRENT_API,CURRENT_TIME];
    
    NSLog(@"%@",sysString);
    
    /******
     *a
     *c
     *sys
     ******
     */
    
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
    NSString *sigString = [NSString stringWithFormat:@"%@%@%@%@%@",@"location",@"member",latitudeStr,longitudeStr,sysString];
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@&lat=%@&lng=%@",DEBUG_HOST_URL,@"member",@"location",sysString,latitudeStr,longitudeStr];
    
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
                                      
                                      [self startActivity];
                                      
                                      
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


- (void)addActivity{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"list",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:[NSString stringWithFormat:@"%d",currentPage] forKey:@"start"];
    [parameters setValue:classStr forKey:@"category"];
    
    if (dateLabel != nil) {
        
        if (![dateLabel.text isEqualToString:@"不限"]) {
            
            NSDate *formDate = [NSDate date];
            long start = [formDate timeIntervalSince1970] + (currentDAY * 86400);
            long end = start + 86400;
            NSString *star = [NSString stringWithFormat:@"%ld",start];
            NSString *en = [NSString stringWithFormat:@"%ld",end];
            
            [parameters setValue:star forKey:@"startTime"];
            [parameters setValue:en forKey:@"endTime"];
        }
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
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                  
                                  NSDictionary *dataDic = [dic objectForKey:@"data"];
                                  NSArray *daArray = [dataDic objectForKey:@"list"];
                                  if (daArray.count >= 1) {
                                      
                                      for (NSDictionary *diction in daArray) {
                                          
                                          HuoDongJuHuiModel *model = [[HuoDongJuHuiModel alloc]init];
                                          model.modelIdStr = [diction objectForKey:@"activityId"];
                                          model.imageStr = [diction objectForKey:@"image"];
                                          
                                          model.titleStr = [diction objectForKey:@"title"];
                                          model.dateStr = [diction objectForKey:@"startTime"];
                                          model.addressStr = [NSString stringWithFormat:@"距离%@km",[diction objectForKey:@"distance"]];
                                          model.hotStr = [NSString stringWithFormat:@"热度%@/%@",[diction objectForKey:@"applyNum"],[diction objectForKey:@"maxNum"]];
                                          
                                          model.numState = [diction objectForKey:@"status"];
                                          
                                          NSString *str = [diction objectForKey:@"startTime"];
                                          NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
                                          NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                                          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                          
                                          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                          
                                          NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
                                          
                                          model.dateStr = currentDateStr;
                                          
                                          
                                          [_dataArray addObject:model];
                                          
                                      }
                                      
                                      [_tableView reloadData];
                                      
                                  }
                                  
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
                          
                          
                          
                          [self stopRefresh];
                          
                          [self stopFoot];
                          
                      }];
    
    
}


- (void)startActivity{
    
    
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
    

    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"list",sysString];

    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:oneNext forKey:@"start"];
    [parameters setValue:classStr forKey:@"category"];
    
    
    if (dateLabel != nil) {
        
        if (![dateLabel.text isEqualToString:@"不限"]) {
            
            NSDate *formDate = [NSDate date];
            long start = [formDate timeIntervalSince1970] + ((currentDAY-1) * 86400);
            long end = start + 86400;
            NSString *star = [NSString stringWithFormat:@"%ld",start];
            NSString *en = [NSString stringWithFormat:@"%ld",end];
            
            [parameters setValue:star forKey:@"startTime"];
            [parameters setValue:en forKey:@"endTime"];
        }
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
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                  
                                  NSDictionary *dataDic = [dic objectForKey:@"data"];
                                  NSArray *daArray = [dataDic objectForKey:@"list"];
                                  
                                  oneNext = [dataDic objectForKey:@"nextStart"];
                                  
                                  if (daArray.count >= 1) {
                                      
                                      for (NSDictionary *diction in daArray) {
                                          
                                          HuoDongJuHuiModel *model = [[HuoDongJuHuiModel alloc]init];
                                          model.modelIdStr = [diction objectForKey:@"activityId"];
                                          model.imageStr = [diction objectForKey:@"image"];

                                          model.titleStr = [diction objectForKey:@"title"];
                                          model.dateStr = [diction objectForKey:@"startTime"];
                                          model.addressStr = [NSString stringWithFormat:@"距离%@km",[diction objectForKey:@"distance"]];
                                          model.hotStr = [NSString stringWithFormat:@"热度%@/%@",[diction objectForKey:@"applyNum"],[diction objectForKey:@"maxNum"]];

                                          model.numState = [diction objectForKey:@"status"];
                                          
                                          
                                          NSString *str = [diction objectForKey:@"startTime"];
                                          NSTimeInterval time=[str doubleValue];
                                          NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                                          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

                                          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                          
                                          NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
                                          
                                          model.dateStr = currentDateStr;
                                          
                                          
                                         __block int a = 1;
                                          
                                          [_dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                             
                                              HuoDongJuHuiModel *oldModel = (HuoDongJuHuiModel *)obj;

                                              if ([model.modelIdStr isEqualToString:oldModel.modelIdStr]) {
                                                  
                                                  a = 2;
                                                  
                                                  *stop = YES;
                                                  
                                              }
                                            
                                          }];
                                          
                                          
                                          
                                          if (a == 1) {
                                              
                                              [_dataArray addObject:model];

                                          }
                                          
                                          
                                          
                                      }
                                      
                                      
                                  }
                                  
                                  if (a == 0) {
                                      
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






- (void)beijingClick{
    
    ActivityNewViewController *new = [[ActivityNewViewController alloc]init];
    [self.navigationController pushViewController:new animated:YES];
    
    
}

- (void)leftClick{
    
    NSLog(@"left");
    
    shaiView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 150);
    
    
}


- (void)rightClicked{
    
    NSLog(@"发布");
    FaBuViewController *fa = [[FaBuViewController alloc]init];
    [self.navigationController pushViewController:fa animated:YES];
    
}


- (void)createTable{
    
    
    tableScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - BAR_HEIGHT)];
    tableScroll.showsHorizontalScrollIndicator = NO;
    tableScroll.showsVerticalScrollIndicator = NO;
    tableScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT - NAV_HEIGHT - BAR_HEIGHT);
    tableScroll.pagingEnabled = YES;
    tableScroll.scrollEnabled = NO;
    [self.view addSubview:tableScroll];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(X_OFF_SET, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT - BAR_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate= self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = 0;
    [tableScroll addSubview:_tableView];
    
    
    self.view.backgroundColor = DEFAULT_COLOR;
    
    _dataArray = [[NSMutableArray alloc]init];
    _twoDataArray = [[NSMutableArray alloc]init];
    

    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _tableView;
    _footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
        
        [self reloadFootDeals];
        
    };
   
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
        
        //        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
        [self reloadDeals];
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
}
- (void)reloadDeals{
    
    if (isExistenceNetwork == YES) {
        
        if (currentPage == 1) {
           
            oneNext = @"";
            
            [_dataArray removeAllObjects];
            
            [self startActivity];

        }else{
            
            
            [_twoDataArray removeAllObjects];
            
            twoNext = @"";
            
            [self refreshChang];
            
        }
        
        
    }else{
        //如果没网1s后返回
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:1];
        
    }
    
    
}

- (void)reloadFootDeals{
    
    
//    currentPage ++;
//    
//    [self addActivity];
    
    if (currentPage == 1) {
        
        if ([oneNext isEqualToString:@"-1"]) {
            
            [MMProgressHUD showWithStatus:@"已无聚会数据"];
            
            [MMProgressHUD dismissWithError:@"已无聚会数据"];
            
            [self performSelector:@selector(stopFoot) withObject:nil afterDelay:1];

            
        }else{

            [self startActivity];

        }
        
        
    }else{
        
        if ([twoNext isEqualToString:@"-1"]) {
            
            [MMProgressHUD showWithStatus:@"已无场馆数据"];
            
            [MMProgressHUD dismissWithError:@"已无场馆数据"];
            
            [self performSelector:@selector(stopFoot) withObject:nil afterDelay:1];

            
        }else{
            
            [self refreshChang];

        }
        
        
        
    }
    
    

    
//    [self performSelector:@selector(stopFoot) withObject:nil afterDelay:1];
    
}
- (void)stopFoot{
    
    [_footer endRefreshing];
    [_anoFooter endRefreshing];
    
}
- (void)stopRefresh{
    
    [_header endRefreshing];
    [_anoHeader endRefreshing];
    
}

















#pragma mark tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView]) {
        
        return _dataArray.count;

        
    }else{
        
        return _twoDataArray.count;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
    
        return 100;

    }else{
        
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        
        static NSString *myCell = @"cell";
        HuoDongJuHuiCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[HuoDongJuHuiCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        }
        cell.selectionStyle = 0;
        
        if (_dataArray.count >=1) {
            
            HuoDongJuHuiModel *model =  (HuoDongJuHuiModel *)[_dataArray objectAtIndex:indexPath.row];
            [cell.headView setImageWithURL:[NSURL URLWithString:model.imageStr]placeholderImage:[UIImage imageNamed:@"icon_tx"]];
            
            if ([model.imageStr isEqualToString:@"(null)"]) {
                cell.headView.image = [UIImage imageNamed:@"icon_tx"];
            }
            if ([model.imageStr isKindOfClass:[NSNull class]]) {
                cell.headView.image = [UIImage imageNamed:@"icon_tx"];
            }
            
            cell.name.text = model.titleStr;
            cell.mess.text = model.dateStr;
            cell.address.text = model.hotStr;
            cell.numLabel.text = model.addressStr;
            
            if ([model.numState isEqualToString:@"0"]) {
            
                cell.stateImage.image = [UIImage imageNamed:@"pic_baoming"];
                
            }else if ([model.numState isEqualToString:@"1"]){
                
                cell.stateImage.image = [UIImage imageNamed:@"pic_jinxing"];
                
                
            }else if ([model.numState isEqualToString:@"2"]){
                
                cell.stateImage.image = [UIImage imageNamed:@"pic_jieshu"];
                
                
            }
            
            
        }
       
        
        
        return cell;
        
    }else{
        
        static NSString *myCell = @"cell";
        HuoDongChangCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[HuoDongChangCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        }
        cell.laView.alpha = 0;
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        cell.backView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 130);
        if (indexPath.row == chang) {
            
            cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200 + 40);
            cell.backView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 180+40);
            cell.laView.alpha = 1;

        }
        cell.selectionStyle = 0;
        cell.qiangBtn.tag = 100 + indexPath.row;
        [cell.qiangBtn addTarget:self action:@selector(qiangClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_twoDataArray.count > 0) {
            
            HuoDongChangModel *model = (HuoDongChangModel *)[_twoDataArray objectAtIndex:indexPath.row];
            
            cell.xinHuo.text = model.huodong;
            
            if (model.huodong.length < 1) {
                cell.xinHuo.text = @"无";
            }
            
            cell.name.text = model.name;
            
            cell.address.text = model.address;
            
            cell.hwoMuch.text = model.price;
            
            [cell.headView setImageWithURL:[NSURL URLWithString:model.imageStr]];
            
        }

        
        
        
        
        return cell;
        
    }
    
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%d",indexPath.row);
    
    
    
    if ([tableView isEqual:_twoTableView]) {
        
        HuoDongChangModel *model = (HuoDongChangModel *)[_twoDataArray objectAtIndex:indexPath.row];
        
        ChangMessageViewController *chang = [[ChangMessageViewController alloc]init];
        
        chang.changID = model.changIdStr;
        
        [self.navigationController pushViewController:chang animated:YES];

        
    }else{
        
        HuoDongJuHuiModel *model = (HuoDongJuHuiModel *)[_dataArray objectAtIndex:indexPath.row];

        
        ActivityMessageViewController *mess = [[ActivityMessageViewController alloc]init];
        mess.actString = model.modelIdStr;
        
        [mess callBackDelete:^{
           
            [self reloadDeals];
            
        }];
        
        [self.navigationController pushViewController:mess animated:YES];
        
    }
    

    
}

- (void)qiangClicked:(UIButton *)btn{
    
    NSLog(@"%ld",(long)btn.tag);
    
    if (btn.tag - 100 == chang) {
        
        chang = -1;
        [_twoTableView reloadData];
        
    }else{

        chang = btn.tag - 100;
        [_twoTableView reloadData];
        
    }
    
   
}




#pragma mark location


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    NSLog(@"a");
    
    NSLog(@"%u",status);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    checkinLocation = [locations lastObject];
    
    
    NSLog(@"%@",locations);
    
    NSLog(@"%@",checkinLocation);
    
    // CLLocation类是一个位置的一个类 里面有一个结构体
    
    double latitude =  checkinLocation.coordinate.latitude;
    
    double longitude = checkinLocation.coordinate.longitude;
    
    
    latitudeStr = [NSString stringWithFormat:@"%2f",latitude];
    
    longitudeStr = [NSString stringWithFormat:@"%2f",longitude];
    
    
    NSLog(@"%@====%@",latitudeStr,longitudeStr);
    
    [locationManager stopUpdatingLocation];
    
    [self jingwei];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:latitudeStr forKey:USER_LAT];
    [def setObject:longitudeStr forKey:USER_LONG];
    [def synchronize];
    
    
    
    [MMProgressHUD dismissWithSuccess:@"获取附近活动成功"];
    
}



@end
