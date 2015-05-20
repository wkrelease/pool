//
//  DengCell.m
//  POOL
//
//  Created by king on 15/5/15.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "DengCell.h"

@implementation DengCell




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *l1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 69, SCREEN_WIDTH, 1)];
        l1.backgroundColor = R_G_B_COLOR(234, 234, 234);
        [self addSubview:l1];
        
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 50, 20)];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.font = [UIFont systemFontOfSize:11];
        _name.textColor = [UIColor grayColor];
        [self addSubview:_name];
        
        _head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        _head.backgroundColor = [UIColor cyanColor];
        _head.layer.cornerRadius = 15;
        _head.layer.masksToBounds = YES;
        [self addSubview:_head];
        
        _message = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, 200, 30)];
        _message.font = [UIFont systemFontOfSize:12];
        _message.textColor = [UIColor grayColor];
        [self addSubview:_message];
        
        
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
