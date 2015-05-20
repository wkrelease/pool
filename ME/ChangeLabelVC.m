//
//  ChangeLabelVC.m
//  POOL
//
//  Created by king on 15/5/17.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChangeLabelVC.h"

@interface ChangeLabelVC ()

@end

@implementation ChangeLabelVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myTitleLabel.text = _theTitle;
    
    [self createVi];
    
    [self showBack];
    
    
    self.view.backgroundColor = R_G_B_COLOR(221, 221, 221);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 60, 30, 55, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:btn];
    
    // Do any additional setup after loading the view.
}

- (void)rightClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)createVi{
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 40)];
    vi.userInteractionEnabled = YES;
    vi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vi];
    
    UITextField *messField = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, 30)];
    messField.placeholder = _theTitle;
    messField.font = [UIFont systemFontOfSize:12];
    [vi addSubview:messField];
    
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
