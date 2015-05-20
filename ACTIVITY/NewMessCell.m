//
//  NewMessCell.m
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "NewMessCell.h"

@implementation NewMessCell

@synthesize head,name,date,message;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        head.image = [UIImage imageNamed:@"demo"];
        head.layer.cornerRadius = 15;
        head.layer.masksToBounds = YES;
        [self addSubview:head];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, 100, 15)];
        name.text = @"name";
        name.font = [UIFont systemFontOfSize:12];
        name.textColor = R_G_B_COLOR(123, 123, 123);

        [self addSubview:name];
        
        message = [[UILabel alloc]initWithFrame:CGRectMake(50, 35, SCREEN_WIDTH - 50, 30)];
        message.font = [UIFont systemFontOfSize:12];
        message.textColor = R_G_B_COLOR(123, 123, 123);

        message.text = @"namnamanansdkjahskjd";
        [self addSubview:message];
        
        date = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 10, 90, 15)];
        date.text = @"12-12 14:20";
        date.textAlignment = NSTextAlignmentRight;
        date.font = [UIFont systemFontOfSize:12];
        date.textColor = R_G_B_COLOR(200, 200, 200);
        [self addSubview:date];
        
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



