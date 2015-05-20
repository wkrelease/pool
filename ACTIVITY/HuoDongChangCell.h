//
//  HuoDongChangCell.h
//  POOL
//
//  Created by king on 15-2-11.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HuoDongChangCell : UITableViewCell

@property (nonatomic,strong)UIImageView *backView;

@property (nonatomic,strong)UIImageView *headView;

@property (nonatomic,strong)UILabel *name;

@property (nonatomic,strong)UILabel *address;

@property (nonatomic,strong)UILabel *xinHuo;

@property (nonatomic,strong)UILabel *hwoMuch;

@property (nonatomic,strong)UIImageView *numImageView;


@property (nonatomic,strong)UIButton *qiangBtn;

@property (nonatomic,strong)UIImageView *laView;

@property (nonatomic,strong)UILabel *laMessage;

@property (nonatomic,strong)UILabel *laPriceLabel;


@property (nonatomic,strong)UILabel *anoLaMessage;
@property (nonatomic,strong)UILabel *anoLaPriceLabel;




@property (nonatomic,strong)UIButton *maiBtn;

@property (nonatomic,strong)UIButton *dingBtn;

@end
