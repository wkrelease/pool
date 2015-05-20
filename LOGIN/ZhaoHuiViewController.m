//
//  ZhaoHuiViewController.m
//  POOL
//
//  Created by king on 15/3/30.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ZhaoHuiViewController.h"

#import "YanZhengViewController.h"

@interface ZhaoHuiViewController ()

@end

@implementation ZhaoHuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBack];
    
    self.myTitleLabel.text = @"找回密码";
    
    self.view.backgroundColor = R_G_B_COLOR(236, 236, 236);
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 40)];
    field.placeholder = @"输入注册时的手机号";
    field.font = [UIFont systemFontOfSize:14];
    field.layer.borderWidth = 1;
    field.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:field];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(xiayibu) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];

    btn.frame = CGRectMake(20, 150, SCREEN_WIDTH - 40, 40);
    btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    [self.view addSubview:btn];
    
    // Do any additional setup after loading the view.
}

- (void)xiayibu{
    
    YanZhengViewController *yan = [[YanZhengViewController alloc]init];
    [self.navigationController pushViewController:yan animated:YES];
    
}


- (void)viewTap{
    
    [self.view endEditing:YES];
    
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
