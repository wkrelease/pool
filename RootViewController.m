//
//  RootViewController.m
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()

@end

@implementation RootViewController

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
    
    tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(X_OFF_SET, SCREEN_HEIGHT - BAR_HEIGHT, SCREEN_WIDTH , BAR_HEIGHT)];
    tabBarView.backgroundColor = R_G_B_COLOR(45, 69, 130);
    
    
    
    
    
    tabBarView.userInteractionEnabled = YES;
    [self.view addSubview:tabBarView];
    
    NSArray *nomArray = [NSArray arrayWithObjects:@"tab_activity_up",@"tab_nearby_up",@"tab_message_up",@"tab_ranking_up",@"tab_mine_up", nil];
    NSArray *seleArray = [NSArray arrayWithObjects:@"tab_activity_down",@"tab_nearby_down",@"tab_message_down",@"tab_ranking_down",@"tab_mine_down", nil];
    
    NSArray *textArray = [NSArray arrayWithObjects:@"活动",@"附近",@"消息",@"排行榜",@"我", nil];
    
    [textArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH/5 * idx , 3, SCREEN_WIDTH/5, 30);
//        [btn setBackgroundImage:[UIImage imageNamed:[nomArray objectAtIndex:idx]] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:[seleArray objectAtIndex:idx]] forState:UIControlStateSelected];
        
        
        [btn setImage:[UIImage imageNamed:[nomArray objectAtIndex:idx]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[seleArray objectAtIndex:idx]] forState:UIControlStateSelected];

        btn.tag = 10 + idx;
        [btn addTarget:self action:@selector(tabClicked:) forControlEvents:UIControlEventTouchUpInside];
        [tabBarView addSubview:btn];
        
        UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/5 * idx + 12, 35, 40, 15)];
        la.textAlignment = NSTextAlignmentCenter;
        la.font = [UIFont systemFontOfSize:10];
        la.text = obj;
        la.textColor = [UIColor whiteColor];
        la.backgroundColor = [UIColor clearColor];
        [tabBarView addSubview:la];
        
        if (idx == 0) {
            btn.selected = YES;
        }
        
    }];
    
    [self createScrol];
    
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moreAct) name:@"moreAct" object:nil];
    
    // Do any additional setup after loading the view.
}

- (void)moreAct{
    
    mainScroll.contentOffset = CGPointMake(X_OFF_SET, Y_OFF_SET);

    for (UIView *vi in tabBarView.subviews) {
        
        if ([vi isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)vi;
            button.selected = NO;
            
        }
        
    }
    
    UIButton *bu = (UIButton *)[self.view viewWithTag:10];
    
    bu.selected = YES;
    
    
}


- (void)tabClicked:(UIButton *)btn{
    
    
    CATransition *tran = [CATransition animation];
    tran.duration = 0.3;
    tran.type = @"cube";
    [btn.layer addAnimation:tran forKey:nil];
    
    CATransition *trans = [CATransition animation];
    trans.duration = 0.5;
    trans.type = @"fide";
    [mainScroll.layer addAnimation:trans forKey:nil];
    
    
    
    
    NSLog(@"%ld",(long)btn.tag);
    
    for (UIView *vi in tabBarView.subviews) {
        
        if ([vi isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)vi;
            button.selected = NO;
            
        }
        
    }
    
    
    btn.selected = YES;
    
    
    if (btn.tag == 10) {
        
        mainScroll.contentOffset = CGPointMake(X_OFF_SET, Y_OFF_SET);

        
    }else if (btn.tag == 11){
        
        if (!near) {
            near = [[NearViewController alloc]init];
            [self addChildViewController:near];
            near.view.frame = CGRectMake(SCREEN_WIDTH, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - BAR_HEIGHT);
            [mainScroll addSubview:near.view];
        }
        
        mainScroll.contentOffset = CGPointMake(SCREEN_WIDTH, Y_OFF_SET);

    }else if (btn.tag == 12){
        
        if (!mess) {
            mess = [[MessageViewController alloc]init];
            [self addChildViewController:mess];
            mess.view.frame = CGRectMake(SCREEN_WIDTH * 2, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - BAR_HEIGHT);
            [mainScroll addSubview:mess.view];
        }
        
        mainScroll.contentOffset = CGPointMake(SCREEN_WIDTH * 2, Y_OFF_SET);
        
    }else if (btn.tag == 13){
        
        if (!pai) {
            pai = [[PaiHangViewController alloc]init];
            [self addChildViewController:pai];
            pai.view.frame = CGRectMake(SCREEN_WIDTH * 3, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - BAR_HEIGHT);
            [mainScroll addSubview:pai.view];
        }
        
        mainScroll.contentOffset = CGPointMake(SCREEN_WIDTH * 3, Y_OFF_SET);
        
    }else if (btn.tag == 14){
        
        if (!me) {
            me = [[MeViewController alloc]init];
            [self addChildViewController:me];
            me.view.frame = CGRectMake(SCREEN_WIDTH * 4, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - BAR_HEIGHT);
            [mainScroll addSubview:me.view];
        }
        
        mainScroll.contentOffset = CGPointMake(SCREEN_WIDTH * 4, Y_OFF_SET);
        
        
    }
    
    
    
    
}

- (void)createScrol{
    
    
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(X_OFF_SET, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - BAR_HEIGHT)];
    mainScroll.pagingEnabled = YES;
    mainScroll.bounces = NO;
    mainScroll.scrollEnabled = NO;
    mainScroll.showsVerticalScrollIndicator = NO;
    mainScroll.showsHorizontalScrollIndicator = NO;
    mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH * 5, SCREEN_HEIGHT - BAR_HEIGHT);
    mainScroll.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:mainScroll];
    
    
    activity = [[ActivityViewController alloc]init];
    activity.view.frame = CGRectMake(X_OFF_SET, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT - BAR_HEIGHT);
    [self addChildViewController:activity];
    [mainScroll addSubview:activity.view];
    
    
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
