//
//  faBuCell.m
//  POOL
//
//  Created by king on 15-3-1.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "faBuCell.h"

@implementation faBuCell

@synthesize head;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    
        head = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        head.image = [UIImage imageNamed:@"demo"];
        head.contentMode = UIViewContentModeScaleAspectFill;
        head.clipsToBounds = YES;
        [self addSubview:head];
        
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







