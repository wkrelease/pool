//
//  MeSystemViewController.m
//  POOL
//
//  Created by king on 15-2-12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeSystemViewController.h"
#import "ChangeMessageViewController.h"

#import "WTRequestCenter.h"

#import "LoginViewController.h"

@interface MeSystemViewController ()

@end

@implementation MeSystemViewController

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
    
    self.myTitleLabel.text = @"系统设置";
    
    [self showBack];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    
    UIButton *tui = [UIButton buttonWithType:UIButtonTypeCustom];
    [tui setTitle:@"退出" forState:UIControlStateNormal];
    [tui setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    tui.frame = CGRectMake(20, 360, SCREEN_WIDTH - 40, 40);
    tui.titleLabel.font = [UIFont systemFontOfSize:14];
    tui.layer.borderWidth = 1;
    tui.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [tui addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:tui];
    
    // Do any additional setup after loading the view.
}
- (void)tuichu{
    
    NSLog(@"退出");
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您将要退出登录" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 0) {
        
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        [def removeObjectForKey:USER_NAME];
        

        
    }
    
}




#pragma MARK tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 20;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    if (indexPath.section == 0) {
        
        
        UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 50, 20)];
        sw.on = YES;
        [sw addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        sw.tag = 210 + indexPath.row;
        [cell addSubview:sw];
        
        
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"隐身模式";

            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];

            if ([def objectForKey:USER_HIDDEN]) {
                
                sw.on = YES;
                
            }else{
                
                sw.on = NO;
                
            }
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = @"声音提示";

        }else if (indexPath.row == 2){
         
            cell.textLabel.text = @"震动模式";

        }
        


        
        
        
        
        
    }else if (indexPath.section == 1){
        
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = @"修改密码";
            
           
            
        }else if (indexPath.row == 1){
            
            cell.textLabel.text = @"用户协议";
            
        }else if (indexPath.row == 2){
            
            cell.textLabel.text = @"清理缓存";
            
        }
        
        
        
    }
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 1){
        
        
        if (indexPath.row == 0) {
            
            ChangeMessageViewController *mes = [[ChangeMessageViewController alloc]init];
            [self.navigationController pushViewController:mes animated:YES];
            
            
        }else if (indexPath.row == 1){
            
            

            
        }else if (indexPath.row == 2){
            

            
        }
        
        
        
    }

    
    
  
}

-(void)switchChange:(UISwitch *)sw{
    
    
    
    if (sw.tag == 210) {
        
        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        if (sw.on) {
            [def setObject:@"1" forKey:USER_HIDDEN];
        }else{
            [def removeObjectForKey:USER_HIDDEN];
        }
        [def synchronize];

        
        
        NSString *switchState = @"1";
        
        if (sw.on) {
            switchState = @"1";
        }else{
            switchState = @"0";
        }
        
        [self requestInShen:switchState];
        
    }else if (sw.tag == 211){
        
        
    }else if (sw.tag == 212){
        
        
        
    }
    
    
}

- (void)requestInShen:(NSString *)str{
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"member",@"hideLine",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [parameters setValue:sigString forKey:@"sig"];
    
    
    [parameters setValue:str forKey:@"isHide"];
    
    
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
