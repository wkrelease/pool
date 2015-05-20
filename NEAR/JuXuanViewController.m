//
//  JuXuanViewController.m
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuXuanViewController.h"

@interface JuXuanViewController ()

@end

@implementation JuXuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBack];
    
    self.myTitleLabel.text = @"宣言";
    
    xuanView = [[UITextView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 100)];
    xuanView.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:xuanView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定 " forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 55, 35, 40, 20);
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(yesClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:btn];

    
    // Do any additional setup after loading the view.
}

- (void)callBackXuan:(void (^)(NSString *))myXuan{
    
    _callBackXuan = myXuan;
    
}


- (void)yesClick{
    
    
    _callBackXuan(xuanView.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
