//
//  RegisterViewController.m
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "RegisterViewController.h"
#import "WTRequestCenter.h"
#import "RegAddressViewController.h"


#import <SMS_SDK/SMS_SDK.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    self.myTitleLabel.text = @"注册";
    
    [self showBack];
    
    for (int i = 0; i < 2; i++) {
        
        UIImageView *upView = [[UIImageView alloc]initWithFrame:CGRectMake(X_OFF_SET, 74 + i * 90, SCREEN_WIDTH, 80)];
        upView.backgroundColor = [UIColor whiteColor];
        upView.userInteractionEnabled = YES;
        [self.view addSubview:upView];
        
        UIImageView *myBi = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 16, 16)];
        if (i == 0) {
            myBi.image = [UIImage imageNamed:@"icon_zhanghao"];
            
            phoneField = [[UITextField alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
            phoneField.placeholder = @"请输入手机号";
            phoneField.font = [UIFont systemFontOfSize:14];
            [upView addSubview:phoneField];
            
            phonePassField = [[UITextField alloc]initWithFrame:CGRectMake(40, 50, 200, 20)];
            phonePassField.placeholder = @"请输入手机获取的验证码";
            phonePassField.font = [UIFont systemFontOfSize:14];
            [upView addSubview:phonePassField];
            
            
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH - 80, 10, 80, 20);
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn setTitleColor:R_G_B_COLOR(50, 221, 161) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [upView addSubview:btn];
            
            
        }else{
            myBi.image = [UIImage imageNamed:@"icon_mima"];
            
            passField = [[UITextField alloc]initWithFrame:CGRectMake(40, 10, 200, 20)];
            passField.placeholder = @"请输入密码";
            passField.secureTextEntry = YES;
            passField.font = [UIFont systemFontOfSize:14];
            [upView addSubview:passField];
            
            passTwoField = [[UITextField alloc]initWithFrame:CGRectMake(40, 50, 200, 20)];
            passTwoField.placeholder = @"请确认密码";
            passTwoField.font = [UIFont systemFontOfSize:14];
            passTwoField.secureTextEntry = YES;
            [upView addSubview:passTwoField];
            
            
        }
        [upView addSubview:myBi];
        
        UIImageView *lin = [[UIImageView alloc]initWithFrame:CGRectMake(40, 39.5, SCREEN_WIDTH - 40, 0.5)];
        lin.backgroundColor = [UIColor lightGrayColor];
        [upView addSubview:lin];
    }
    
    
    
    UIImageView *nameView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 255, SCREEN_WIDTH, 40)];
    nameView.backgroundColor = [UIColor whiteColor];
    nameView.userInteractionEnabled = YES;
    [self.view addSubview:nameView];
    
    UILabel *n = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 20)];
    n.text = @"昵称:";
    n.textColor = [UIColor lightGrayColor];
    n.font = [UIFont systemFontOfSize:14];
    [nameView addSubview:n];
    
    namField = [[UITextField alloc]initWithFrame:CGRectMake(80, 10, 100, 20)];
    namField.backgroundColor = [UIColor whiteColor];
    namField.placeholder = @"请输入昵称";
    namField.font = [UIFont systemFontOfSize:14];
    namField.textColor = [UIColor lightGrayColor];
    [nameView addSubview:namField];
    
    
    UIButton *wan = [UIButton buttonWithType:UIButtonTypeCustom];
    wan.frame = CGRectMake(10, 380, SCREEN_WIDTH - 20, 35);
    [wan setTitle:@"完成" forState:UIControlStateNormal];
    wan.titleLabel.font = [UIFont systemFontOfSize:13];
    [wan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wan.backgroundColor = R_G_B_COLOR(50, 221, 161);
    [wan addTarget:self action:@selector(wancheng) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wan];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"男",@"女",nil];
    UISegmentedControl *control = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    control.frame = CGRectMake(SCREEN_WIDTH - 110, 5, 100, 30);
    control.selectedSegmentIndex = 0;//设置默认选择项索引
    control.segmentedControlStyle = UISegmentedControlStylePlain;//设置样式
    [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventValueChanged];
    [nameView addSubview:control];

    sexString = @"1";
    addressCodeString = @"11000";

    
    UIImageView *addView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, 40)];
    addView.backgroundColor = [UIColor whiteColor];
    addView.userInteractionEnabled = YES;
    [self.view addSubview:addView];
    
    UILabel *add = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    add.text = @"居住地城市:";
    add.font = [UIFont systemFontOfSize:14];
    add.textColor = [UIColor lightGrayColor];
    [addView addSubview:add];
    
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 20)];
    addressLabel.font = [UIFont systemFontOfSize:14];
    addressLabel.textColor = [UIColor lightGrayColor];
    [addView addSubview:addressLabel];
    
    UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressClick)];
    [addView addGestureRecognizer:addTap];
    
    
    UITapGestureRecognizer *baTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHidden)];
    [self.view addGestureRecognizer:baTap];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

- (void)createPicker{
    
    TSLocateView *locateView = [[TSLocateView alloc] initWithTitle:@"定位城市" delegate:self];
    locateView.backgroundColor = [UIColor whiteColor];
    [locateView showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TSLocateView *locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    
    
    NSLog(@"%@====",location.state);
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        
        addressLabel.text = [NSString stringWithFormat:@"%@%@",location.state,location.city];
        

    }
    
    
    
}



- (void)addressClick{
    
//    RegAddressViewController *reg = [[RegAddressViewController alloc]init];
//    [self.navigationController pushViewController:reg animated:YES];
    
    
    [self createPicker];
}


- (void)controlClick:(UISegmentedControl *)con{
    
    NSInteger Index = con.selectedSegmentIndex;
    
    NSLog(@"Index %li", (long)Index);
    
    if (Index == 0) {

        sexString = @"1";
        
    }else{
        
        sexString = @"2";
        
    }
    
    
    
}



- (void)btnClick{
    
    if (phoneField.text.length < 1) {
        
        [MMProgressHUD showWithStatus:@"正在刷新"];
        [MMProgressHUD dismissWithError:@"手机号为空"];
        
    }else{
        
        [self.view endEditing:YES];
        [self sendMessage];
        [self nextStep];

    }
    

    
}

- (void)sendMessage{
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    
//    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@",CURRENT_UUID,CURRENT_API,CURRENT_TIME,phoneField.text];
    


    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d||",CURRENT_UUID,CURRENT_API,CURRENT_TIME];
    
    NSLog(@"%@",sysString);
    
    /******
     *a
     *c
     *sys
     ******
     */
    
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
    NSString *sigString = [NSString stringWithFormat:@"%@%@%@%@",@"sendSms",@"member",phoneField.text,sysString];
    
    
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
    
    
    NSString *str = [NSString stringWithFormat:@"%@?c=member&a=sendSms&sys=%@&sig=%@&mobileNumber=%@",DEBUG_HOST_URL,sysString,sigString,phoneField.text];
    
    NSLog(@"%@",str);
    
    
    
    
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?c=%@&a=%@&sig=%@&sys=%@",DEBUG_HOST_URL,@"member",@"sendSms",sigString,sysString]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"member",@"sendSms",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURL *url = [NSURL URLWithString:urlStringUse];

    NSLog(@"----------------------------%@",urlString);
    NSLog(@"----------------------------%@",urlStringUse);

    NSLog(@"----------------------------%@",url);
    
    
    
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?sig=%@",DEBUG_HOST_URL,sigString]];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
//    [parameters setValue:@"member" forKey:@"c"];
//    [parameters setValue:@"sendSms" forKey:@"a"];
//    [parameters setValue:sysString forKey:@"sys"];
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:phoneField.text forKey:@"mobileNumber"];
    
    
    
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
    
    
    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//
//    [request setPostValue:@"member" forKey:@"c"];
//    [request setPostValue:@"sendSms" forKey:@"a"];
//    [request setPostValue:sysString forKey:@"sys"];
//    //    [parameters setValue:sigString forKey:@"sig"];
//    [request setPostValue:phoneField.text forKey:@"mobileNumber"];
//    
//    [request setDelegate:self];
//    [request startAsynchronous];

    

    
}





- (void)wancheng{
    
    [self.view endEditing:YES];
    
    NSLog(@"完成");
    
    if (phoneField.text.length > 0) {
        
        if (passField.text.length > 0) {
            
            if ([passField.text isEqualToString:passTwoField.text]) {
                
                [self registerRequest];
                
            }else{
                
                [MMProgressHUD showWithStatus:@"正在注册"];
                [MMProgressHUD dismissWithError:@"两次密码输入不一致"];
                
            }
            
        }else{
            
            [MMProgressHUD showWithStatus:@"正在注册"];
            [MMProgressHUD dismissWithError:@"请填写密码"];
            
        }
        
    }else{
        
        [MMProgressHUD showWithStatus:@"正在注册"];
        [MMProgressHUD dismissWithError:@"请填写正确的手机号"];
        
    }
    
    
    
    
}

- (void)registerRequest{
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"member",@"registerSubmit",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSLog(@"----------------------------%@",urlString);
    NSLog(@"----------------------------%@",urlStringUse);
    NSLog(@"----------------------------%@",url);
    
    
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?sig=%@",DEBUG_HOST_URL,sigString]];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:phoneField.text forKey:@"mobileNumber"];
    [parameters setValue:passField.text forKey:@"password"];
    [parameters setValue:@"1234" forKey:@"secCode"];
    [parameters setValue:namField.text forKey:@"nickName"];
    [parameters setValue:sexString forKey:@"gender"];
    [parameters setValue:addressCodeString forKey:@"resideCityCode"];
    
  
    
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




- (void)keyBoardHidden{
    
    [self.view endEditing:YES];
    
}









-(void)nextStep
{
    
    [SMS_SDK getVerificationCodeBySMSWithPhone:@"15001028735"
                                          zone:@"+86"
                                        result:^(SMS_SDKError *error)
     {
         if (!error)
         {
             
             //             已经发送
             
         }
         else
         {
             UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                           message:[NSString stringWithFormat:@"状态码：%zi ,错误描述：%@",error.errorCode,error.errorDescription]
                                                          delegate:self
                                                 cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                 otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }];
    
}


- (void)yan{
    
    
    if(@"1234".length!=4)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil)
                                                      message:NSLocalizedString(@"verifycodeformaterror", nil)
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        //[[SMS_SDK sharedInstance] commitVerifyCode:self.verifyCodeField.text];
        [SMS_SDK commitVerifyCode:@"1234" result:^(enum SMS_ResponseState state) {
            if (1==state)
            {
                NSLog(@"验证成功");
                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"verifycoderightmsg", nil)];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verifycoderighttitle", nil)
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                    otherButtonTitles:nil, nil];
                [alert show];
                
            }
            else if(0==state)
            {
                NSLog(@"验证失败");
                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"verifycodeerrormsg", nil)];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verifycodeerrortitle", nil)
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                    otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
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
