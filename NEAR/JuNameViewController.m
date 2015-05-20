//
//  JuNameViewController.m
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuNameViewController.h"

@interface JuNameViewController ()

@end

@implementation JuNameViewController

- (void)callBackName:(void (^)(NSString *))myName{
    
    _callBackName = myName;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"名称";
    
    [self showBack];

    
    name = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH , 40)];
    name.font = [UIFont systemFontOfSize:13];
    name.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:name];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定 " forState:UIControlStateNormal];
    btn.frame = CGRectMake(SCREEN_WIDTH - 55, 35, 40, 20);
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(yesClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:btn];
    // Do any additional setup after loading the view.
}


- (void)yesClick{
    
    
    _callBackName(name.text);
    
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
