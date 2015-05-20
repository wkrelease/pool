//
//  LoginViewController.m
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RootViewController.h"

#import "ZhaoHuiViewController.h"

#import "WTRequestCenter.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
    self.myTitleLabel.text = @"登录";
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView *baView = [[UIImageView alloc]initWithFrame:CGRectMake(X_OFF_SET, NAV_HEIGHT + 20 + i * 40, SCREEN_WIDTH, 39)];
        baView.backgroundColor = [UIColor whiteColor];
        baView.userInteractionEnabled = YES;
        
        [self.view addSubview:baView];
        
        UIImageView *biao = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 16, 16)];
        if (i == 0) {
            biao.image = [UIImage imageNamed:@"icon_zhanghao"];
            
            _nameField = [[UITextField alloc]initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH - 100, 20)];
            _nameField.placeholder = @"请输入手机号";
            _nameField.delegate = self;
            _nameField.font = [UIFont systemFontOfSize:14];
            _nameField.clearButtonMode = UITextFieldViewModeAlways;
            _nameField.keyboardType = UIKeyboardTypeNumberPad;
            [baView addSubview:_nameField];

            
        }else{
            biao.image = [UIImage imageNamed:@"icon_mima"];
            
            _passWordField = [[UITextField alloc]initWithFrame:CGRectMake(40, 10, SCREEN_WIDTH - 100, 20)];
            _passWordField.delegate = self;
            _passWordField.placeholder = @"请输入密码";
            _passWordField.secureTextEntry = YES;
            _passWordField.font = [UIFont systemFontOfSize:14];
            _passWordField.clearButtonMode = UITextFieldViewModeAlways;
            [baView addSubview:_passWordField];

        }
        [baView addSubview:biao];
        
        
    }
    
    
    UIButton *_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.frame = CGRectMake(10, 210, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:_loginBtn];
    
    
    UIButton *_regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _regBtn.backgroundColor = [UIColor clearColor];
    [_regBtn setTitle:@"注册" forState:UIControlStateNormal];
    _regBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _regBtn.layer.borderWidth = 0.5;
    _regBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_regBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_regBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    _regBtn.frame = CGRectMake(10, 260, SCREEN_WIDTH - 20, 40);
    [self.view addSubview:_regBtn];
    
    
    UIButton *wang = [UIButton buttonWithType:UIButtonTypeCustom];
    [wang setTitle:@"忘记密码?" forState:UIControlStateNormal];
    wang.frame = CGRectMake(SCREEN_WIDTH - 70, 170, 60, 20);
    wang.titleLabel.font = [UIFont systemFontOfSize:13];
    [wang setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [wang addTarget:self action:@selector(wangji) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wang];
    
    UITapGestureRecognizer *baTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:baTap];
    
    // Do any additional setup after loading the view.
}

- (void)loginClick{
    
    NSLog(@"登录");
    
    if (_nameField.text.length < 1) {
        
        [MMProgressHUD showWithStatus:@"正在登录"];
        [MMProgressHUD dismissWithError:@"请输入手机号"];
        
    }else if (_passWordField.text.length < 1){
        
        [MMProgressHUD showWithStatus:@"正在登录"];
        [MMProgressHUD dismissWithError:@"请输入密码"];
        
    }else{
    
        [self pushController];
        
    }
    
}


- (void)pushController{
    
    [self.view endEditing:YES];
    
    
//        13810011323
//
//    333333
//    _nameField.text =  @"13810011323";
//    _passWordField.text = @"333333";
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    
    //    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@",CURRENT_UUID,CURRENT_API,CURRENT_TIME,phoneField.text];
    
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d||",CURRENT_UUID,CURRENT_API,CURRENT_TIME];
    
    NSLog(@"%@",sysString);
   
    
    NSString *sigString = sysString;
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    if ([def objectForKey:CURRENT_SIGN_KEY]) {
        
        sigString = [[NSString stringWithFormat:@"%@%d%@",sigString,CURRENT_TIME,CURRENT_SIGN_KEY]MD5Hash];

    }else{
        
        sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
        
    }
    
    
    NSLog(@"one=============%@",sigString);
    
    sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
    
    NSLog(@"two=============%@",sigString);
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"member",@"login",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSLog(@"----------------------------%@",urlString);
    NSLog(@"----------------------------%@",urlStringUse);
    
    NSLog(@"----------------------------%@",url);
    
    
    
    NSLog(@"%d",CURRENT_TIME);
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?sig=%@",DEBUG_HOST_URL,sigString]];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    [parameters setValue:@"member" forKey:@"c"];
    //    [parameters setValue:@"sendSms" forKey:@"a"];
    //    [parameters setValue:sysString forKey:@"sys"];
    
    
    NSLog(@"%@",_nameField.text);
    NSLog(@"%@",_passWordField.text);
    NSLog(@"%@",[_passWordField.text MD5Hash]);
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:_nameField.text forKey:@"mobileNumber"];
    [parameters setValue:[_passWordField.text MD5Hash]forKey:@"password"];
    
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
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      NSDictionary *dataDic = [dic objectForKey:@"data"];
                                      
                                      NSLog(@"%@",[dataDic objectForKey:@"authkey"]);
                                      
                                      NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
                                     
                                      [def setObject:_nameField.text forKey:USER_NAME];
                                      
                                      [def setObject:_passWordField.text forKey:USER_PASSWORD];
                                      
                                      [def setObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"authkey"]] forKey:CURRENT_AUTH_KEY];
                                      
                                      [def setObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"authName"]] forKey:HUAN_NAME];
                                      
                                      [def setObject:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"authPwd"]] forKey:HUAN_PASSWORD];
                                      
                                      [def synchronize];
                                      
                                      RootViewController *root = [[RootViewController alloc]init];
                                      [self.navigationController pushViewController:root animated:YES];
                                      

                                      
                                      
                                  }else{
                                      
                                      
                                      NSString *str = [dic objectForKey:@"msg"];
                                      
                                      [MMProgressHUD dismissWithError:str];

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









- (void)registerClick{
    
    NSLog(@"注册");
    
    RegisterViewController *reg = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
    
    
}
- (void)wangji{
    
    NSLog(@"忘记");
    
    ZhaoHuiViewController *hui = [[ZhaoHuiViewController alloc]init];
    [self.navigationController pushViewController:hui animated:YES];
    
}

- (void)keyBoardHidden{
    
    [self.view endEditing:YES];
    
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
