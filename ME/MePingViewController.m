//
//  MePingViewController.m
//  POOL
//
//  Created by king on 15/3/30.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MePingViewController.h"

@interface MePingViewController ()

@end

@implementation MePingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"竞技等级评价";
    
    [self showBack];
    
    
    UIImageView *upView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    upView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 100, 20)];
    lab.font = [UIFont systemFontOfSize:14];
    lab.text = @"五星咖啡球选手";
    lab.textColor = [UIColor grayColor];
    [upView addSubview:lab];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(120 + i * 30, 70, 18, 18)];
        mv.image = [UIImage imageNamed:@"icon_xing_kong"];
        [upView addSubview:mv];
        
        
        UIImageView *mv2 = [[UIImageView alloc]initWithFrame:CGRectMake(120 + i * 30, 70, 18, 18)];
        mv2.image = [UIImage imageNamed:@"icon_xing_shi"];
        [upView addSubview:mv2];
    }
    
    
    
    NSArray *array = [NSArray arrayWithObjects:@"技能",@"得分", nil];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 * idx, 100, SCREEN_WIDTH/2, 40)];
        lab.backgroundColor = R_G_B_COLOR(161, 169, 187);
        lab.font = [UIFont systemFontOfSize:14];
        lab.text = obj;
        lab.textAlignment = NSTextAlignmentCenter;
        [upView addSubview:lab];
        
        
        
    }];
    
    NSArray *arr = [NSArray arrayWithObjects:@"击球准度",@"杆法运用",@"线路走位",@"稳定性",@"局面控制",@"心理素质", nil];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
     
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 140 + idx * 50, SCREEN_WIDTH/2, 40)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = obj;
        lab.font = [UIFont systemFontOfSize:14];
        [upView addSubview:lab];
        
        UIImageView *li = [[UIImageView alloc]initWithFrame:CGRectMake(0, 185 + idx * 50, SCREEN_WIDTH, 1)];
        li.backgroundColor = R_G_B_COLOR(221, 221, 221);
        [upView addSubview:li];
        
        
        for (int i = 0; i < 5; i++) {

            UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(160 + i * 30, 150 + idx * 50, 18, 18)];
            mv.image = [UIImage imageNamed:@"icon_xing_kong"];
            [upView addSubview:mv];

        }
        
        for (int i = 0; i < 3; i++) {
            
            UIImageView *mv = [[UIImageView alloc]initWithFrame:CGRectMake(160 + i * 30, 150 + idx * 50, 18, 18)];
            mv.image = [UIImage imageNamed:@"icon_xing_shi"];
            [upView addSubview:mv];
            
        }
        
        
    }];
    
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = upView;
    
    _dataArray = [NSMutableArray array];
    
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *myCell = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    
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
