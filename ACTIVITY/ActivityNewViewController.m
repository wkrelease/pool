//
//  ActivityNewViewController.m
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ActivityNewViewController.h"
#import "ActivityNewCell.h"
#import "ActivityModel.h"


#import "ActivityNewMessageViewController.h"

@interface ActivityNewViewController ()

@end

@implementation ActivityNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.myTitleLabel.text = @"新闻资讯";

    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    
    
    _dataArray = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    ActivityNewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[ActivityNewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ActivityNewMessageViewController *mess = [[ActivityNewMessageViewController alloc]init];
    [self.navigationController pushViewController:mess animated:YES];
    
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
