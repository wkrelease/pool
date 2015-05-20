//
//  ImgPhotoCell.m
//  POOL
//
//  Created by king on 15/3/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "ImgPhotoCell.h"

@implementation ImgPhotoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        _image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _image.contentMode = UIViewContentModeScaleAspectFill;
        _image.clipsToBounds = YES;
        [self addSubview:_image];
        
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
