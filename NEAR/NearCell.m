//
//  NearCell.m
//  POOL
//
//  Created by king on 15-2-10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "NearCell.h"

@implementation NearCell

@synthesize backView,headView,nameLabel,sexImage,ageLabel,vipImage,paiLabel,oneView,twoImage,scoreLabel,message,address,dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 100)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 70, 70)];
        headView.backgroundColor = [UIColor clearColor];
        headView.image = [UIImage imageNamed:@"demo.png"];
        [backView addSubview:headView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 20, 100, 20)];
        nameLabel.text = @"丁俊晖";
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.font = [UIFont systemFontOfSize:13];
        [nameLabel sizeToFit];
        [backView addSubview:nameLabel];
        
        sexImage = [[UIImageView alloc]initWithFrame:CGRectMake(85 + nameLabel.frame.size.width, 22, 10, 10)];
        sexImage.backgroundColor = [UIColor clearColor];
        sexImage.image = [UIImage imageNamed:@"icon_sex_man"];
        [backView addSubview:sexImage];
        
        ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(105 + nameLabel.frame.size.width, 20, 30, 15)];
        ageLabel.text = @"23岁";
        ageLabel.font = [UIFont systemFontOfSize:13];
        ageLabel.textColor = [UIColor orangeColor];
        ageLabel.backgroundColor = [UIColor clearColor];
        [backView addSubview:ageLabel];
        
//        vipImage = [[UIImageView alloc]initWithFrame:CGRectMake(140 + nameLabel.frame.size.width, 18, 20, 20)];
//        vipImage.backgroundColor = [UIColor clearColor];
//        vipImage.image = [UIImage imageNamed:@"icon_VIP"];
//        [backView addSubview:vipImage];
        
        paiLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 20, 80, 20)];
        paiLabel.text = @"陪练:50-100";
        paiLabel.textAlignment = NSTextAlignmentRight;
        paiLabel.textColor = [UIColor blueColor];
        paiLabel.font = [UIFont systemFontOfSize:13];
        paiLabel.backgroundColor = [UIColor clearColor];
        [backView addSubview:paiLabel];
        
//        oneView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 42, 15, 15)];
//        oneView.backgroundColor = [UIColor clearColor];
//        oneView.image = [UIImage imageNamed:@"icon_ranking_1"];
//        [backView addSubview:oneView];
        
        twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 42, 15, 15)];
        twoImage.backgroundColor = [UIColor clearColor];
        twoImage.image = [UIImage imageNamed:@"icon_billiards_1"];
        [backView addSubview:twoImage];
        
        scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 42, 80, 14)];
        scoreLabel.text = @"155积分";
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.backgroundColor = [UIColor redColor];
        scoreLabel.textColor = [UIColor whiteColor];
        scoreLabel.layer.cornerRadius = 7;
        scoreLabel.layer.masksToBounds = YES;
        scoreLabel.font = [UIFont systemFontOfSize:13];
        [backView addSubview:scoreLabel];
        
        message = [[UILabel alloc]initWithFrame:CGRectMake(80, 58, SCREEN_WIDTH - 90, 20)];
        message.font = [UIFont systemFontOfSize:13];
        message.text = @"个性签名个性签名个性签名个性签名个性签名";
        message.textColor = [UIColor grayColor];
        [backView addSubview:message];
        
        address = [[UILabel alloc]initWithFrame:CGRectMake(80, 80, 90, 14)];
        address.backgroundColor = [UIColor darkGrayColor];
        address.text = @"距离0.5km";
        address.layer.cornerRadius = 7;
        address.textAlignment = NSTextAlignmentCenter;
        address.font = [UIFont systemFontOfSize:12];
        address.textColor = [UIColor whiteColor];
        address.layer.masksToBounds = YES;
        [backView addSubview:address];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 80, 70, 16)];
        dateLabel.textColor = [UIColor grayColor];
        dateLabel.text = @"";
        dateLabel.textAlignment = NSTextAlignmentRight;
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont systemFontOfSize:12];
        [backView addSubview:dateLabel];
        
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
