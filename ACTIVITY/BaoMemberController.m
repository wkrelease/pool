//
//  BaoMemberController.m
//  POOL
//
//  Created by king on 15/3/15.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "BaoMemberController.h"

#import "MemberCell.h"

#import "MemberModel.h"

#import "WTRequestCenter.h"

#import "MemberViewController.h"

@interface BaoMemberController ()

@end

@implementation BaoMemberController

@synthesize activityId;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"已报名成员";
    
    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    [self member];
    
    // Do any additional setup after loading the view.
}


- (void)member{
    
    [_dataArray removeAllObjects];
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"member",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:activityId forKey:@"activityId"];
    
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
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                  NSDictionary *dataDic = [dic objectForKey:@"data"];
                                  
                                  NSLog(@"%@",dataDic);
                                  
                                  NSArray *userArray = [dataDic objectForKey:@"userList"];
                                  
                                  for (NSDictionary *diction in userArray) {
                                      
                                      MemberModel *model = [[MemberModel alloc]init];
                                      model.userId = [diction objectForKey:@"uid"];
                                      model.headStr = [diction objectForKey:@"avatar"];
                                      model.nameStr = [diction objectForKey:@"nickName"];
                                      model.sexStr = [diction objectForKey:@"gender"];
                                      //1  是男   2是女
                                      model.ageStr = [NSString stringWithFormat:@"%@岁",[diction objectForKey:@"age"]];
                                      model.qiuStr = [diction objectForKey:@"evUpgrade"];
                                      //等级

                                      model.scoreStr = [diction objectForKey:@"pkCredit"];
                                      
                                      [_dataArray addObject:model];
                                      
                                      
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
                          
                      }];
    
    

    
    
}


#pragma mark tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    if (cell == nil) {
        cell = [[MemberCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    MemberModel *model = (MemberModel *)[_dataArray objectAtIndex:indexPath.row];
    
    [cell.head setImageWithURL:[NSURL URLWithString:model.headStr]placeholderImage:[UIImage imageNamed:@"loading"]];
    
    if (model.headStr.length < 1) {
        cell.head.image = [UIImage imageNamed:@"loading"];
    }
    
    cell.name.text = model.nameStr;
//    cell.sex
    cell.age.text = model.ageStr;
//    cell.qiu
    cell.jifen.text = [NSString stringWithFormat:@"%@积分",model.scoreStr];
    
    if ([model.sexStr isEqualToString:@"1"]) {
        //男
        
        cell.sex.image = [UIImage imageNamed:@"icon_sex_man"];
        
    }else{

        cell.sex.image = [UIImage imageNamed:@"icon_sex_woman"];

    }
    
    cell.qiu.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_billiards_%@",model.qiuStr]];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MemberModel *model = (MemberModel *)[_dataArray objectAtIndex:indexPath.row];
    
    MemberViewController *memview = [[MemberViewController alloc]init];
    
    memview.userIdStr = model.userId;
    
    memview.name = model.nameStr;
    
    [self.navigationController pushViewController:memview animated:YES];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_canDel isEqualToString:@"can"]) {
        
        return YES;

    }else{

        return NO;
        
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_canDel isEqualToString:@"can"]) {
        
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            MemberModel *model = (MemberModel *)[_dataArray objectAtIndex:indexPath.row];
            
            [self deleMem:model.userId andTag:indexPath.row andIndex:indexPath];

            
        }
        else if (editingStyle == UITableViewCellEditingStyleInsert) {
            
        }

    }
    
    
}


- (void)deleMem:(NSString *)memuSER andTag:(long)delTag andIndex:(NSIndexPath *)indexPath{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"tick",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
   
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:activityId forKey:@"activityId"];

    [parameters setValue:memuSER forKey:@"uid"];

    
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
                                  
                                  NSString *stateStr = [dic objectForKey:@"msg"];
                                  
                                  NSLog(@"%@",stateStr);
                                  
                                  if (a == 0) {
                                      
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      
                                      [MMProgressHUD dismissWithSuccess:@"删除成功"];
                                      
                                      [_dataArray removeObjectAtIndex:delTag];
                                      
                                      [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismissWithError:stateStr];
                                      
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
