//
//  JuKongViewController.m
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuKongViewController.h"

#import "WTRequestCenter.h"

#import "JuKongCell.h"

#import "JuKongModel.h"

#import "JuKongMessViewController.h"

@interface JuKongViewController ()

@end

@implementation JuKongViewController

@synthesize name,idStr;

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    self.myTitleLabel.text = [NSString stringWithFormat:@"%@的空间",name];
    
    
    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray array];
        
    [self requestmy];
    
    // Do any additional setup after loading the view.
}


- (void)requestmy{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"groupSpace",@"list",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:idStr forKey:@"gid"];
    
    
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
                                      NSArray *array = [dict objectForKey:@"feedList"];
                                      
                                      for (NSDictionary *diction in array) {
                                          
                                          JuKongModel *model = [[JuKongModel alloc]init];
                                          
                                          
                                          
                                          
                                          NSString *dateString = [[diction objectForKey:@"createTime"]stringByAppendingString:@"800"];
                                          NSDate *newDate  = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]/1000];
                                          NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
                                          [formatter1 setDateFormat:@"MM-dd"];
                                          NSString *showtim = [formatter1 stringFromDate:newDate];
                                          model.date = showtim;

                                          
//                                          model.date = [diction objectForKey:@"createTime"];
                                          model.headStr = [diction objectForKey:@"avatar"];
                                          
                                          model.nameStr = [diction objectForKey:@"nickName"];
                                          
                                          model.message = [diction objectForKey:@"message"];
                                          
                                          model.pinglun = [diction objectForKey:@"commentNum"];
                                          
                                          model.idstr = [diction objectForKey:@"feedId"];
                                          
                                          NSArray *arr = [diction objectForKey:@"images"];
                                          
                                          if (arr.count >= 1) {
                                              
                                              for (int i = 0; i < arr.count; i++) {
                                                  
                                                  if (i == 0) {
                                                      model.ONEIMGSTR = [arr objectAtIndex:i];
                                                  }else if (i == 1){
                                                      model.TWOIMGSTR = [arr objectAtIndex:i];
                                                  }else if (i == 3){
                                                      model.THREEIMGSTR = [arr objectAtIndex:i];
                                                  }
                                                  
                                              }
                                              
                                              
                                          }
                                          
                                          
                                          
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    
    JuKongCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[JuKongCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        
    }

    JuKongModel *model = (JuKongModel *)[_dataArray objectAtIndex:indexPath.row];
    
    cell.dateLabel.text = model.date;
    
    cell.messageLabel.text = model.message;
    
    cell.messageLabel.numberOfLines = 2;
    
    cell.pingNum.text = [NSString stringWithFormat:@"%@条评论",model.pinglun];
    
    
    [cell.head setImageWithURL:[NSURL URLWithString:model.headStr]];
    
    cell.name.text = model.nameStr;
    
    
    cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    
    cell.oneImage.alpha = 0;
    cell.twoImage.alpha = 0;
    cell.threeImage.alpha = 0;
    
    cell.pingNum.frame = CGRectMake(SCREEN_WIDTH - 100, 75, 80, 20);
    
    if (model.ONEIMGSTR.length > 1) {
        
        cell.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
        
        cell.oneImage.alpha = 1;
        cell.twoImage.alpha = 1;
        cell.threeImage.alpha = 1;
        
        cell.pingNum.frame = CGRectMake(SCREEN_WIDTH - 100, 125, 80, 20);

        
    }
    
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JuKongMessViewController *kongMess= [[JuKongMessViewController alloc]init];
    
    JuKongModel *model = (JuKongModel *)[_dataArray objectAtIndex:indexPath.row];
    
    kongMess.idStr = model.idstr;
    
    kongMess.name = name;
    
    kongMess.groupID = idStr;
    
    [self.navigationController pushViewController:kongMess animated:YES];
    
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
