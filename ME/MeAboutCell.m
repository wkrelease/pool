//
//  MeAboutCell.m
//  POOL
//
//  Created by king on 15-3-7.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "MeAboutCell.h"

@implementation MeAboutCell

@synthesize headView,nameLabel,dateLabel,oneImage,twoImage,threeImage,messageLabel,numPing;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        headView.image = [UIImage imageNamed:@"demo"];
        [self addSubview:headView];
        
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 50, 20)];
        nameLabel.font = [UIFont systemFontOfSize:14];
        nameLabel.text = @"小黑";
        [self addSubview:nameLabel];
        
        dateLabel= [[UILabel alloc]initWithFrame:CGRectMake(10, 75, 50, 20)];
        dateLabel.font = [UIFont systemFontOfSize:14];
        dateLabel.text = @"9月1日";
        [self addSubview:dateLabel];
        
        oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(80, 15, 60, 60)];
        oneImage.image = [UIImage imageNamed:@"demo"];
        [self addSubview:oneImage];
        
        twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(150, 15, 60, 60)];
        twoImage.image = [UIImage imageNamed:@"demo"];
        [self addSubview:twoImage];
        
        threeImage = [[UIImageView alloc]initWithFrame:CGRectMake(220, 15, 60, 60)];
        threeImage.image = [UIImage imageNamed:@"demo"];
        [self addSubview:threeImage];
        
        messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 90, SCREEN_WIDTH - 100, 40)];
        messageLabel.text = @"内容内容内容内容内容内容内容内容内容内容内容";
        messageLabel.numberOfLines = 3;
        messageLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:messageLabel];

        numPing = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 125, 70, 20)];
        numPing.font = [UIFont systemFontOfSize:12];
        numPing.text = @"15条评论";
        [self addSubview:numPing];
        
        
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
