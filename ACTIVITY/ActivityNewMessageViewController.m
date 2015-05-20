//
//  ActivityNewMessageViewController.m
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ActivityNewMessageViewController.h"

#import "NewMessCell.h"

#import "newMessModel.h"

@interface ActivityNewMessageViewController ()

@end

@implementation ActivityNewMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"详情";
    
    [self showBack];
    

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    
    
    headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340)];
    headView.backgroundColor = R_G_B_COLOR(233, 233, 233);
    _tableView.tableHeaderView = headView;
    
    UIImageView *headBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 15, SCREEN_WIDTH, 310)];
    headBack.backgroundColor = [UIColor whiteColor];
    [headView addSubview:headBack];
    
    title = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 20)];
    title.font = [UIFont systemFontOfSize:14];
    title.text = @"打桌球一定要选直一些的杆子";
    [headBack addSubview:title];
    
    message = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, SCREEN_WIDTH - 20, 90)];
    message.text = @"打桌球一定要选直一些的杆子打桌球一定要选直一些的杆子打桌球一定要选直一些的杆子打桌球一定要选直一些的杆子打桌球一定要选直一些的杆子打桌球一定要选直一些的杆子打桌球一定要选直一些的杆子";
    message.font = [UIFont systemFontOfSize:13];
    message.numberOfLines = -1;
    message.textColor = [UIColor lightGrayColor];
    message.backgroundColor = [UIColor whiteColor];
    [headBack addSubview:message];
    
    picImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 140, SCREEN_WIDTH-20, 140)];
    picImg.image = [UIImage imageNamed:@"demo"];
    picImg.contentMode = UIViewContentModeScaleAspectFill;
    picImg.clipsToBounds = YES;
    [headBack addSubview:picImg];
    
    oneImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 290, 15, 15)];
    oneImg.image = [UIImage imageNamed:@"demo"];
    [headBack addSubview:oneImg];
    
    numPing = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 286, 60, 20)];
    numPing.text = @"15条评论";
    numPing.font = [UIFont systemFontOfSize:12];
    numPing.textColor = R_G_B_COLOR(220, 220, 220);
    numPing.textAlignment = NSTextAlignmentLeft;
    [headBack addSubview:numPing];
    
    
    
    // Do any additional setup after loading the view.
}

#pragma mark tableviewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myCell = @"cell";
    
    NewMessCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[NewMessCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
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
