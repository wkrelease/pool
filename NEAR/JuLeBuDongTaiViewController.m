//
//  JuLeBuDongTaiViewController.m
//  POOL
//
//  Created by king on 15/4/4.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuLeBuDongTaiViewController.h"

@interface JuLeBuDongTaiViewController ()

@end

@implementation JuLeBuDongTaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showBack];
    
    
    self.myTitleLabel.text = _name;
    
    
    
    // Do any additional setup after loading the view.
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
