//
//  ChengOneCell.m
//  POOL
//
//  Created by king on 15/5/14.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ChengOneCell.h"

@implementation ChengOneCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *l1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 1)];
        l1.backgroundColor = R_G_B_COLOR(234, 234, 234);
        [self addSubview:l1];
        
        _stat = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 80, 30)];
        _stat.textAlignment = NSTextAlignmentCenter;
        _stat.font = [UIFont systemFontOfSize:14];
        _stat.text = @"冠军";
        [self addSubview:_stat];
        
        UIImageView *l2 = [[UIImageView alloc]initWithFrame:CGRectMake(80, 0, 1, 70)];
        l2.backgroundColor = R_G_B_COLOR(234, 234, 234);
        [self addSubview:l2];
    
        
//        _head = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 15, 10, 30, 30)];
//        _head.backgroundColor = [UIColor cyanColor];
//        _head.layer.cornerRadius = 15;
//        _head.layer.masksToBounds = YES;
//        [self addSubview:_head];
        
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
