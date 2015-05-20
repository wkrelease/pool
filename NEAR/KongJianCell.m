//
//  KongJianCell.m
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "KongJianCell.h"

@implementation KongJianCell

@synthesize head,name,message,dateStr;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        head.image = [UIImage imageNamed:@"demo"];
        head.layer.cornerRadius = 15;
        head.layer.masksToBounds = YES;
        [self addSubview:head];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 100, 20)];
        name.font = [UIFont systemFontOfSize:14];
        name.text = @"name";
        [self addSubview:name];
        
        message = [[UILabel alloc]initWithFrame:CGRectMake(50, 30, SCREEN_WIDTH - 70, 40)];
        message.font = [UIFont systemFontOfSize:14];
        [self addSubview:message];
        
        
        dateStr = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 10, 90, 20)];
        dateStr.textAlignment = NSTextAlignmentRight;
        dateStr.textColor = [UIColor grayColor];
        dateStr.font = [UIFont systemFontOfSize:12];
        [self addSubview:dateStr];
        
        
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
