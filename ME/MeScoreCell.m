//
//  MeScoreCell.m
//  POOL
//
//  Created by king on 15-2-27.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeScoreCell.h"

@implementation MeScoreCell

@synthesize backView,headView,name,mess,numLabel,address;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor clearColor];
        
        backView = [[UIImageView alloc]initWithFrame:CGRectMake(X_OFF_SET, 10, SCREEN_WIDTH, 90)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
        headView.image = [UIImage imageNamed:@"demo"];
        headView.contentMode = UIViewContentModeScaleAspectFill;
        headView.clipsToBounds= YES;
        [backView addSubview:headView];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(100, 16, SCREEN_WIDTH - 110, 20)];
        name.backgroundColor = [UIColor clearColor];
        name.text = @"丁俊晖积分赛";
        name.font = [UIFont systemFontOfSize:13];
        [backView addSubview:name];
        
        mess = [[UILabel alloc]initWithFrame:CGRectMake(100, 40, SCREEN_WIDTH - 110, 20)];
        mess.font = [UIFont systemFontOfSize:13];
        mess.text = @"9月16日 19:00";
        [backView addSubview:mess];
        
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 65, 80, 16)];
        numLabel.text = @"距离0.5km";
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.font = [UIFont systemFontOfSize:12];
        numLabel.layer.cornerRadius = 8;
        numLabel.backgroundColor = R_G_B_COLOR(64, 70, 88);
        numLabel.textColor = [UIColor whiteColor];
        numLabel.layer.masksToBounds = YES;
        [backView addSubview:numLabel];
        
        address = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 65, 90, 16)];
        address.text = @"我的成绩:8强";
        address.font = [UIFont systemFontOfSize:12];
        address.textAlignment = NSTextAlignmentCenter;
        address.layer.cornerRadius = 8;
        address.textColor = [UIColor whiteColor];
        address.backgroundColor = [UIColor orangeColor];
        address.layer.masksToBounds = YES;
        [backView addSubview:address];
        
       
        
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



















