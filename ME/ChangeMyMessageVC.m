//
//  ChangeMyMessageVC.m
//  POOL
//
//  Created by king on 15/5/17.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChangeMyMessageVC.h"

#import "ActivityZhuTiViewController.h"

#import "ActivityBiaoViewController.h"

#import "XianZhiViewController.h"

#import "faBuCell.h"

#import "JuAddressViewController.h"

#import "FeiYongViewController.h"


#import "WTRequestCenter.h"

#import "ChangeLabelVC.h"


#import "QingGanVC.h"
#import "ChanWantVC.h"
#import "ChanAiHaoVC.h"




@interface ChangeMyMessageVC (){
    
    UITextField *addressField;
    
    NSMutableArray *AIDArray;
    
    int requestTag;
    
    NSString *biaoString;
    
}

@end

@implementation ChangeMyMessageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"编辑资料";
    
    requestTag = 0;
    
    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = CLEARCOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [[NSMutableArray alloc]initWithObjects:@"修改昵称",@"个性签名",@"个人描述",@"情感状态",@"I WANT",@"生日",@"公司",@"职业",@"常住地",@"爱好", nil];
    
    _photoArray = [NSMutableArray array];
    
    AIDArray = [NSMutableArray array];
    
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    headView.userInteractionEnabled = YES;
    
    photoTable = [[UITableView alloc]initWithFrame:CGRectMake(120, -115, 80, SCREEN_WIDTH)style:UITableViewStylePlain];
    photoTable.backgroundColor = [UIColor whiteColor];
    photoTable.showsVerticalScrollIndicator = NO;
    photoTable.showsHorizontalScrollIndicator = NO;
    photoTable.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    photoTable.separatorStyle = 0;
    photoTable.delegate = self;
    photoTable.dataSource = self;
    [headView addSubview:photoTable];
    
    _tableView.tableHeaderView = headView;
    
    UIImageView *addView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 75)];
    addView.backgroundColor = [UIColor clearColor];
    addView.image = [UIImage imageNamed:@"icon_photo"];
    addView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    photoTable.tableFooterView = addView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImage)];
    addView.userInteractionEnabled = YES;
    [addView addGestureRecognizer:tap];
    
  

}




-(void)dateChanged:(id)sender{
    
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *showtimeNew = [formatter1 stringFromDate:_date];
    
    
    NSLog(@"%@",showtimeNew);
    
    dateLabel.text = showtimeNew;
    
}



- (void)picClick:(UIButton *)btn{
    
    UIImageView *vi = (UIImageView *)[self.view viewWithTag:1945];
    
    CATransition *ti = [CATransition animation];
    ti.type = @"oglFlip";
    ti.duration = 0.3;
    [vi.layer addAnimation:ti forKey:@"oglFlip"];
    
    vi.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 250);
    
    backView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
}

- (void)time{
    
    NSLog(@"时间");
    
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    UIImageView *vi = (UIImageView *)[self.view viewWithTag:1945];
    
    CATransition *ti = [CATransition animation];
    ti.type = @"oglFlip";
    ti.duration = 0.3;
    [vi.layer addAnimation:ti forKey:@"oglFlip"];
    
    vi.frame = CGRectMake(0, 100, SCREEN_WIDTH, 250);
    
    
    
}













- (void)requestStarted:(ASIHTTPRequest *)request{
    
    
    [MMProgressHUD showWithStatus:@"正在发布"];
    
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    
    
    id result = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    
    if ( [result isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dic = (NSDictionary *)result;
        
        NSLog(@"%@",dic);
        
        NSDictionary *dataDic = [dic objectForKey:@"data"];
        
        NSString *imagePath = [dataDic objectForKey:@"aid"];
        
        [AIDArray addObject:imagePath];
        
    }
    
    requestTag++;
    
    if (_photoArray.count == requestTag) {
        
        [self requesthuo];
        
    }
    
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
    [MMProgressHUD dismissWithError:@"发布活动失败"];
    
    requestTag++;
    
}



#pragma mark 发布

- (void)requesthuo{
    
    requestTag = 0;
    
    [_photoArray removeAllObjects];
    
    
    [MMProgressHUD showWithStatus:@"发布活动"];
    
    NSString *string = @"";
    
    for (NSString *str in AIDArray) {
        
        string  = [string stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
        
    }
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@||ios",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSLog(@"%@",sysString);
    
    NSLog(@"%@=======%d",CURRENT_SIGN_KEY,CURRENT_TIME);
    
    NSString *sigString =@"";
    
    
    if ([def objectForKey:USER_NAME]) {
        
        sigString = [[NSString stringWithFormat:@"%@%d%@%@",sysString,CURRENT_TIME,CURRENT_SIGN_KEY,[def objectForKey:CURRENT_AUTH_KEY]]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }else{
        
        sigString = [[NSString stringWithFormat:@"%@%d%@",sigString,CURRENT_TIME,CURRENT_SIGN_KEY]MD5Hash];
        
        NSLog(@"one=============%@",sigString);
        
        
    }
    
    sigString = [[NSString stringWithFormat:@"%@%d",sigString,CURRENT_TIME]MD5Hash];
    
    NSLog(@"two=============%@",sigString);
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"add",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setValue:sigString forKey:@"sig"];
    [parameters setValue:titleLabel.text forKey:@"title"];
    
    if (sw.on) {
        [parameters setValue:@"1" forKey:@"isPk"];
        
    }else{
        [parameters setValue:@"0" forKey:@"isPk"];
        
    }
    
    [parameters setValue:biaoString forKey:@"category"];
    
    
    [parameters setValue:string forKey:@"aids"];
    
    NSLog(@"%@",dateLabel.text);
    
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *fromdate=[format dateFromString:dateLabel.text];
    
    NSLog(@"%@",fromdate);
    
    time= (long)[fromdate timeIntervalSince1970];
    NSLog(@"%ld",time);
    
    
    //    NSDate *date = [NSDate date];
    //
    //
    //    long start = [date timeIntervalSince1970] + 86400;
    
    [parameters setValue:[NSString stringWithFormat:@"%ld",time] forKey:@"startTime"];
    
    [parameters setValue:[def objectForKey:USER_LAT] forKey:@"lat"];
    
    [parameters setValue:[def objectForKey:USER_LONG] forKey:@"lng"];
    
    [parameters setValue:addressLabel.text forKey:@"area"];
    
#pragma mark test
    //    [parameters setValue:@"北京" forKey:@"area"];
    
    
    [parameters setValue:priceLabel.text forKey:@"cost"];
    [parameters setValue:peopleLabel.text forKey:@"maxNum"];
    [parameters setValue:shuoming.text forKey:@"message"];
    [parameters setValue:tv.text forKey:@"require"];
    
    
    
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
                                      
                                      NSDictionary *dict = [dic objectForKey:@"data"];
                                      
                                      NSLog(@"%@",dict);
#pragma mark 图片
                                      
                                      [MMProgressHUD dismissWithSuccess:@"发布活动成功"];
                                      
                                      [self.navigationController popViewControllerAnimated:YES];
                                      
                                      
                                  }else{
                                      
                                      
                                      NSString *sss = [dic objectForKey:@"msg"];
                                      
                                      NSLog(@"%@",sss);
                                      
                                      [MMProgressHUD dismissWithError:[NSString stringWithFormat:@"%@",sss]];
                                      
                                  }
                                  
                                  
                              }else
                              {
                                  NSLog(@"jsonError:%@",jsonError);
                                  [MMProgressHUD dismissWithError:@"发布活动失败"];
                                  
                              }
                              
                          }else
                          {
                              NSLog(@"error:%@",error);
                              [MMProgressHUD dismissWithError:@"发布活动失败"];
                              
                          }
                          
                          
                          
                      }];
    
    
}












- (void)tijiao{
    
    NSLog(@"提交");
    
    [self.view endEditing:YES];
    
    
    
    if (_photoArray.count < 1) {
        
        [self requesthuo];
        
        return;
    }
    
    
    //    [MMProgressHUD showWithStatus:@"正在刷新"];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%@",[def objectForKey:CURRENT_AUTH_KEY]);
    
    
    NSString *sysString = [NSString stringWithFormat:@"%@|%@|%d|%@||ios",CURRENT_UUID,CURRENT_API,CURRENT_TIME,[def objectForKey:USER_NAME]];
    
    NSLog(@"%@",sysString);
    
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
    
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"activity",@"add",sysString];
    
    NSString *urlStringUse = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlStringUse];
    
    
#pragma mark image
    
    
    
    NSString *imageurlString = [NSString stringWithFormat:@"%@?c=%@&a=%@&sys=%@",DEBUG_HOST_URL,@"upload",@"image",sysString];
    
    NSString *imageurlStringUse = [imageurlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *imageurl = [NSURL URLWithString:imageurlStringUse];
    
    NSMutableDictionary *imageparameters = [NSMutableDictionary dictionary];
    
    [imageparameters setValue:sigString forKey:@"sig"];
    
    [imageparameters setValue:@"activity" forKey:@"type"];
    
    NSData *da = [_photoArray lastObject];
    
    [imageparameters setValue:da  forKey:@"pic"];
    
    
    //    NSLog(@"%@",da);
    
    
    
    [_photoArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        NSData *imageData = (NSData *)obj;
        
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:imageurl];
        [request setPostValue:sigString forKey:@"sig"];
        [request setPostValue:@"activity" forKey:@"type"];
        [request addData:imageData withFileName:@"head.png" andContentType:@"image/jpeg" forKey:@"pic"];
        [request setDelegate:self];
        [request setTimeOutSeconds:30];
        request.tag = 500 + idx;
        [request startAsynchronous];
        
    }];
    
    
}













- (void)addImage{
    
    NSLog(@"add");
    
    
    if (_photoArray.count > 8) {
        
        [MMProgressHUD showWithStatus:@"正在上传"];
        
        [MMProgressHUD dismissWithError:@"照片个数已到上限"];
        
        return;
    }
    
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
    
    NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
    
    //    [self postImageData:imgData];
    
    NSLog(@"上传图片");
    
    [_photoArray addObject:imgData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [photoTable reloadData];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}









#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if ([tableView isEqual:_tableView]) {
        
        return [_dataArray count];
        
    }else{
        
        return _photoArray.count;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([tableView isEqual:_tableView]) {
        
        return 50;
    
    }else{
        
        return 70;
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView]) {
        
        return 20;
        
    }else{
        
        return -1;
        
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if ([tableView isEqual:_tableView]) {
        
        return 0.1;
        
    }else{
        
        return 10;
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        
        cell.accessoryType = 1;
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
        
        
        return cell;
        
        
    }else{
        
        
        static NSString *myCell = @"cell";
        
        faBuCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        
        if (cell == nil) {
            
            cell = [[faBuCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
            
        }
        
        cell.selectionStyle = 0;
        
        cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
        
        cell.head.image = [UIImage imageWithData:[_photoArray objectAtIndex:indexPath.row]];
        
        cell.head.contentMode = UIViewContentModeScaleAspectFill;
        
        cell.head.clipsToBounds = YES;
        
        return cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView isEqual:_tableView]) {
        
        if (indexPath.row == 3) {
            
            QingGanVC *ag = [[QingGanVC alloc]init];
            [self.navigationController pushViewController:ag animated:YES];
            
        }else if (indexPath.row == 4){
            
            ChanWantVC *vc = [[ChanWantVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 9){
            
            ChanAiHaoVC *hao = [[ChanAiHaoVC alloc]init];
            [self.navigationController pushViewController:hao animated:YES];
            
        }else{
            
            ChangeLabelVC *vc = [[ChangeLabelVC alloc]init];
            
            vc.theTitle = [_dataArray objectAtIndex:indexPath.row];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }
     
        
    }

}


- (void)address{
    
    JuAddressViewController *addre = [[JuAddressViewController alloc]init];
    [addre callBackAdress:^(NSString *str) {
        
        addressLabel.text = str;
        
    }];
    [self.navigationController pushViewController:addre animated:YES];
    
    
}




@end