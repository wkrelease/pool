//
//  LuRuThreeCell.m
//  POOL
//
//  Created by king on 15/5/10.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "LuRuThreeCell.h"

@implementation LuRuThreeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *l1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 99, SCREEN_WIDTH, 1)];
        l1.backgroundColor = R_G_B_COLOR(234, 234, 234);
        [self addSubview:l1];
        
        _theClass = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 80, 30)];
        _theClass.textAlignment = NSTextAlignmentCenter;
        _theClass.font = [UIFont systemFontOfSize:14];
        [self addSubview:_theClass];
        
        UIImageView *l2 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 1, 100)];
        l2.backgroundColor = R_G_B_COLOR(234, 234, 234);
        [self addSubview:l2];
        
        UILabel *xuan = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 40, 40, 20)];
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
        
        _fiveImg = [[UIImageView alloc]initWithFrame:CGRectMake(85,50, 30, 30)];
        _fiveImg.backgroundColor = [UIColor clearColor];
        _fiveImg.layer.cornerRadius = 15;
        [self addSubview:_fiveImg];
        
        _sixImg = [[UIImageView alloc]initWithFrame:CGRectMake(130, 50, 30, 30)];
        _sixImg.backgroundColor = [UIColor clearColor];
        _sixImg.layer.cornerRadius = 15;
        [self addSubview:_sixImg];
        
        _sevenImg = [[UIImageView alloc]initWithFrame:CGRectMake(175, 50, 30, 30)];
        _sevenImg.backgroundColor = [UIColor clearColor];
        _sevenImg.layer.cornerRadius = 15;
        [self addSubview:_sevenImg];
        
        _eightImg = [[UIImageView alloc]initWithFrame:CGRectMake(220, 50, 30, 30)];
        _eightImg.backgroundColor = [UIColor clearColor];
        _eightImg.layer.cornerRadius = 15;
        [self addSubview:_eightImg];
        
        
        
        
        
        _nineImg = [[UIImageView alloc]initWithFrame:CGRectMake(85,90, 30, 30)];
        _nineImg.backgroundColor = [UIColor clearColor];
        _nineImg.layer.cornerRadius = 15;
        [self addSubview:_nineImg];
        
        
        _tenImg = [[UIImageView alloc]initWithFrame:CGRectMake(130, 90, 30, 30)];
        _tenImg.backgroundColor = [UIColor clearColor];
        _tenImg.layer.cornerRadius = 15;
        [self addSubview:_tenImg];
        
        _elevenImg = [[UIImageView alloc]initWithFrame:CGRectMake(175, 90, 30, 30)];
        _elevenImg.backgroundColor = [UIColor clearColor];
        _elevenImg.layer.cornerRadius = 15;
        [self addSubview:_elevenImg];
        
        _twiveImg = [[UIImageView alloc]initWithFrame:CGRectMake(220, 90, 30, 30)];
        _twiveImg.backgroundColor = [UIColor clearColor];
        _twiveImg.layer.cornerRadius = 15;
        [self addSubview:_twiveImg];
        
        _thirteenImg = [[UIImageView alloc]initWithFrame:CGRectMake(85,50, 30, 30)];
        _thirteenImg.backgroundColor = [UIColor clearColor];
        _thirteenImg.layer.cornerRadius = 15;
        [self addSubview:_thirteenImg];
        
        _fourteenImg = [[UIImageView alloc]initWithFrame:CGRectMake(130, 50, 30, 30)];
        _fourteenImg.backgroundColor = [UIColor clearColor];
        _fourteenImg.layer.cornerRadius = 15;
        [self addSubview:_fourteenImg];
        
        _fifteenImg = [[UIImageView alloc]initWithFrame:CGRectMake(175, 50, 30, 30)];
        _fifteenImg.backgroundColor = [UIColor clearColor];
        _fifteenImg.layer.cornerRadius = 15;
        [self addSubview:_fifteenImg];
        
        _sixteenImg = [[UIImageView alloc]initWithFrame:CGRectMake(220, 50, 30, 30)];
        _sixteenImg.backgroundColor = [UIColor clearColor];
        _sixteenImg.layer.cornerRadius = 15;
        [self addSubview:_sixteenImg];
        
        
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
