//
//  MeViewController.m
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeViewController.h"
#import "MeMessageViewController.h"
#import "MeAboutViewController.h"
#import "MeActivityViewController.h"
#import "MeJuLeBuViewController.h"
#import "MeScoreViewController.h"
#import "MePingViewController.h"
#import "MeVIPCenterViewController.h"
#import "MeStoreViewController.h"
#import "MeSystemViewController.h"


#import "MyDongTaiViewController.h"


#import "WTRequestCenter.h"


@interface MeViewController ()

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)requestMyInfo{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];

    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
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
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:[def objectForKey:HUAN_NAME] forKey:@"uid"];
    
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
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      NSDictionary *dataDic = [dic objectForKey:@"data"];
                                      NSLog(@"%@",dataDic);
                                      
                                      
                                      NSArray *imgarr = [dataDic objectForKey:@"avatars"];
                                      NSDictionary *imgDic = [imgarr lastObject];
                                      
                                      [def setObject:[imgDic objectForKey:@"url"] forKey:MY_INFO_HEADER];
                                      
                                      [def setObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"nickName"]] forKey:MY_INFO_NAME];
                                      
                                      if ([[NSString stringWithFormat:@"%@",[def objectForKey:@"gender"]]isEqualToString:@"1"]) {
                                          
                                          [def setObject:@"男" forKey:MY_INFO_SEX];
                                          
                                      }else if ([[NSString stringWithFormat:@"%@",[def objectForKey:@"gender"]]isEqualToString:@"2"]){
                                          
                                          [def setObject:@"女" forKey:MY_INFO_SEX];
                                          
                                      }else{
                                          
                                          [def setObject:@"未知" forKey:MY_INFO_SEX];

                                      }
                                      
                                      [def setObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"age"]] forKey:MY_INFO_AGE];
                                      
                                      [def setObject:[dataDic objectForKey:@"bio"] forKey:MY_INFO_BIO];
                                      
                                      
                                      [def setObject:[dataDic objectForKey:@"affectiveStatus"] forKey:MY_INFO_affectiveStatus];
                                      [def setObject:[dataDic objectForKey:@"company"] forKey:MY_INFO_company];
                                      [def setObject:[dataDic objectForKey:@"occupation"] forKey:MY_INFO_occupation];
                                      [def setObject:[dataDic objectForKey:@"payRole"] forKey:MY_INFO_payRole];
                                      [def setObject:[dataDic objectForKey:@"interest"] forKey:MY_INFO_interest];
                                      [def setObject:[dataDic objectForKey:@"hometown"] forKey:MY_INFO_hometown];
                                      
                                      [def setObject:[dataDic objectForKey:@"pkCredit"] forKey:MY_INFO_PK_CREDIT];
                                      [def setObject:[dataDic objectForKey:@"cityRank"] forKey:MY_INFO_CITY_RANK];
                                      [def setObject:[dataDic objectForKey:@"worldRank"] forKey:MY_INFO_WORLD_RANK];
                                      
                                      
                                      [def synchronize];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      NSLog(@"%@",[dic objectForKey:@"msg"]);
                                      
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
                          
                      }];
    
    

    
    
    
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"我";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(X_OFF_SET, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - BAR_HEIGHT - NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"个人动态",@"与我相关",@"我的活动",@"我的俱乐部",@"成绩列表",@"竞技等级评价",@"会员中心",@"商城",@"系统设置", nil];
    
    
    [self requestMyInfo];

    // Do any additional setup after loading the view.
}


#pragma mark tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 50;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell*cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    cell.selectionStyle = 0;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.section == 0) {
        
        UIImageView *head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        [head setImageWithURL:[NSURL URLWithString:[def objectForKey:MY_INFO_HEADER]]];
        [cell addSubview:head];
       
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, 50, 15)];
        name.text = [def objectForKey:MY_INFO_NAME];
        name.font = [UIFont systemFontOfSize:14];
        [name sizeToFit];
        [cell addSubview:name];
        
        
        UIImageView *sexImage = [[UIImageView alloc]initWithFrame:CGRectMake(85 + name.frame.size.width, 18, 10,10)];
        if ([[def objectForKey:MY_INFO_SEX]isEqualToString:@"男"]) {
            sexImage.image = [UIImage imageNamed:@"icon_sex_woman"];

        }else{
            sexImage.image = [UIImage imageNamed:@"icon_sex_man"];
            
        }
        [cell addSubview:sexImage];

        
        UILabel *ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(100 + name.frame.size.width, 15, 30, 15)];
        ageLabel.text = [def objectForKey:MY_INFO_AGE];
        ageLabel.font = [UIFont systemFontOfSize:12];
        [cell addSubview:ageLabel];

        
    }else{
        
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.section == 0) {
        
        MeMessageViewController *mess = [[MeMessageViewController alloc]init];
        [self.navigationController pushViewController:mess animated:YES];
        
        
    }else{
        
        if (indexPath.row == 0) {
            
            MyDongTaiViewController *dong = [[MyDongTaiViewController alloc]init];
            [self.navigationController pushViewController:dong animated:YES];
            
        }else if (indexPath.row == 1){

            MeAboutViewController *about = [[MeAboutViewController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
            
        }else if (indexPath.row == 2){
            
            MeActivityViewController *activity = [[MeActivityViewController alloc]init];
            [self.navigationController pushViewController:activity animated:YES];
            
        }else if (indexPath.row == 3){

            MeJuLeBuViewController *ju = [[MeJuLeBuViewController alloc]init];
            [self.navigationController pushViewController:ju animated:YES];
            
        }else if (indexPath.row == 4){
            
            MeScoreViewController *score = [[MeScoreViewController alloc]init];
            [self.navigationController pushViewController:score animated:YES];
            
        }else if (indexPath.row == 5){
            
            MePingViewController *ping = [[MePingViewController alloc]init];
            [self.navigationController pushViewController:ping animated:YES];
            
        }else if (indexPath.row == 6){
            
            MeVIPCenterViewController *vip= [[MeVIPCenterViewController alloc]init];
            [self.navigationController pushViewController:vip animated:YES];
            
        }else if (indexPath.row == 7){
            
            MeStoreViewController *store = [[MeStoreViewController alloc]init];
            [self.navigationController pushViewController:store animated:YES];
            
            
        }else if (indexPath.row == 8){
            
            MeSystemViewController *system = [[MeSystemViewController alloc]init];
            [self.navigationController pushViewController:system animated:YES];
            
        }
        
        
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
