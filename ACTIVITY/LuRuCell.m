//
//  LuRuCell.m
//  POOL
//
//  Created by king on 15/4/12.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "LuRuCell.h"

@implementation LuRuCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor whiteColor];

        UIImageView *l1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        l1.backgroundColor = R_G_B_COLOR(234, 234, 234);
        [self addSubview:l1];
        
        _theClass = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 80, 30)];
        _theClass.textAlignment = NSTextAlignmentCenter;
        _theClass.font = [UIFont systemFontOfSize:14];
        [self addSubview:_theClass];

        UIImageView *l2 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 1, 50)];
        l2.backgroundColor = R_G_B_COLOR(234, 234, 234);
        [self addSubview:l2];
        
        UILabel *xuan = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 13, 40, 20)];
        xuan.text = @"选择";
        xuan.font = [UIFont systemFontOfSize:12];
        xuan.textColor = [UIColor grayColor];
        [self addSubview:xuan];
        
        _oneImg = [[UIImageView alloc]initWithFrame:CGRectMake(85,10, 30, 30)];
        _oneImg.backgroundColor = [UIColor clearColor];
        _oneImg.layer.cornerRadius = 15;
        [self addSubview:_oneImg];
        
        _twoImg = [[UIImageView alloc]initWithFrame:CGRectMake(130, 10, 30, 30)];
        _twoImg.backgroundColor = [UIColor clearColor];
        _twoImg.layer.cornerRadius = 15;
        [self addSubview:_twoImg];
        
        _threeImg = [[UIImageView alloc]initWithFrame:CGRectMake(175, 10, 30, 30)];
        _threeImg.backgroundColor = [UIColor clearColor];
        _threeImg.layer.cornerRadius = 15;
        [self addSubview:_threeImg];
        
        _fourImg = [[UIImageView alloc]initWithFrame:CGRectMake(220, 10, 30, 30)];
        _fourImg.backgroundColor = [UIColor clearColor];
        _fourImg.layer.cornerRadius = 15;
        [self addSubview:_fourImg];
        
      
        
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
