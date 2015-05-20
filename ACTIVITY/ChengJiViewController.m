//
//  ChengJiViewController.m
//  POOL
//
//  Created by king on 15/5/14.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChengJiViewController.h"

#import "ChengOneCell.h"

#import "ChengTwoCell.h"

#import "ChengFourCell.h"

#import "ChengEightTableViewCell.h"

#import "ChengOneSixCell.h"

#import "ChengThreeTwoCell.h"



#import "WTRequestCenter.h"

#import "ChengJiUserModel.h"


#import "JingDengViewController.h"


#import "UIImageView+WebCache.h"

@interface ChengJiViewController (){
    
    NSMutableArray *champion;
    
    NSMutableArray *runnerup;
    
    NSMutableArray *strong4;
    
    NSMutableArray *strong8;
    
    NSMutableArray *strong16;
    
    NSMutableArray *strong32;

    NSMutableArray *strong64;

}

@end

@implementation ChengJiViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.myTitleLabel.text = _titleString;
    
    champion = [NSMutableArray array];
    runnerup = [NSMutableArray array];
    strong4 = [NSMutableArray array];
    strong8 = [NSMutableArray array];
    strong16 = [NSMutableArray array];
    strong32 = [NSMutableArray array];
    strong64 = [NSMutableArray array];
    
    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(X_OFF_SET, NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    [self.view addSubview:_tableView];
    
    [self requestList];
    
    // Do any additional setup after loading the view.
}

- (void)requestList{
    
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSString *sigString =@"";
    
    
#pragma mark 更改算法!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    
    if ([def objectForKey:USER_NAME]) {
        
        sigString = [[NSString stringWithFormat:@"%@%d%@%@",sysString,CURRENT_TIME,CURRENT_SIGN_KEY,[def objectForKey:CURRENT_AUTH_KEY]]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }else{
        
        sigString = [[NSString stringWithFormat:@"%@%d%@",sigString,CURRENT_TIME,CURRENT_SIGN_KEY]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }
    
    sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
    
    NSLog(@"two=============%@",sigString);
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"scoreView",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
 
    [parameters setValue:sigString forKey:@"sig"];
    
    [parameters setValue:_activityIDStr forKey:@"activityId"];
    
    
    NSLog(@"========%@",url);
    NSLog(@"========%@",parameters);
    
    [WTRequestCenter postWithURL:url
                      parameters:parameters completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                          
                          if (!error) {
                              NSError *jsonError = nil;
                              
                              id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
                              
                              if (!jsonError) {
                                  
                                  NSDictionary *dic = (NSDictionary *)obj;
                                  
                                  NSLog(@"%@",dic);
                                  
                                  
                                  NSString *state = [dic objectForKey:@"code"];
                                  int a = [state intValue];
                                  NSLog(@"%d",a);
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismiss];
                                      
                                      NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                      
                                      NSDictionary *dataDic = [dic objectForKey:@"data"];
                                      
                                      NSLog(@"%@",dataDic);
                                      
                                      NSArray *userArray = [dataDic objectForKey:@"userList"];
                                      
                                      for (NSDictionary *diction in userArray) {
                                   
                                          ChengJiUserModel *model = [[ChengJiUserModel alloc]init];
                                          model.userIdString = [NSString stringWithFormat:@"%@",[diction objectForKey:@"uid"]];
                                          model.userRank = [NSString stringWithFormat:@"%@",[diction objectForKey:@"applyUserRanking"]];
                                          model.nameString = [NSString stringWithFormat:@"%@",[diction objectForKey:@"nickName"]];
                                          model.avatar = [NSString stringWithFormat:@"%@",[diction objectForKey:@"avatar"]];
                                          
                                          if ([model.userRank isEqualToString:@"champion"]) {
                                              [champion addObject:model];
                                          }
                                          if ([model.userRank isEqualToString:@"runnerup"]) {
                                              [runnerup addObject:model];
                                          }
                                          if ([model.userRank isEqualToString:@"strong4"]) {
                                              [strong4 addObject:model];
                                          }
                                          if ([model.userRank isEqualToString:@"strong8"]) {
                                              [strong8 addObject:model];
                                          }
                                          if ([model.userRank isEqualToString:@"strong16"]) {
                                              [strong16 addObject:model];
                                          }
                                          if ([model.userRank isEqualToString:@"strong32"]) {
                                              [strong32 addObject:model];
                                          }
                                          if ([model.userRank isEqualToString:@"strong64"]) {
                                              [strong64 addObject:model];
                                          }
                                          
                                          
                                      }
                                      
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismiss];
                                      
                                  }
                                  
                                  [_tableView reloadData];
                                  
                              }else
                              {
                                  NSLog(@"jsonError:%@",jsonError);
                                  [MMProgressHUD dismiss];
                                  
                              }
                              
                          }else
                          {
                              NSLog(@"error:%@",error);
                              [MMProgressHUD dismiss];
                              
                          }
                          
                      }];
    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 6;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        ChengOneCell *cell = [[ChengOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.selectionStyle = 0;
        
        cell.stat.text = @"冠军";
        
        if (champion.count > 0) {
            
            ChengJiUserModel *model = (ChengJiUserModel *)[champion lastObject];
            
            UIImageView *m1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 30, 30)];
            [m1 sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
            if (model.avatar.length < 10) {
                m1.image = [UIImage imageNamed:@"icon_tx"];
            }
            m1.layer.cornerRadius = 15;
            m1.layer.masksToBounds = YES;
            [cell addSubview:m1];
           
            
            UILabel *namLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, 30, 20)];
            namLab.textAlignment = NSTextAlignmentCenter;
            namLab.font = [UIFont systemFontOfSize:12];
            namLab.textColor = [UIColor grayColor];
            namLab.text = model.nameString;
            [cell addSubview:namLab];
            
            
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.frame = CGRectMake(SCREEN_WIDTH/2, 10, 30, 30);
            imgBtn.layer.cornerRadius = 15;
            imgBtn.layer.masksToBounds = YES;
            [imgBtn setImage:m1.image forState:UIControlStateNormal];
            [imgBtn setTitle:model.userIdString forState:UIControlStateNormal];
            [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [imgBtn addTarget:self action:@selector(tiaozhuan:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:imgBtn];
        }
        
   
        
        
        
        return cell;
        
    }

    if (indexPath.row == 1) {
        
        ChengOneCell *cell = [[ChengOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.stat.text = @"亚军";
        
        cell.selectionStyle = 0;
        
        if (runnerup.count > 0) {
            
            ChengJiUserModel *model = (ChengJiUserModel *)[runnerup lastObject];
            
            UIImageView *m1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 30, 30)];
            [m1 sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
            if (model.avatar.length < 10) {
                m1.image = [UIImage imageNamed:@"icon_tx"];
            }
            m1.layer.cornerRadius = 15;
            m1.layer.masksToBounds = YES;
            [cell addSubview:m1];
            
            UILabel *namLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, 30, 20)];
            namLab.textAlignment = NSTextAlignmentCenter;
            namLab.font = [UIFont systemFontOfSize:12];
            namLab.textColor = [UIColor grayColor];
            namLab.text = model.nameString;
            [cell addSubview:namLab];
            

            
            
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.frame = CGRectMake(SCREEN_WIDTH/2, 10, 30, 30);
            imgBtn.layer.cornerRadius = 15;
            imgBtn.layer.masksToBounds = YES;
            [imgBtn setImage:m1.image forState:UIControlStateNormal];
            [imgBtn setTitle:model.userIdString forState:UIControlStateNormal];
            [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            [imgBtn addTarget:self action:@selector(tiaozhuan:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:imgBtn];
            

        }
        
        return cell;
        
    }
    
    if (indexPath.row == 2) {
        
        ChengOneCell *cell = [[ChengOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.stat.text = @"4强";
        
        cell.selectionStyle = 0;

        if (strong4.count > 0) {
            
            [strong4 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                ChengJiUserModel *model = (ChengJiUserModel *)obj;
                UIImageView *m1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 30, 30)];
                [m1 sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
                if (model.avatar.length < 10) {
                    m1.image = [UIImage imageNamed:@"icon_tx"];
                }
                m1.layer.cornerRadius = 15;
                m1.layer.masksToBounds = YES;
                [cell addSubview:m1];
                
                
                UILabel *namLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, 30, 20)];
                namLab.textAlignment = NSTextAlignmentCenter;
                namLab.font = [UIFont systemFontOfSize:12];
                namLab.textColor = [UIColor grayColor];
                namLab.text = model.nameString;
                [namLab sizeToFit];
                [cell addSubview:namLab];
                

                
                UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                imgBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 40 + idx * 40, 10, 30, 30);
                imgBtn.layer.cornerRadius = 15;
                imgBtn.layer.masksToBounds = YES;
                [imgBtn setImage:m1.image forState:UIControlStateNormal];
                [imgBtn setTitle:model.userIdString forState:UIControlStateNormal];
                [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [imgBtn addTarget:self action:@selector(tiaozhuan:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:imgBtn];
                
                
            }];
            

        }
        
        
        return cell;
        
    }else if (indexPath.row == 3){
        
        
        ChengOneCell *cell = [[ChengOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.stat.text = @"8强";
        
        cell.selectionStyle = 0;
        
        if (strong8.count > 0) {
            
            [strong8 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                ChengJiUserModel *model = (ChengJiUserModel *)[strong4 lastObject];
                
                UIImageView *m1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 30, 30)];
                [m1 sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
                if (model.avatar.length < 10) {
                    m1.image = [UIImage imageNamed:@"icon_tx"];
                }
                m1.layer.cornerRadius = 15;
                m1.layer.masksToBounds = YES;
                [cell addSubview:m1];
                
                
                UILabel *namLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, 30, 20)];
                namLab.textAlignment = NSTextAlignmentCenter;
                namLab.font = [UIFont systemFontOfSize:12];
                namLab.textColor = [UIColor grayColor];
                namLab.text = model.nameString;
                [namLab sizeToFit];

                [cell addSubview:namLab];
                

                
                
                UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                imgBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 80, 10, 30, 30);
                imgBtn.layer.cornerRadius = 15;
                imgBtn.layer.masksToBounds = YES;
                [imgBtn setImage:m1.image forState:UIControlStateNormal];
                [imgBtn setTitle:model.userIdString forState:UIControlStateNormal];
                [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [imgBtn addTarget:self action:@selector(tiaozhuan:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:imgBtn];
                
            }];
            
        }
        
        return cell;

        
    }else if (indexPath.row == 4){
        
        
        ChengOneCell *cell = [[ChengOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.stat.text = @"16强";
        
        cell.selectionStyle = 0;
        
        if (strong8.count > 0) {
            
            [strong8 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                ChengJiUserModel *model = (ChengJiUserModel *)[strong4 lastObject];
                
                UIImageView *m1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 30, 30)];
                [m1 sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
                if (model.avatar.length < 10) {
                    m1.image = [UIImage imageNamed:@"icon_tx"];
                }
                m1.layer.cornerRadius = 15;
                m1.layer.masksToBounds = YES;
                [cell addSubview:m1];
                
                
                
                UILabel *namLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, 30, 20)];
                namLab.textAlignment = NSTextAlignmentCenter;
                namLab.font = [UIFont systemFontOfSize:12];
                namLab.textColor = [UIColor grayColor];
                namLab.text = model.nameString;
                [namLab sizeToFit];
                [cell addSubview:namLab];
                

                
                
                UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                imgBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 80, 10, 30, 30);
                imgBtn.layer.cornerRadius = 15;
                imgBtn.layer.masksToBounds = YES;
                [imgBtn setImage:m1.image forState:UIControlStateNormal];
                [imgBtn setTitle:model.userIdString forState:UIControlStateNormal];
                [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [imgBtn addTarget:self action:@selector(tiaozhuan:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:imgBtn];
                
            }];
            
        }
        
        return cell;
        
        
    }
    else{
        
        ChengOneCell *cell = [[ChengOneCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.stat.text = @"32强";
        
        cell.selectionStyle = 0;
        
        if (strong8.count > 0) {
            
            [strong8 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                ChengJiUserModel *model = (ChengJiUserModel *)[strong4 lastObject];
                
                UIImageView *m1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, 30, 30)];
                [m1 sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
                if (model.avatar.length < 10) {
                    m1.image = [UIImage imageNamed:@"icon_tx"];
                }
                m1.layer.cornerRadius = 15;
                m1.layer.masksToBounds = YES;
                [cell addSubview:m1];
                
                
                UILabel *namLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 40, 30, 20)];
                namLab.textAlignment = NSTextAlignmentCenter;
                namLab.font = [UIFont systemFontOfSize:12];
                namLab.textColor = [UIColor grayColor];
                namLab.text = model.nameString;
                [namLab sizeToFit];
                [cell addSubview:namLab];
                

                
                
                UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                imgBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 80, 10, 30, 30);
                imgBtn.layer.cornerRadius = 15;
                imgBtn.layer.masksToBounds = YES;
                [imgBtn setImage:m1.image forState:UIControlStateNormal];
                [imgBtn setTitle:model.userIdString forState:UIControlStateNormal];
                [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [imgBtn addTarget:self action:@selector(tiaozhuan:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:imgBtn];
                
            }];
            
        }
    
        return cell;
        
    }
    
    
}


- (void)tiaozhuan:(UIButton *)button{
    
    JingDengViewController *deng = [[JingDengViewController alloc]init];
    deng.activID = _activityIDStr;
    deng.persionIDStr = button.titleLabel.text;
    [self.navigationController pushViewController:deng animated:YES];
    
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
