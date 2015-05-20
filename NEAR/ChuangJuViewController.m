//
//  ChuangJuViewController.m
//  POOL
//
//  Created by king on 15-3-5.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChuangJuViewController.h"

#import "JuNameViewController.h"
#import "JuClassViewController.h"
#import "JuXuanViewController.h"
#import "JuMessageViewController.h"
#import "JuAddressViewController.h"

#import "ImgPhotoCell.h"


#import "WTRequestCenter.h"

@interface ChuangJuViewController ()

@end

@implementation ChuangJuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"创建俱乐部";
    
    
    [self showBack];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"名称",@"类型",@"宣言",@"说明",@"地址",@"照片", nil];
    
    _imgArray = [NSMutableArray array];
    
    
    nameField = [[UITextField alloc]initWithFrame:CGRectMake(100, 25, SCREEN_WIDTH - 130, 20)];
    nameField.placeholder = @"请输入名称";
    nameField.font = [UIFont systemFontOfSize:14];
    nameField.backgroundColor = [UIColor clearColor];
    nameField.textAlignment = NSTextAlignmentRight;
    nameField.enabled = NO;
    [_tableView addSubview:nameField];
    
    classField = [[UITextField alloc]initWithFrame:CGRectMake(100, 75, SCREEN_WIDTH - 130, 20)];
    classField.placeholder = @"台球";
    classField.enabled = NO;
    classField.font = [UIFont systemFontOfSize:14];
    classField.textAlignment = NSTextAlignmentRight;
    classField.backgroundColor = [UIColor clearColor];
    [_tableView addSubview:classField];
    
    xuanLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 125, SCREEN_WIDTH -130, 20)];
    xuanLabel.textAlignment = NSTextAlignmentRight;
    xuanLabel.font = [UIFont systemFontOfSize:13];
    xuanLabel.backgroundColor = [UIColor clearColor];
    xuanLabel.textColor = [UIColor grayColor];
    [_tableView addSubview:xuanLabel];

    mess = [[UILabel alloc]initWithFrame:CGRectMake(60, 180, SCREEN_WIDTH - 100, 40)];
    mess.backgroundColor = [UIColor clearColor];
    mess.textColor = [UIColor grayColor];
    mess.font = [UIFont systemFontOfSize:13];
    [_tableView addSubview:mess];
    
    
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 260, SCREEN_WIDTH - 100, 40)];
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.numberOfLines = 3;
    addressLabel.font = [UIFont systemFontOfSize:13];
    addressLabel.textColor = [UIColor grayColor];
    [_tableView addSubview:addressLabel];
    
    
    
    UIImageView *downView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    downView.backgroundColor = [UIColor clearColor];
    downView.userInteractionEnabled = YES;
    _tableView.tableFooterView = downView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    [btn addTarget:self action:@selector(btnClickdd) forControlEvents:UIControlEventTouchUpInside];
    btn.frame=  CGRectMake(20, 20, SCREEN_WIDTH - 40, 40);
    [downView addSubview:btn];
    
    
    photoTable = [[UITableView alloc]initWithFrame:CGRectMake(130, 250, 80, SCREEN_WIDTH - 100)style:UITableViewStylePlain];
    photoTable.backgroundColor = [UIColor whiteColor];
    photoTable.showsVerticalScrollIndicator = NO;
    photoTable.showsHorizontalScrollIndicator = NO;
    photoTable.bounces = NO;
    
    photoTable.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    [_tableView addSubview:photoTable];
    photoTable.separatorStyle = 0;
    photoTable.delegate = self;
    photoTable.dataSource = self;
    
    //    _tableView.scrollEnabled = NO;
    
    UIImageView *addView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 75)];
    addView.backgroundColor = [UIColor clearColor];
    //    addView.layer.borderWidth = 0.5;
    //    addView.layer.borderColor = R_G_B_COLOR(255, 174, 124).CGColor;
    addView.image = [UIImage imageNamed:@"icon_photo"];
    photoTable.tableFooterView = addView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImage)];
    addView.userInteractionEnabled = YES;
    [addView addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

- (void)addImage{
    
    NSLog(@"add");
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"选择路径" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [sheet showInView:self.view];
    
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 2) {
        return;
    }else{
        
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        
        
        if (buttonIndex == 0) {
            
            if (SIMULATOR) {
                return;
            }else{
                
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            }
            
        }else if (buttonIndex == 1){
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
        }
        
        
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSData *imgData = UIImageJPEGRepresentation(img, 0.1);
    
    [_imgArray addObject:imgData];
    
//    [self postImageData:imgData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [photoTable reloadData];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}








- (void)btnClickdd{
    
    
    NSLog(@"提交");
    
    
    [self requestJU];
    
    
}


- (void)requestJU{
    
    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@|",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];

    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
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
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"group",@"create",sysString];
    
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    

    [parameters setValue:sigString forKey:@"sig"];
    

    [parameters setValue:nameField.text forKey:@"name"];
    [parameters setValue:@"11008" forKey:@"cityCode"];
    [parameters setValue:@"1" forKey:@"category"];
    [parameters setValue:[def objectForKey:USER_LAT] forKey:@"lat"];
    [parameters setValue:[def objectForKey:USER_LONG] forKey:@"lng"];
    [parameters setValue:addressLabel.text forKey:@"area"];
    [parameters setValue:xuanLabel.text forKey:@"intro"];
    [parameters setValue:mess.text forKey:@"announce"];
    
    
    
//    [parameters setValue:@"图片" forKey:@"aids"];
    
    
    
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
                                  NSLog(@"%@",[[dic objectForKey:@"data"]class]);
                                  NSDictionary *dataDic = [dic objectForKey:@"data"];
                                  NSLog(@"%@",[dic objectForKey:@"msg"]);
                                  NSLog(@"%@",dataDic);
                           
                                  
                                  if (a == 0) {
                                      
                                      [MMProgressHUD dismissWithSuccess:@"创建俱乐部成功"];
                                      
                                      [self.navigationController popViewControllerAnimated:YES];
                                      
                                      
                                  }else{
                                      
                                      [MMProgressHUD dismissWithError:@"创建俱乐部失败"];
                                      
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





#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView]) {
     
        return _dataArray.count;

    }else{
        
        return _imgArray.count;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        
        
        if (indexPath.row == 3) {
            return 80;
        }else if (indexPath.row == 4){
            
            return 80;
            
        }else if (indexPath.row == 5){
            
            return 80;
            
        }
        else{
            
            return 50;
            
        }

    }else{
        
        return 100;
        
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([tableView isEqual:_tableView]) {
        
        static NSString *myCell = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        }
        
        
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
        
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
        
        
    }else{
        
        
        static NSString *myCell = @"cell";
        
        ImgPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        
        if (cell == nil) {
            cell = [[ImgPhotoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        }
        
        cell.selectionStyle = 0;
        
        cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
        
        cell.image.image = [UIImage imageWithData:[_imgArray objectAtIndex:indexPath.row]];
        
        
        return cell;

    }
    
   
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView isEqual:_tableView]) {
        
        
        if (indexPath.row == 0) {
            
            JuNameViewController *nam = [[JuNameViewController alloc]init];
            
            [nam callBackName:^(NSString *str) {
                
                nameField.text = str;
                
            }];
            
            [self.navigationController pushViewController:nam animated:YES];
            
        }else if (indexPath.row == 1){
            
            JuClassViewController *cla = [[JuClassViewController alloc]init];
            
            [cla callBackClass:^(NSString *claStr) {
                
                classField.text = claStr;
                
            }];
            
            [self.navigationController pushViewController:cla animated:YES];
            
        }else if (indexPath.row == 2){
            
            JuXuanViewController *xuan = [[JuXuanViewController alloc]init];
            [xuan callBackXuan:^(NSString *xuan) {
                
                xuanLabel.text = xuan;
                
            }];
            [self.navigationController pushViewController:xuan animated:YES];
            
        }else if (indexPath.row == 3){
            
            JuMessageViewController *message =  [[JuMessageViewController alloc]init];
            [message callBackMessage:^(NSString *message) {
                
                mess.text = message;
                
            }];
            [self.navigationController pushViewController:message animated:YES];
            
        }else if(indexPath.row == 4){
            
            JuAddressViewController *addre = [[JuAddressViewController alloc]init];
            [addre callBackAdress:^(NSString *str) {
                
                addressLabel.text = str;
                
            }];
            [self.navigationController pushViewController:addre animated:YES];
            
        }
        
        
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView]) {
        
        return 10;
        
    }else{
        
        return 0.1;

    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 1;
    
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
