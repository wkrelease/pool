//
//  ActivityNewCell.m
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ActivityNewCell.h"

@implementation ActivityNewCell

@synthesize headView,titleLabel,messLabel,theImg,num;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.backgroundColor = [UIColor clearColor];
      
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        headView.image = [UIImage imageNamed:@"demo"];
        [self addSubview:headView];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, SCREEN_WIDTH - 80, 15)];
        titleLabel.text = @"打桌球要选直一些的杆子";
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLabel];
        
        messLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, SCREEN_WIDTH - 80, 30)];
        messLabel.text = @"这会影响你击球的准确性";
        messLabel.font = [UIFont systemFontOfSize:12];
        messLabel.textColor = R_G_B_COLOR(200, 200, 200);
        [self addSubview:messLabel];
        
        theImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70, 70, 10, 10)];
        theImg.image = [UIImage imageNamed:@"demo"];
        [self addSubview:theImg];
        
        num = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 70, 45, 15)];
        num.font = [UIFont systemFontOfSize:12];
        num.textColor = R_G_B_COLOR(200, 200, 200);
        num.text = @"150";
        [self addSubview:num];
        
        UIImageView *li = [[UIImageView alloc]initWithFrame:CGRectMake(0, 89, SCREEN_WIDTH, 1)];
        li.backgroundColor = R_G_B_COLOR(221, 221, 221);
        [self addSubview:li];
        
        
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



















