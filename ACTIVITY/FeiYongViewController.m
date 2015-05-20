//
//  FeiYongViewController.m
//  POOL
//
//  Created by king on 15/3/30.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "FeiYongViewController.h"

@interface FeiYongViewController (){
    
    
    UITextField *priFie ;
}

@end

@implementation FeiYongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTitleLabel.text = @"费用";
    
    [self showBack];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"AA",@"我埋单",@"你埋单",@"其它金额", nil];
    
    
    priFie = [[UITextField alloc]initWithFrame:CGRectMake(80, 165, 60, 20)];
    priFie.backgroundColor = [UIColor clearColor];
    priFie.keyboardType = UIKeyboardTypeNumberPad;
    priFie.userInteractionEnabled = NO;
    priFie.returnKeyType = UIReturnKeyDone;
    priFie.delegate = self;
    priFie.font = [UIFont systemFontOfSize:14];
    [_tableView addSubview:priFie];
    
    UILabel *yu = [[UILabel alloc]initWithFrame:CGRectMake(140, 165, 30, 20)];
    yu.text = @"元";
    yu.font = [UIFont systemFontOfSize:14];
    [_tableView addSubview:yu];
    
    UIButton *btn= [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.backgroundColor = R_G_B_COLOR(50, 221, 161);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 230 , SCREEN_WIDTH - 20, 40);
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btn addTarget:self action:@selector(yesClick:) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:btn];
    
    // Do any additional setup after loading the view.
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    UITableViewCell *cell = [_tableView ]
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    

    if (textField.text.length > 4) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    return YES;
    
}


- (void)yesClick:(UIButton *)button{
    
    [self.view endEditing:YES];
    
    if (priFie.text.length >= 1) {

        _callBack(priFie.text);
    
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 3) {
        
        
        priFie.userInteractionEnabled = YES;

        [priFie becomeFirstResponder];
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入价格" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
//        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
////        alert.
//        [alert show];
        
//        _callBack(priFie.text);

        
    
    }else{
        
        priFie.userInteractionEnabled = NO;
        
        [self.view endEditing:YES];
        _callBack([_dataArray objectAtIndex:indexPath.row]);

        
    }
    
    
//    [self.navigationController popViewControllerAnimated:YES];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField *tf=[alertView textFieldAtIndex:0];
    
    priFie.text = tf.text;
    
}


- (void)callBack:(void (^)(NSString *))myBlock{
    
    _callBack = myBlock;
    
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
