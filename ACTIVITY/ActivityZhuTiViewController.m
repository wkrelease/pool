//
//  ActivityZhuTiViewController.m
//  POOL
//
//  Created by king on 15/3/21.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ActivityZhuTiViewController.h"

@interface ActivityZhuTiViewController (){
    
    UITextField *na;
    
}

@end

@implementation ActivityZhuTiViewController


- (void)callBack:(void (^)(NSString *))myBlock{
    
    _callBack = myBlock;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.myTitleLabel.text = @"活动主题";
    
    [self showBack];
    
    UIImageView *bv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 40)];
    bv.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bv];
    
    na = [[UITextField alloc]initWithFrame:CGRectMake(20, 85, SCREEN_WIDTH - 40, 30)];
    na.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:na];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hi)];
    [self.view addGestureRecognizer:tap];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 60, 34, 50, 20);
    [btn addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.navView addSubview:btn];
    
 
    

    // Do any additional setup after loading the view.
}

- (void)queding{
    
    _callBack(na.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)hi{
    
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
