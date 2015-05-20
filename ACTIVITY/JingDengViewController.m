//
//  JingDengViewController.m
//  POOL
//
//  Created by king on 15/5/14.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JingDengViewController.h"

#import "WTRequestCenter.h"


#import "DengCell.h"

#import "DengModel.h"

#import "MemberViewController.h"


#define STAR_TAG 1000




@interface JingDengViewController (){
    
    UIView *pingView;
    
    UITextField *pingField;
    
    NSString *userName;
    
}

@end

@implementation JingDengViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.myTitleLabel.text = @"竞技能力";
    
    [self showBack];
    
    UIImageView *upView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 380)];
    upView.backgroundColor = [UIColor whiteColor];
    upView.userInteractionEnabled = YES;
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 20)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = @"综合能力";
    lab.textColor = [UIColor grayColor];
    [upView addSubview:lab];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(120 + i * 30,5, 18, 18)];
        mv.image = [UIImage imageNamed:@"icon_xing_kong"];
        [upView addSubview:mv];
        
        UIImageView *mv2 = [[UIImageView alloc]initWithFrame:CGRectMake(120 + i * 30,5, 18, 18)];
        mv2.image = [UIImage imageNamed:@"icon_xing_shi"];
        [upView addSubview:mv2];
        
    }
    
    
    
    NSArray *array = [NSArray arrayWithObjects:@"技能",@"得分", nil];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 * idx, 30, SCREEN_WIDTH/2, 40)];
        lab.backgroundColor = R_G_B_COLOR(161, 169, 187);
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = obj;
        lab.textAlignment = NSTextAlignmentCenter;
        [upView addSubview:lab];
        
        
        
    }];
    
    NSArray *arr = [NSArray arrayWithObjects:@"击球准度",@"杆法运用",@"线路走位",@"稳定性",@"局面控制",@"心理素质", nil];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 80 + idx * 50, SCREEN_WIDTH/2, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = obj;
        lab.font = [UIFont systemFontOfSize:14];
        [upView addSubview:lab];
        
        UIImageView *li = [[UIImageView alloc]initWithFrame:CGRectMake(0, 125 + idx * 50, SCREEN_WIDTH, 1)];
        li.backgroundColor = R_G_B_COLOR(221, 221, 221);
        [upView addSubview:li];
        
        
        
        
        for (int i = 0; i < 5; i++) {
            
            UIButton *starBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [starBtn setImage:[UIImage imageNamed:@"icon_xing_kong"] forState:UIControlStateNormal];
            [starBtn setImage:[UIImage imageNamed:@"icon_xing_shi"] forState:UIControlStateSelected];
            starBtn.frame = CGRectMake(160 + i * 30, 90 + idx * 50, 20, 20);
            starBtn.tag = STAR_TAG * (idx+1) + i;
            [starBtn addTarget:self action:@selector(starClick:) forControlEvents:UIControlEventTouchUpInside];
            [upView addSubview:starBtn];

            
            
//            UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(160 + i * 30, 90 + idx * 50, 18, 18)];
//            mv.image = [UIImage imageNamed:@"icon_xing_kong"];
//            [upView addSubview:mv];
            
        }
        
//        for (int i = 0; i < 3; i++) {
//            
//            UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(160 + i * 30, 90 + idx * 50, 18, 18)];
//            mv.image = [UIImage imageNamed:@"icon_xing_shi"];
//            [upView addSubview:mv];
//            
//        }
//        
        
    }];
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    _tableView.bounces = NO;
    _tableView.backgroundColor = R_G_B_COLOR(234, 234, 234);
    [self.view addSubview:_tableView];
    upView.backgroundColor = R_G_B_COLOR(234, 234, 234);
    _tableView.tableHeaderView = upView;
    
    _dataArray = [NSMutableArray array];
    
    [self requestJingJi];

    
    pingView = [[UIView alloc]initWithFrame:CGRectMake(X_OFF_SET, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40)];
    pingView.backgroundColor = [UIColor whiteColor];
    pingView.userInteractionEnabled = YES;
    [self.view addSubview:pingView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHide) name:UIKeyboardDidHideNotification object:nil];
    
    
    
    pingField = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 70, 30)];
    pingField.borderStyle = UITextBorderStyleRoundedRect;
    pingField.font = [UIFont systemFontOfSize:12];
    pingField.textColor = [UIColor grayColor];
    pingField.placeholder = @"输入内容";
    pingField.delegate = self;
    pingField.returnKeyType = UIReturnKeyDone;
    [pingView addSubview:pingField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 60, 5, 50, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(faSong) forControlEvents:UIControlEventTouchUpInside];
    [pingView addSubview:btn];
    
    [self requestMess];
    
    
    
    
    
    
    UIButton *tata = [UIButton buttonWithType:UIButtonTypeCustom];
    [tata setTitle:@"他的资料" forState:UIControlStateNormal];
    tata.frame = CGRectMake(SCREEN_WIDTH - 60, 30, 50, 30);
    tata.titleLabel.font = [UIFont systemFontOfSize:12];
    [tata setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [tata addTarget:self action:@selector(tata) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:tata];
    
    // Do any additional setup after loading the view.
}


- (void)tata{
    
    MemberViewController *mem = [[MemberViewController alloc]init];
    
    mem.name = userName;
    
    mem.userIdStr = _persionIDStr;
    
    [self.navigationController pushViewController:mem animated:YES];
    
}


- (void)starClick:(UIButton *)button{
    
    if (button.tag >= STAR_TAG && button.tag < STAR_TAG * 2) {
        
        for (int i = STAR_TAG; i < STAR_TAG + 6; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = NO;
        }
        
        for (int i = STAR_TAG; i <= button.tag; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = YES;
            
        }
        
        
    }else if (button.tag >= STAR_TAG * 2 && button.tag < STAR_TAG * 3){
        
        
        for (int i = STAR_TAG * 2; i < STAR_TAG + 6; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = NO;
        }
        
        for (int i = STAR_TAG * 2; i <= button.tag; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = YES;
            
        }
        
        
        
    }else if (button.tag >= STAR_TAG * 3 && button.tag < STAR_TAG * 4){
        
        for (int i = STAR_TAG * 3; i < STAR_TAG + 6; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = NO;
        }
        
        for (int i = STAR_TAG * 3; i <= button.tag; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = YES;
            
        }
        
        
    }else if (button.tag >= STAR_TAG * 4 && button.tag < STAR_TAG * 5){
        
        
        for (int i = STAR_TAG * 4; i < STAR_TAG + 6; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = NO;
        }
        
        for (int i = STAR_TAG * 4; i <= button.tag; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = YES;
            
        }
        
    }else if (button.tag >= STAR_TAG * 5 && button.tag < STAR_TAG * 6){
        
        
        for (int i = STAR_TAG * 5; i < STAR_TAG + 6; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = NO;
        }
        
        for (int i = STAR_TAG * 5; i <= button.tag; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = YES;
            
        }
        
    }else if (button.tag >= STAR_TAG * 6){
        
        
        for (int i = STAR_TAG * 6; i < STAR_TAG + 6; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = NO;
        }
        
        for (int i = STAR_TAG * 6; i <= button.tag; i++) {
            
            UIButton *btn = (UIButton *)[self.view viewWithTag:i];
            
            btn.selected = YES;
            
        }
        
    }
    
}





- (void)requestMess{
    
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"evaluation",@"index",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:_persionIDStr forKey:@"uid"];
    
    [parameters setValue:_activID forKey:@"activityId"];
    
    NSLog(@"========%@",url);
    NSLog(@"========%@",parameters);
    
    [WTRequestCenter postWithURL:url
                      parameters:parameters completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                          
                          if (!error) {
                              NSError *jsonError = nil;
                              
                              id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                              
                              if (!jsonError) {
                                  
                                  NSDictionary *dic = (NSDictionary *)obj;
                                  
                                  NSLog(@"------%@",dic);
                                  
                                  NSString *state = [dic objectForKey:@"code"];
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  
                                  if (a == 0) {
                                      
                                      NSDictionary *dddd = [dic objectForKey:@"data"];
                                      
                                      userName = [dddd objectForKey:@"nickName"];
                                      
                                      
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
                          
                      }];

    
    
}



- (void)keyboardWasChange:(NSNotification *)aNotification {
    
    NSDictionary *info = [aNotification userInfo];
    
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
//    [UIView animateWithDuration:0.2 animations:^{

        pingView.frame = CGRectMake(X_OFF_SET, SCREEN_HEIGHT - 40 - kbSize.height, SCREEN_WIDTH, 40);

//    }];
    
    
}
- (void)keyboardWasHide{
    
//    [UIView animateWithDuration:0.2 animations:^{
    
        pingView.frame = CGRectMake(X_OFF_SET, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);

//    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    pingView.frame = CGRectMake(X_OFF_SET, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    return YES;

}


- (void)faSong{
    
    if (pingField.text.length < 1) {
        
        [MMProgressHUD showWithStatus:@"正在提交"];
       
        [MMProgressHUD dismissWithError:@"请输入评论内容"];
        
        return;
    }
    
    
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"evaluation",@"evComment",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:_persionIDStr forKey:@"uid"];
    
    [parameters setValue:pingField.text forKey:@"message"];
    
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
                                      
                                      [MMProgressHUD dismissWithSuccess:@"评论成功"];
                                      
                                      [self.navigationController popViewControllerAnimated:YES];
                                                                            
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






- (void)requestJingJi{
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"evaluation",@"evCommentList",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:_persionIDStr forKey:@"uid"];
    
    [parameters setValue:0 forKey:@"start"];
    
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
                                      
                                      NSDictionary *dictt = [dic objectForKey:@"data"];
                                      
                                      NSArray *arr = [dictt objectForKey:@"evCommentList"];
                                      
                                      for (NSDictionary *dataDic in arr) {
                                          
                                          DengModel *model = [[DengModel alloc]init];
                                          
                                          model.headStr = [dataDic objectForKey:@"avatar"];
                                          
                                          model.messageStr = [dataDic objectForKey:@"message"];
                                          
                                          model.nameStr = [dataDic objectForKey:@"nickName"];
                                          
                                          [_dataArray addObject:model];
                                          
                                      }
                                      
                                      
                                      
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
    
    return 70;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *myCell = @"cell";
    
    DengCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        
        cell = [[DengCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    
    }
    
    if (_dataArray.count > 0) {
        
        DengModel *model = (DengModel *)[_dataArray objectAtIndex:indexPath.row];
        
        [cell.head setImageWithURL:[NSURL URLWithString:model.headStr]];
        
        cell.message.text = model.messageStr;
        
        cell.name.text = model.nameStr;
        
    }
    
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
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
