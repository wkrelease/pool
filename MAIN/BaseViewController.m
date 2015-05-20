//
//  BaseViewController.m
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize myTitleLabel,navView;

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
    
    self.navigationController.navigationBarHidden = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = DEFAULT_COLOR;
    
    navView = [[UIImageView alloc]initWithFrame:CGRectMake(X_OFF_SET, Y_OFF_SET, SCREEN_WIDTH,NAV_HEIGHT)];
    navView.backgroundColor = R_G_B_COLOR(45, 69, 130);
    navView.userInteractionEnabled = YES;
    [self.view addSubview:navView];
    
    myTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 34, SCREEN_WIDTH - 160, 20)];
    myTitleLabel.font = [UIFont systemFontOfSize:17];
    myTitleLabel.textAlignment = NSTextAlignmentCenter;
    myTitleLabel.textColor = [UIColor whiteColor];
    [navView addSubview:myTitleLabel];
    
   
    
    // Do any additional setup after loading the view.
}

- (void)showBack{
    
    
    UIButton *wang = [UIButton buttonWithType:UIButtonTypeCustom];
    [wang setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    wang.frame = CGRectMake(-30, 22, 100, 40);
    wang.showsTouchWhenHighlighted = YES;
    [wang addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:wang];
    
    
}

- (void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
