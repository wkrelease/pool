//
//  MeScoreViewController.m
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeScoreViewController.h"

#import "MeScoreCell.h"
#import "MeScoreModel.h"

#import "WTRequestCenter.h"


#import "ChengJiViewController.h"

@interface MeScoreViewController (){
    
    
}

@end

@implementation MeScoreViewController

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
    
    
    self.myTitleLabel.text = @"成绩列表";
    
    [self showBack];

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self requestScore];
    
    // Do any additional setup after loading the view.
}

- (void)requestScore{
    
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"myScoreList",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:[def objectForKey:HUAN_NAME] forKey:@"uid"];

    
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
                                      
                                      NSArray *array = [dict objectForKey:@"activityList"];
                                      
                                      for (NSDictionary *diction in array) {
                                          
                                          MeScoreModel *model = [[MeScoreModel alloc]init];
                                          
                                          model.headStr = [diction objectForKey:@"image"];
                                          
                                          model.idStr = [diction objectForKey:@"activityId"];
                                          
                                          model.nameStr = [diction objectForKey:@"title"];
                                          
                                          NSString *str = [diction objectForKey:@"startTime"];
                                          NSTimeInterval time=[str doubleValue];
                                          NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
                                          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                                          NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
                                          model.dateStr = currentDateStr;

                                          
                                          model.addressStr = [diction objectForKey:@"distance"];
                                          
                                          model.scroreStr = [diction objectForKey:@"maxNum"];
                                          
                                          
                                          model.haveRank = [diction objectForKey:@"ranking"];
                                          
                                          
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
                          
                      }];
    
    

    
    
}





#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 110;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    MeScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[MeScoreCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    if (_dataArray.count >= 1) {
        
        MeScoreModel *model = (MeScoreModel *)[_dataArray objectAtIndex:indexPath.row];
        [cell.headView setImageWithURL:[NSURL URLWithString:model.headStr]];
        cell.name.text = model.nameStr;
        cell.mess.text = model.dateStr;
        cell.numLabel.text = [NSString stringWithFormat:@"距离%@km",model.addressStr];
        cell.address.text = [NSString stringWithFormat:@"我的成绩:%@强",model.scroreStr];;
        
    }
    
    cell.selectionStyle = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    MeScoreModel *model = (MeScoreModel *)[_dataArray objectAtIndex:indexPath.row];

    if (model.haveRank.length < 1) {
        
        [MMProgressHUD showWithStatus:@""];
        
        [MMProgressHUD dismissWithError:@"没有录入过成绩"];

    }else{
        
        ChengJiViewController *cheng = [[ChengJiViewController alloc]init];
        
        cheng.activityIDStr = model.idStr;
        
        cheng.titleString = model.nameStr;
        
        [self.navigationController pushViewController:cheng animated:YES];
        
        
    }
    


    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0.1;
    
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
