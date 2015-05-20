//
//  ActivityBiaoViewController.m
//  POOL
//
//  Created by king on 15/3/21.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ActivityBiaoViewController.h"

@interface ActivityBiaoViewController ()

@end

@implementation ActivityBiaoViewController

- (void)callBack:(void (^)(NSString *))myBlock{
    
    _callBack = myBlock;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"活动标签";
    
    [self showBack];

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"台球",@"羽毛球",@"网球",@"乒乓球",@"Golf",@"足球",@"篮球",@"游泳",@"保龄",@"滑雪",@"射箭",@"骑马",@"户外",@"跑步",@"桌游",@"摄影",@"KTV",@"聚餐",@"培训", nil];
    
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    _callBack([NSString stringWithFormat:@"%ld",(long)(indexPath.row + 1)]);
    
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
