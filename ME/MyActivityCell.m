//
//  MyActivityCell.m
//  POOL
//
//  Created by king on 15-3-7.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MyActivityCell.h"

@implementation MyActivityCell

@synthesize headView,titelLabel,dateLabel,stateLabel;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];

        
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        headView.image = [UIImage imageNamed:@"demo"];
        headView.contentMode = UIViewContentModeScaleAspectFill;
        headView.clipsToBounds= YES;
        [self addSubview:headView];
        
        titelLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 150, 15)];
        titelLabel.text = @"周五 18:30pk赛";
        titelLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titelLabel];
        
        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, 150, 15)];
        dateLabel.text = @"2014-10-10 16:30";
        dateLabel.font = [UIFont systemFontOfSize:13];
        dateLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:dateLabel];
        
        stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 15, 70, 20)];
        stateLabel.text = @"已结束";
        stateLabel.font = [UIFont systemFontOfSize:13];
        stateLabel.textAlignment  =NSTextAlignmentRight;
        [self addSubview:stateLabel];
        
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
