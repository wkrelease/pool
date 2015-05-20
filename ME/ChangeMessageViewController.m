//
//  ChangeMessageViewController.m
//  POOL
//
//  Created by king on 15-3-7.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChangeMessageViewController.h"

#import "WTRequestCenter.h"

#import <SMS_SDK/SMS_SDK.h>

@interface ChangeMessageViewController ()

@end

@implementation ChangeMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"修改密码";
    
    [self showBack];

    
    for (int i = 0; i < 3; i ++ ) {
        
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 80 + i * 60, SCREEN_WIDTH, 40)];
        field.tag = 220 + i;
        if (i == 0) {
            field.placeholder = @"输入原密码";
        }else{
            field.placeholder = @"输入新密码";
        }
        field.backgroundColor = [UIColor whiteColor];
        field.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:field];
        
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.frame = CGRectMake(20, 280, SCREEN_WIDTH - 40, 40);
    btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    // Do any additional setup after loading the view.
}

- (void)btnClicked{
    
    
    NSLog(@"确认");
    
    [MMProgressHUD showWithStatus:@"正在刷新"];

    
    UITextField *fe = (UITextField *)[self.view viewWithTag:220];
    
    UITextField *fe2 = (UITextField *)[self.view viewWithTag:221];
    
    UITextField *fe3 = (UITextField *)[self.view viewWithTag:222];
    
    
    if (fe.text.length < 1) {
        
        [MMProgressHUD dismissWithError:@"请输入原密码"];
        
        return;
        
    }
    if (fe2.text.length < 1) {
        
        [MMProgressHUD dismissWithError:@"请输入新密码"];
        
        return;
    }
    if (fe3.text.length < 1) {
        
        [MMProgressHUD dismissWithError:@"请确认新密码"];
        
        return;
    }
    if (![fe2.text isEqualToString:fe3.text]) {
        
        [MMProgressHUD dismissWithError:@"两次密码输入不一致"];
        
        return;
        
    }
    
    
    
    
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"member",@"editPw",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    [parameters setValue:sigString forKey:@"sig"];

    [parameters setValue:fe.text forKey:@"lastPw"];

    [parameters setValue:fe2.text forKey:@"newPw"];

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
                                      
                                      
                                      [MMProgressHUD dismissWithSuccess:@"修改密码成功"];
                                      
                                      
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
