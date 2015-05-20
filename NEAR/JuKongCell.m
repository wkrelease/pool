//
//  JuKongCell.m
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "JuKongCell.h"

@implementation JuKongCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 10, 80, 20)];
        _dateLabel.font = [UIFont systemFontOfSize:14];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_dateLabel];
        
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, SCREEN_WIDTH - 130, 40)];
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.numberOfLines = 10;
        [self addSubview:_messageLabel];

        
        _pingNum = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 75, 80, 20)];
        _pingNum.textAlignment = NSTextAlignmentRight;
        _pingNum.font = [UIFont systemFontOfSize:12];
        [self addSubview:_pingNum];
        
        _head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [self addSubview:_head];
        
        _name = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 100, 20)];
        _name.font = [UIFont systemFontOfSize:14];
        [self addSubview:_name];
        
        _oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 60, 60, 60)];
        _oneImage.image = [UIImage imageNamed:@"demo"];
        [self addSubview:_oneImage];
        
        _twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(150, 60, 60, 60)];
        _twoImage.image  =[UIImage imageNamed:@"demo"];
        [self addSubview:_twoImage];
        
        
        _threeImage = [[UIImageView alloc]initWithFrame:CGRectMake(220, 60, 60, 60)];
        _threeImage.image = [UIImage imageNamed:@"demo"];
        [self addSubview:_threeImage];
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
