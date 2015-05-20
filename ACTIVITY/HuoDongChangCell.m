//
//  HuoDongChangCell.m
//  POOL
//
//  Created by king on 15-2-11.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "HuoDongChangCell.h"

@implementation HuoDongChangCell

@synthesize backView,headView,name,address,xinHuo,hwoMuch,numImageView,qiangBtn,laView,laMessage,laPriceLabel,maiBtn,dingBtn,anoLaMessage,anoLaPriceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor =[ UIColor clearColor];
        
        
        backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 130)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.userInteractionEnabled = YES;
        [self addSubview:backView];
        
        headView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 90, 90)];
        headView.image = [UIImage imageNamed:@"demo"];
        [backView addSubview:headView];
        
        name = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 200, 20)];
        name.text = @"夜时尚中关村";
        name.font = [UIFont fontWithName:@"Bodoni 72" size:15];

        [backView addSubview:name];
        
        address = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 40, 90, 15)];
        address.textColor = [UIColor whiteColor];
        address.backgroundColor = R_G_B_COLOR(64, 70, 88);
        address.text = @"距离0.5km";
        address.layer.cornerRadius = 7.5;
        address.layer.masksToBounds=YES;
        address.textAlignment = NSTextAlignmentCenter;
        address.font = [UIFont systemFontOfSize:12];
        [backView addSubview:address];
        
        
        UILabel *a = [[UILabel alloc]initWithFrame:CGRectMake(100, 35, 60, 15)];
        a.backgroundColor = [UIColor clearColor];
        a.text = @"最新活动:";
        a.font = [UIFont systemFontOfSize:12];
        a.textColor = [UIColor grayColor];
        [backView addSubview:a];
        
        
        xinHuo = [[UILabel alloc]initWithFrame:CGRectMake(165, 35, 100, 15)];
        xinHuo.backgroundColor = [UIColor clearColor];
        xinHuo.text = @"周五18:30pk赛";
        xinHuo.font = [UIFont systemFontOfSize:12];
        xinHuo.textColor = [UIColor grayColor];
        [backView addSubview:xinHuo];

        
        
        UILabel *b = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 60, 15)];
        b.backgroundColor = [UIColor clearColor];
        b.text = @"人均消费:";
        b.textColor = [UIColor grayColor];
        b.font = [UIFont systemFontOfSize:12];
        [backView addSubview:b];
        
        
        hwoMuch = [[UILabel alloc]initWithFrame:CGRectMake(165, 50, 60, 15)];
        hwoMuch.backgroundColor = [UIColor clearColor];
        hwoMuch.text = @"50元/小时";
        hwoMuch.textColor = [UIColor grayColor];
        hwoMuch.font = [UIFont systemFontOfSize:12];
        [backView addSubview:hwoMuch];
        
        
        
        UILabel *c = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, 60, 15)];
        c.backgroundColor = [UIColor clearColor];
        c.text = @"配套设施:";
        c.font = [UIFont systemFontOfSize:12];
        c.textColor = [UIColor grayColor];
        [backView addSubview:c];
     
        numImageView = [[UIImageView alloc]initWithFrame:CGRectMake(165, 74, SCREEN_WIDTH - 170, 20)];
        [backView addSubview:numImageView];
        
        NSArray *array = [NSArray arrayWithObjects:@"icon_ptss_wifi",@"icon_ptss_stop",@"icon_ptss_TV",@"icon_ptss_chess",@"icon_ptss_food",@"icon_ptss_room", nil];
        for (int i = 0; i < 6; i ++ ) {
            
            UIImageView *mn = [[UIImageView alloc]initWithFrame:CGRectMake(i * numImageView.frame.size.width/6, 0, 18, 18)];
            mn.image = [UIImage imageNamed:[array objectAtIndex:i]];
            [numImageView addSubview:mn];
        }
        
        
        
        qiangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        qiangBtn.frame = CGRectMake(0, 100, SCREEN_WIDTH, 30);
        [qiangBtn setTitle:@"抢购和预定" forState:UIControlStateNormal];
        qiangBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [qiangBtn setTitleColor:R_G_B_COLOR(50, 221, 161) forState:UIControlStateNormal];
        qiangBtn.backgroundColor = [UIColor clearColor];
        [backView addSubview:qiangBtn];
        
        
        laView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, 50)];
        laView.alpha = 0;
        [backView addSubview:laView];
        
        
        
        
        laMessage = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 160, 15)];
        laMessage.text = @"抢购抢购抢购抢购抢购";
        laMessage.textColor = [UIColor grayColor];
        laMessage.font = [UIFont systemFontOfSize:14];
        [laView addSubview:laMessage];
        
        laPriceLabel  =[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 100, 15)];
        laPriceLabel.text = @"¥100";
        laPriceLabel.textColor = [UIColor orangeColor];
        laPriceLabel.font = [UIFont systemFontOfSize:14];
        [laView addSubview:laPriceLabel];
        
        
        
        
        
        anoLaMessage = [[UILabel alloc]initWithFrame:CGRectMake(10, 5 + 45, 160, 15)];
        anoLaMessage.text = @"抢购抢购抢购抢购抢购";
        anoLaMessage.textColor = [UIColor grayColor];
        anoLaMessage.font = [UIFont systemFontOfSize:14];
        [laView addSubview:anoLaMessage];
        
        anoLaPriceLabel  =[[UILabel alloc]initWithFrame:CGRectMake(10, 25 + 45, 100, 15)];
        anoLaPriceLabel.text = @"¥100";
        anoLaPriceLabel.textColor = [UIColor orangeColor];
        anoLaPriceLabel.font = [UIFont systemFontOfSize:14];
        [laView addSubview:anoLaPriceLabel];

        
        
        
        UIImageView *li = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 1)];
        li.backgroundColor = R_G_B_COLOR(221, 221, 221);
        [laView addSubview:li];
        
        
        
        maiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [maiBtn setTitle:@"抢购" forState:UIControlStateNormal];
        [maiBtn setTitleColor:R_G_B_COLOR(50, 221, 161) forState:UIControlStateNormal];
        maiBtn.layer.borderWidth = 0.5;
        maiBtn.layer.borderColor = R_G_B_COLOR(50, 221, 161).CGColor;
        maiBtn.layer.cornerRadius = 4;
        maiBtn.frame = CGRectMake(260, 13, 50, 25);
        maiBtn.titleLabel.font = [UIFont systemFontOfSize:14];

        [laView addSubview:maiBtn];
        
        dingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [dingBtn setTitle:@"预定" forState:UIControlStateNormal];
        [dingBtn setTitleColor:R_G_B_COLOR(50, 221, 161) forState:UIControlStateNormal];
        dingBtn.frame = CGRectMake(260, 13 + 40, 50, 25);
        dingBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        dingBtn.layer.borderWidth = 0.5;
        dingBtn.layer.borderColor = R_G_B_COLOR(50, 221, 161).CGColor;
        dingBtn.layer.cornerRadius = 4;

        
        [laView addSubview:dingBtn];
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
