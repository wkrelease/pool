//
//  DongTaiCell.m
//  POOL
//
//  Created by king on 15/3/29.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "DongTaiCell.h"

@implementation DongTaiCell


@synthesize head,name,message,time,ping;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];

        head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        head.image = [UIImage imageNamed:@"demo"];
        [self addSubview:head];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 180, 15)];
        name.font = [UIFont systemFontOfSize:14];
        name.text = @"小明";
        name.textColor = [UIColor darkGrayColor];
        [self addSubview:name];
        
        message = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, SCREEN_WIDTH - 80, 40)];
        message.text = @"小明小明小明小明小明小明小明小明小明小明小明小明";
        message.font = [UIFont systemFontOfSize:14];
        message.numberOfLines = 0;
        message.textColor = [UIColor grayColor];
        [self addSubview:message];
        
        time = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 160, 10, 150, 15)];
        time.text = @"09:41";
        time.font = [UIFont systemFontOfSize:14];
        time.textColor = [UIColor grayColor];
//        time.backgroundColor = [UIColor grayColor];
        time.textAlignment = NSTextAlignmentRight;
        [self addSubview:time];
        
        ping = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 50, 70, 15)];
        ping.text = @"20";
        ping.font = [UIFont systemFontOfSize:14];
//        ping.backgroundColor = [UIColor grayColor];
        ping.textAlignment = NSTextAlignmentRight;
        ping.textColor = [UIColor grayColor];
        [self addSubview:ping];
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
