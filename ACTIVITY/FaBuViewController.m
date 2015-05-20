//
//  FaBuViewController.m
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "FaBuViewController.h"

#import "ActivityZhuTiViewController.h"

#import "ActivityBiaoViewController.h"

#import "XianZhiViewController.h"

#import "faBuCell.h"

#import "JuAddressViewController.h"

#import "FeiYongViewController.h"


#import "WTRequestCenter.h"


@interface FaBuViewController (){
    
    UITextField *addressField;
    
    
    NSMutableArray *AIDArray;
    
    int requestTag;
    
    NSString *biaoString;
    
}

@end

@implementation FaBuViewController

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
    
    self.myTitleLabel.text = @"发布活动";
    
    requestTag = 0;

    
    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = CLEARCOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"",@"",@"", nil];
    
    _photoArray = [NSMutableArray array];
    
    AIDArray = [NSMutableArray array];
    
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    headView.userInteractionEnabled = YES;
    
    photoTable = [[UITableView alloc]initWithFrame:CGRectMake(120, -115, 80, SCREEN_WIDTH)style:UITableViewStylePlain];
    photoTable.backgroundColor = [UIColor whiteColor];
    photoTable.showsVerticalScrollIndicator = NO;
    photoTable.showsHorizontalScrollIndicator = NO;
    photoTable.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    photoTable.separatorStyle = 0;
    photoTable.delegate = self;
    photoTable.dataSource = self;
    [headView addSubview:photoTable];

    _tableView.tableHeaderView = headView;
    
    
    UIImageView *addView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 75)];
    addView.backgroundColor = [UIColor clearColor];
    //    addView.layer.borderWidth = 0.5;
    //    addView.layer.borderColor = R_G_B_COLOR(255, 174, 124).CGColor;
    addView.image = [UIImage imageNamed:@"icon_photo"];
    addView.transform = CGAffineTransformMakeRotation(M_PI / 2);

    photoTable.tableFooterView = addView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImage)];
    addView.userInteractionEnabled = YES;
    [addView addGestureRecognizer:tap];

    
    UIImageView *downView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    downView.backgroundColor = [UIColor clearColor];
    downView.userInteractionEnabled = YES;
    _tableView.tableFooterView = downView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 40);
    btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:btn];
    
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 115, 200, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:titleLabel];
    
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 115 + 50, 200, 20)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.font = [UIFont systemFontOfSize:14];
    dateLabel.textColor = [UIColor grayColor];
    dateLabel.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:dateLabel];
    
    biaoLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 115 + 100, 200, 20)];
    biaoLable.backgroundColor = [UIColor clearColor];
    biaoLable.font = [UIFont systemFontOfSize:14];
    biaoLable.textColor = [UIColor grayColor];
    biaoLable.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:biaoLable];
    
    addressLabel = [[UITextField alloc]initWithFrame:CGRectMake(100, 115 + 170, 180, 20)];
    addressLabel.backgroundColor = [UIColor redColor];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:addressLabel];
    
    UIButton *addreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addreBtn.backgroundColor = [UIColor cyanColor];
    [addreBtn addTarget:self action:@selector(address) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:addreBtn];
    
    
    
    priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 115 + 220, 200, 20)];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor grayColor];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:priceLabel];
   
    
    peopleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 115 + 270, 200, 20)];
    peopleLabel.backgroundColor = [UIColor clearColor];
    peopleLabel.font = [UIFont systemFontOfSize:14];
    peopleLabel.textColor = [UIColor grayColor];
    peopleLabel.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:peopleLabel];
    
    yaoQiuLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 115 + 410, 200, 20)];
    yaoQiuLabel.backgroundColor = [UIColor clearColor];
    yaoQiuLabel.font = [UIFont systemFontOfSize:14];
    yaoQiuLabel.textColor = [UIColor grayColor];
    yaoQiuLabel.textAlignment = NSTextAlignmentRight;
    [_tableView addSubview:yaoQiuLabel];
    
    
    
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasShow:) name:UIKeyboardWillShowNotification object:nil];

    
    
    
    
    backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    backView.userInteractionEnabled = YES;
    [self.view addSubview:backView];
    
    
    UIImageView *piView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250)];
    piView.tag = 1945;
    piView.backgroundColor = R_G_B_COLOR(239, 239, 239);
    piView.userInteractionEnabled=  YES;
    UIDatePicker *pi= [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, 0, 0)];
    pi.datePickerMode = UIDatePickerModeDateAndTime;
    [pi addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    [piView addSubview:pi];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    pi.locale = locale;
    [self.view addSubview:piView];
    
    UIImageView *piLi = [[UIImageView alloc]initWithFrame:CGRectMake(X_OFF_SET, 40, SCREEN_WIDTH, 1)];
    piLi.backgroundColor = [UIColor whiteColor];
    [piView addSubview:piLi];
    
    NSArray *picArr= [NSArray arrayWithObjects:@"取消",@"确定", nil];
    [picArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.frame = CGRectMake(10 + idx*(SCREEN_WIDTH - 70), 5 , 50, 30);
        btn.tag = 1940+idx;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
        [piView addSubview:btn];
        
    }];
    
    
    
    
    sw = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 450, 50, 30)];
    sw.on = YES;
    [_tableView addSubview:sw];

    
    tv = [[UITextView alloc]initWithFrame:CGRectMake(80, 520, SCREEN_WIDTH - 90, 60)];
    tv.backgroundColor = [UIColor clearColor];
    tv.font = [UIFont systemFontOfSize:14];
    tv.returnKeyType = UIReturnKeyDone;
    [_tableView addSubview:tv];

    
    shuoming = [[UITextView alloc]initWithFrame:CGRectMake(80, 620, SCREEN_WIDTH - 90, 130)];
    shuoming.backgroundColor = [UIColor clearColor];
    shuoming.font = [UIFont systemFontOfSize:14];
    shuoming.returnKeyType = UIReturnKeyDone;
    [_tableView addSubview:shuoming];
    
    
    
    
    UITapGestureRecognizer *hidtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewHid)];
    
    [self.navView addGestureRecognizer:hidtap];
    
//    [_tableView addGestureRecognizer:hidtap];
    
    
    
    
   
    
    
    // Do any additional setup after loading the view.
}






- (void)keyboardWasHidden:(NSNotificationCenter *)not{
    
    NSLog(@"hid");
    
//    _tableView.contentOffset = CGPointMake(0, 0);

    
    
}
- (void)keyboardWasShow:(NSNotificationCenter *)not{
    
    NSLog(@"show");
    
//    _tableView.contentOffset = CGPointMake(0, 450);
    
}




- (void)viewHid{
    
    [self.view endEditing:YES];
    
}



-(void)dateChanged:(id)sender{
    
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *showtimeNew = [formatter1 stringFromDate:_date];
    
    
    NSLog(@"%@",showtimeNew);
    
    dateLabel.text = showtimeNew;
    
}



- (void)picClick:(UIButton *)btn{
    
    UIImageView *vi = (UIImageView *)[self.view viewWithTag:1945];
    
    CATransition *ti = [CATransition animation];
    ti.type = @"oglFlip";
    ti.duration = 0.3;
    [vi.layer addAnimation:ti forKey:@"oglFlip"];
    
    vi.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
    
    backView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);

    
}

- (void)time{
    
    NSLog(@"时间");
    
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIImageView *vi = (UIImageView *)[self.view viewWithTag:1945];
    
    CATransition *ti = [CATransition animation];
    ti.type = @"oglFlip";
    ti.duration = 0.3;
    [vi.layer addAnimation:ti forKey:@"oglFlip"];
    
    vi.frame = CGRectMake(0, 100, SCREEN_WIDTH, 250);
    
    
    
}













- (void)requestStarted:(ASIHTTPRequest *)request{
    
    
    [MMProgressHUD showWithStatus:@"正在发布"];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    

    id result = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    
    if ( [result isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        NSLog(@"%@",dic);
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        
        NSString *imagePath = [dataDic objectForKey:@"aid"];
        
        [AIDArray addObject:imagePath];
        
    }
    
    requestTag++;
    
    if (_photoArray.count == requestTag) {
        
        [self requesthuo];
        
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
    [MMProgressHUD dismissWithError:@"发布活动失败"];
    
    requestTag++;
    
}



#pragma mark 发布

- (void)requesthuo{
    
    requestTag = 0;
    
    [_photoArray removeAllObjects];
    
    
    
    
    [MMProgressHUD showWithStatus:@"发布活动"];
    
    NSString *string = @"";
    
    for (NSString *str in AIDArray) {
        
        string  = [string stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
        
    }
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@||ios",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSLog(@"%@",sysString);
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
    NSString *sigString =@"";
    
    
    if ([def objectForKey:USER_NAME]) {
        
        sigString = [[NSString stringWithFormat:@"%@%d%@%@",sysString,CURRENT_TIME,CURRENT_SIGN_KEY,[def objectForKey:CURRENT_AUTH_KEY]]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }else{
        
        sigString = [[NSString stringWithFormat:@"%@%d%@",sigString,CURRENT_TIME,CURRENT_SIGN_KEY]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }
    
    sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
    
    NSLog(@"two=============%@",sigString);
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"add",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:titleLabel.text forKey:@"title"];
    
    if (sw.on) {
        [parameters setValue:@"1" forKey:@"isPk"];
        
    }else{
        [parameters setValue:@"0" forKey:@"isPk"];
        
    }
    
    [parameters setValue:biaoString forKey:@"category"];

    
    [parameters setValue:string forKey:@"aids"];
    
    NSLog(@"%@",dateLabel.text);
    
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *fromdate=[format dateFromString:dateLabel.text];
    
    NSLog(@"%@",fromdate);
    
    time= (long)[fromdate timeIntervalSince1970];
    NSLog(@"%ld",time);
    
    
    //    NSDate *date = [NSDate date];
    //
    //
    //    long start = [date timeIntervalSince1970] + 86400;
    
    [parameters setValue:[NSString stringWithFormat:@"%ld",time] forKey:@"startTime"];
    
    [parameters setValue:[def objectForKey:USER_LAT] forKey:@"lat"];
    
    [parameters setValue:[def objectForKey:USER_LONG] forKey:@"lng"];
    
    [parameters setValue:addressLabel.text forKey:@"area"];
    
#pragma mark test
    //    [parameters setValue:@"北京" forKey:@"area"];
    
    
    [parameters setValue:priceLabel.text forKey:@"cost"];
    [parameters setValue:peopleLabel.text forKey:@"maxNum"];
    [parameters setValue:shuoming.text forKey:@"message"];
    [parameters setValue:tv.text forKey:@"require"];
    
    
    
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
                                      
                                      [MMProgressHUD dismissWithSuccess:@"发布活动成功"];
                                      
                                      [self.navigationController popViewControllerAnimated:YES];
                                      
                                      
                                  }else{
                                      
                                      
                                      NSString *sss = [dic objectForKey:@"msg"];
                                      
                                      NSLog(@"%@",sss);
                                      
                                      [MMProgressHUD dismissWithError:[NSString stringWithFormat:@"%@",sss]];
                                      
                                  }
                                  
                                  
                              }else
                              {
                                  NSLog(@"jsonError:%@",jsonError);
                                  [MMProgressHUD dismissWithError:@"发布活动失败"];
                                  
                              }
                              
                          }else
                          {
                              NSLog(@"error:%@",error);
                              [MMProgressHUD dismissWithError:@"发布活动失败"];
                              
                          }
                          
                          
                          
                      }];

    
}












- (void)tijiao{
    
    NSLog(@"提交");
    
    [self.view endEditing:YES];
    
    
    
    if (_photoArray.count < 1) {
        
        [self requesthuo];
        
        return;
    }
    

//    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@||ios",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
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
    
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"add",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    
#pragma mark image
    
    
    
    NSString *imageurlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"upload",@"image",sysString];
    
    NSString *imageurlStringUse = [imageurlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *imageurl = [NSURL URLWithString:imageurlStringUse];
    
    NSMutableDictionary *imageparameters = [NSMutableDictionary dictionary];
    
    [imageparameters setValue:sigString forKey:@"sig"];
    
    [imageparameters setValue:@"activity" forKey:@"type"];

    NSData *da = [_photoArray lastObject];
    
    [imageparameters setValue:da  forKey:@"pic"];
    

//    NSLog(@"%@",da);
    
    
    
    
    
    [_photoArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
   
        NSData *imageData = (NSData *)obj;
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:imageurl];
        [request setPostValue:sigString forKey:@"sig"];
        [request setPostValue:@"activity" forKey:@"type"];
        [request addData:imageData withFileName:@"head.png" andContentType:@"image/jpeg" forKey:@"pic"];
        [request setDelegate:self];
        [request setTimeOutSeconds:30];
        request.tag = 500 + idx;
        [request startAsynchronous];
    
    }];
    
    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:imageurl];
//    [request setPostValue:sigString forKey:@"sig"];
//    [request setPostValue:@"activity" forKey:@"type"];
//    [request addData:da withFileName:@"head.png" andContentType:@"image/jpeg" forKey:@"pic"];
//    [request setDelegate:self];
//    [request setTimeOutSeconds:30];
//    [request startAsynchronous];
    

    
    
    return;
    
    [WTRequestCenter postWithURL:imageurl
                           parameters:imageparameters completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
     
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
     
                                           [MMProgressHUD dismissWithSuccess:@"发布活动成功"];
     
     
                                           [self.navigationController popViewControllerAnimated:YES];
     
     
                                       }else{
     
     
                                           NSString *sss = [dic objectForKey:@"msg"];
     
                                           NSLog(@"%@",sss);
     
                                           [MMProgressHUD dismissWithError:[NSString stringWithFormat:@"%@",sss]];
     
                                       }
     
     
                                   }else
                                   {
                                       NSLog(@"jsonError:%@",jsonError);
                                       [MMProgressHUD dismissWithError:@"发布活动失败"];
     
                                   }
     
                               }else
                               {
                                   NSLog(@"error:%@",error);
                                   [MMProgressHUD dismissWithError:@"发布活动失败"];
                                   
                               }
                               
                               
                               
                           }];

    
    
    
    
    
    
    
//    
//    [WTRequestCenter upLoadImageWithURL:imageurl datas:_photoArray fileNames:fileNameArray completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//#pragma maek ipup
//        
//        
//        if (!error) {
//            
//            NSError *jsonError = nil;
//            
//            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
//            
//            
//            if (!jsonError) {
//                
//                NSDictionary *dic = (NSDictionary *)obj;
//                
//                NSLog(@"%@",dic);
//                
//                
//                NSString *state = [dic objectForKey:@"code"];
//                int a = [state intValue];
//                NSLog(@"%d",a);
//                
//                if (a == 0) {
//                    
//                    NSDictionary *dict = [dic objectForKey:@"data"];
//                    
//                    NSLog(@"%@",dict);
//#pragma mark 图片
//                    
//                                        [MMProgressHUD dismissWithSuccess:@"发布活动成功"];
//                    
//                    
//                    
//                }else{
//                    
//                    
//                    NSString *sss = [dic objectForKey:@"msg"];
//                    
//                    NSLog(@"%@",sss);
//                    
//                                        [MMProgressHUD dismissWithError:[NSString stringWithFormat:@"%@",sss]];
//                    
//                }
//                
//                
//            }else
//            {
//                                NSLog(@"jsonError:%@",jsonError);
//                                [MMProgressHUD dismissWithError:@"发布活动失败"];
//                
//            }
//            
//        }else
//        {
//                        NSLog(@"error:%@",error);
//                        [MMProgressHUD dismissWithError:@"发布活动失败"];
//            
//        }
//        
//        
//        
//        
//        
//        
//    }];
//    
    
    
    
    
    
    return;
    
    
    
    
    
    
    
#pragma mark imageEnd
    
    
    
    
    
}













- (void)addImage{
    
    NSLog(@"add");
    
    
    if (_photoArray.count > 8) {
        
        [MMProgressHUD showWithStatus:@"长在上传"];
        
        [MMProgressHUD dismissWithError:@"照片个数已到上限"];
        
        return;
    }
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择路径" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [sheet showInView:self.view];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex == 2) {
        
        return;

    }else{
        
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        
        
        if (buttonIndex == 0) {
            
            if (SIMULATOR) {
                return;
            }else{
                
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            }
            
        }else if (buttonIndex == 1){
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
    
//    [self postImageData:imgData];
    
    NSLog(@"上传图片");
    
    [_photoArray addObject:imgData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [photoTable reloadData];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}









#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([tableView isEqual:_tableView]) {
        
        return 5;

    }else{
        
        return 1;
        
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([tableView isEqual:_tableView]) {
        
        
        
        if (section == 2) {
            
            return 1;
            
        }else if (section == 3){
            
            return 1;
            
        }else if (section == 4){
            
            return 1;
            
        }else{
            
            return 3;
            
        }

    }else{
        
        return _photoArray.count;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([tableView isEqual:_tableView]) {
        
        if (indexPath.section == 3) {
            
            return 80;
        
        }else if (indexPath.section == 4){
            
            return 150;
            
        }
        
        return 50;
        
    }else{
        
        return 70;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView]) {
        
        return 20;

    }else{
        
        return -1;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView]) {
    
        return 0.1;

    }else{
        
        return 10;
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        
        
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.accessoryType = 0;

        
        cell.textLabel.font = [UIFont systemFontOfSize:14];

        
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"活动主题";
                
            }else if (indexPath.row == 1){
                
                cell.textLabel.text = @"开始时间";
                
            }else{
                
                cell.textLabel.text = @"活动标签";
                
            }
            
        }else if (indexPath.section == 1){
            
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"地点";
                
            }else if (indexPath.row == 1){
                
                cell.textLabel.text = @"费用";
                
            }else{
                
                cell.textLabel.text = @"人数限制";
                
            }
            
        }else if (indexPath.section == 2){
            
            cell.textLabel.text = @"积分赛";
            
            
        }else if (indexPath.section == 3){
            
            cell.textLabel.text = @"要求";
            
            
        }else if (indexPath.section == 4){
            
            cell.textLabel.text = @"说明";
            
        }
        
        return cell;
        
        
    }else{
        
        
        static NSString *myCell = @"cell";
        
        faBuCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        
        if (cell == nil) {
            
            cell = [[faBuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            
        }

        cell.selectionStyle = 0;
        
        cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
        
        cell.head.image = [UIImage imageWithData:[_photoArray objectAtIndex:indexPath.row]];
        
        cell.head.contentMode = UIViewContentModeScaleAspectFill;
        
        cell.head.clipsToBounds = YES;
        
        return cell;
    
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView isEqual:_tableView]) {
        
        
        if (indexPath.section == 0) {
            
            
            if (indexPath.row == 0) {
                
                ActivityZhuTiViewController *zhu  = [[ActivityZhuTiViewController alloc]init];
              
                [zhu callBack:^(NSString *str) {
                
                    titleLabel.text = str;
                    
                }];
                
                [self.navigationController pushViewController:zhu animated:YES];
                
                
            }else if (indexPath.row == 1){
                
                [self time];
                
            }else if (indexPath.row == 2){
                
                ActivityBiaoViewController *biao = [[ActivityBiaoViewController alloc]init];
                [biao callBack:^(NSString *str) {
                    
                    biaoString = str;
                    
                    if ([str isEqualToString:@"1"]) {
                        
                        biaoLable.text = @"台球";

                    }else if ([str isEqualToString:@"2"]){
                        
                        biaoLable.text = @"羽毛球";

                        
                    }else if ([str isEqualToString:@"3"]){
                        
                        biaoLable.text = @"网球";
                        
                        
                    }else if ([str isEqualToString:@"4"]){
                        
                        biaoLable.text = @"乒乓球";
                        
                        
                    }else if ([str isEqualToString:@"5"]){
                        
                        biaoLable.text = @"golf";
                        
                        
                    }else if ([str isEqualToString:@"6"]){
                        
                        biaoLable.text = @"足球";
                        
                        
                    }else if ([str isEqualToString:@"7"]){
                        
                        biaoLable.text = @"篮球";
                        
                        
                    }else if ([str isEqualToString:@"8"]){
                        
                        biaoLable.text = @"游泳";
                        
                        
                    }else if ([str isEqualToString:@"9"]){
                        
                        biaoLable.text = @"保龄";
                        
                        
                    }else if ([str isEqualToString:@"10"]){
                        
                        biaoLable.text = @"滑雪";
                        
                        
                    }else if ([str isEqualToString:@"11"]){
                        
                        biaoLable.text = @"射箭";
                        
                        
                    }else if ([str isEqualToString:@"12"]){
                        
                        biaoLable.text = @"骑马";
                        
                        
                    }else if ([str isEqualToString:@"13"]){
                        
                        biaoLable.text = @"户外";
                        
                        
                    }else if ([str isEqualToString:@"14"]){
                        
                        biaoLable.text = @"跑步";
                        
                        
                    }else if ([str isEqualToString:@"15"]){
                        
                        biaoLable.text = @"桌游";
                        
                        
                    }else if ([str isEqualToString:@"16"]){
                        
                        biaoLable.text = @"摄影";
                        
                        
                    }else if ([str isEqualToString:@"17"]){
                        
                        biaoLable.text = @"ktv";
                        
                        
                    }else if ([str isEqualToString:@"18"]){
                        
                        biaoLable.text = @"聚餐";
                        
                        
                    }else if ([str isEqualToString:@"19"]){
                        
                        biaoLable.text = @"培训";
                        
                        
                    }
                    
                    
                }];
                [self.navigationController pushViewController:biao animated:YES];
                
            }
            
        }else if (indexPath.section == 1){
            
            if (indexPath.row == 0) {
                
                
                
            }else if (indexPath.row == 1){
                
                
                FeiYongViewController *yong = [[FeiYongViewController alloc]init];

                [yong callBack:^(NSString *str) {
                   
                    priceLabel.text= str;
                    
                }];
                
                [self.navigationController pushViewController:yong animated:YES];
                
                
            }else if (indexPath.row == 2){
                
                XianZhiViewController *biao = [[XianZhiViewController alloc]init];
                [biao callBack:^(NSString *str) {
                    
                    peopleLabel.text = str;
                    
                }];
                [self.navigationController pushViewController:biao animated:YES];
                
            }
            
        }else if (indexPath.section == 3){
            
            
            
        }
        
        
        
    }
    
}


- (void)address{
    
    
    
    JuAddressViewController *addre = [[JuAddressViewController alloc]init];
    [addre callBackAdress:^(NSString *str) {
        
        addressLabel.text = str;
        
    }];
    [self.navigationController pushViewController:addre animated:YES];
    
    

    
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
