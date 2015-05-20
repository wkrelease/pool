//
//  OneCell.m
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "OneCell.h"

@implementation OneCell

@synthesize backView,headView,name,vipImage,scoreLabel,numLabel,message,sexImage,ageLabel,tong,quan;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
        headView.image = [UIImage imageNamed:@"demo"];
        [backView addSubview:headView];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 100, 20)];
        name.font = [UIFont systemFontOfSize:14];
        name.text = @"丁俊晖";
        [name sizeToFit];
        [backView addSubview:name];
        
//        vipImage = [[UIImageView alloc]initWithFrame:CGRectMake(65 + name.frame.size.width, 10, 20, 20)];
//        vipImage.image = [UIImage imageNamed:@"icon_VIP"];
//        [backView addSubview:vipImage];
        
        scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(90 + name.frame.size.width, 10, 70, 16)];
        scoreLabel.font = [UIFont systemFontOfSize:13];
        scoreLabel.text = @"115积分";
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.backgroundColor = [UIColor redColor];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.layer.cornerRadius = 8;
        scoreLabel.layer.masksToBounds = YES;
        [backView addSubview:scoreLabel];
        
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 10, 50, 20)];
        numLabel.text = @"NO.1";
        numLabel.font = [UIFont boldSystemFontOfSize:15];
        numLabel.textColor = [UIColor redColor];
        [backView addSubview:numLabel];
        
        message = [[UILabel alloc]initWithFrame:CGRectMake(60, 35, SCREEN_WIDTH - 70, 15)];
        message.font = [UIFont systemFontOfSize:13];
        message.text = @"个性签名签名签名签名签名签名签名签名签名签名";
        [backView addSubview:message];
        
        sexImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 57, 10, 10)];
        sexImage.image = [UIImage imageNamed:@"icon_sex_man"];
        [backView addSubview:sexImage];
        
        ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 55, 30, 15)];
        ageLabel.font = [UIFont systemFontOfSize:12];
        ageLabel.text = @"23岁";
        ageLabel.textColor = [UIColor orangeColor];
        [backView addSubview:ageLabel];
        
        tong = [[UILabel alloc]initWithFrame:CGRectMake(70, 55, 80, 15)];
        tong.backgroundColor = R_G_B_COLOR(80, 149, 237);
        tong.textColor = [UIColor whiteColor];
        tong.font = [UIFont systemFontOfSize:10];
        tong.layer.cornerRadius = 7.5;
        tong.layer.masksToBounds = YES;
        tong.text = @"同城排名:99";
        tong.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:tong];
        
        quan = [[UILabel alloc]initWithFrame:CGRectMake(160, 55, 80, 15)];
        quan.textColor = [UIColor whiteColor];
        quan.backgroundColor = [UIColor lightGrayColor];
        quan.text = @"全国排名:999";
        quan.font = [UIFont systemFontOfSize:10];
        quan.layer.cornerRadius = 7.5;
        quan.textAlignment = NSTextAlignmentCenter;
        quan.layer.masksToBounds = YES;
        [backView addSubview:quan];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
