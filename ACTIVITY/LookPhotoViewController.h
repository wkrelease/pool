//
//  LookPhotoViewController.h
//  Care
//
//  Created by king on 14-12-31.
//  Copyright (c) 2014年 king. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"

@interface LookPhotoViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate>{
    
        
}

@property (nonatomic,strong)NSMutableArray *photoArray;

@property (nonatomic,assign)long currentIndex;

//@property (nonatomic, retain) MRZoomScrollView  *zoomScrollView;


@end
