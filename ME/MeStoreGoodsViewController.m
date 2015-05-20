//
//  MeStoreGoodsViewController.m
//  POOL
//
//  Created by king on 15-3-7.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeStoreGoodsViewController.h"

@interface MeStoreGoodsViewController ()

@end

@implementation MeStoreGoodsViewController


@synthesize goodStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = goodStr;
    
    [self showBack];
    
    _tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"名称",@"介绍",@"价格", nil];
    
    UIImageView *mv=  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    mv.image = [UIImage imageNamed:@"demo"];
    _tableView.tableHeaderView = mv;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确认支付" forState:UIControlStateNormal];
    btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    btn.frame = CGRectMake(20, 360, SCREEN_WIDTH - 40, 40);
    [btn addTarget:self action:@selector(yesClicked) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:btn];
    
    // Do any additional setup after loading the view.
}

- (void)yesClicked{
    
    NSLog(@"确认");
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
