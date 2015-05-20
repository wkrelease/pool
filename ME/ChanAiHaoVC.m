//
//  ChanAiHaoVC.m
//  POOL
//
//  Created by king on 15/5/17.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChanAiHaoVC.h"

@interface ChanAiHaoVC ()

@end

@implementation ChanAiHaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"爱好";
    
    [self showBack];
    
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
