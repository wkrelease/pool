//
//  MemberCell.m
//  POOL
//
//  Created by king on 15/3/15.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MemberCell.h"

@implementation MemberCell

@synthesize name,head,sex,age,qiu,jifen;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor clearColor];
        
        
        head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        head.image  =[UIImage imageNamed:@"demo"];
        [self addSubview:head];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 100, 15)];
        name.text = @"小白";
        name.textColor = [UIColor grayColor];
        name.font = [UIFont systemFontOfSize:14];
    
        [self addSubview:name];
    
        sex = [[UIImageView alloc]initWithFrame:CGRectMake(60, 40, 15, 15)];
        sex.image = [UIImage imageNamed:@"demo"];
        
        [self addSubview:sex];
        
        age = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, 30, 15)];
        age.text = @"23岁";
        age.textAlignment = NSTextAlignmentCenter;
        age.font = [UIFont systemFontOfSize:12];
        age.textColor = [UIColor orangeColor];
        [self addSubview:age];
        
        qiu = [[UIImageView alloc]initWithFrame:CGRectMake(115, 40, 15, 15)];
        qiu.image = [UIImage imageNamed:@"demo"];
        [self addSubview:qiu];
        
        jifen = [[UILabel alloc]initWithFrame:CGRectMake(135, 40, 70, 15)];
        jifen.backgroundColor = R_G_B_COLOR(241, 60, 74);
        jifen.textColor = [UIColor whiteColor];
        jifen.layer.cornerRadius = 7.5;
        jifen.layer.masksToBounds = YES;
        jifen.text = @"100积分";
        jifen.font = [UIFont systemFontOfSize:13];
        jifen.textAlignment = NSTextAlignmentCenter;
        [self addSubview:jifen];
        
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 1)];
        line.backgroundColor = R_G_B_COLOR(221, 221, 221);
        [self addSubview:line];
        
    }
    return self;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
