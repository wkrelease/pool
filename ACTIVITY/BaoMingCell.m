//
//  BaoMingCell.m
//  POOL
//
//  Created by king on 15/3/15.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "BaoMingCell.h"

@implementation BaoMingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor clearColor];
        
      
        _name = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 60, 20)];
        _name.text = @"name";
        _name.font = [UIFont systemFontOfSize:12];
        _name.textColor  = [UIColor grayColor];
        _name.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_name];
        
        _message = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, SCREEN_WIDTH - 90, 40)];
        _message.text = @" message message message message message message message";
        _message.font = [UIFont systemFontOfSize:12];
        _message.textAlignment = NSTextAlignmentRight;
        _message.textColor = [UIColor grayColor];
        _message.numberOfLines = 10;
        [self addSubview:_message];
        

        _line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        _line.backgroundColor = R_G_B_COLOR(221, 221, 221);
        [self addSubview:_line];
        
        
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
