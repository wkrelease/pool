//
//  LookPhotoViewController.m
//  Care
//
//  Created by king on 14-12-31.
//  Copyright (c) 2014年 king. All rights reserved.
//

#import "LookPhotoViewController.h"
#import "UIImageView+WTImageCache.h"

@implementation LookPhotoViewController

@synthesize photoArray,currentIndex;

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor =[UIColor cyanColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIScrollView *photo = [[UIScrollView alloc]initWithFrame:CGRectMake(X_OFF_SET, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT)];
    photo.backgroundColor = [UIColor blackColor];
    photo.bounces = NO;
    photo.pagingEnabled = YES;
    photo.delegate= self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dis)];
    photo.tag = 199;
    photo.userInteractionEnabled = YES;
    [photo addGestureRecognizer:tap];
    photo.contentSize = CGSizeMake(SCREEN_WIDTH * photoArray.count, SCREEN_HEIGHT);
    [self.view addSubview:photo];
    
    photo.contentOffset = CGPointMake(SCREEN_WIDTH * currentIndex, 0);
    
    for (int i = 0; i < photoArray.count; i ++) {
        
//        UIScrollView *_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT)];//申明一个scrollview
//        _scrollView.delegate=self;//需要在.h中引用scrollview的delegate
//        _scrollView.backgroundColor=[UIColor clearColor];
//       
//        _scrollView.alpha=1.0;
//        _scrollView.tag = 200 + i;
//        [photo addSubview: _scrollView];
//
//        
//        
//        UIImageView*_imageView=[[UIImageView alloc] initWithFrame:CGRectMake(X_OFF_SET, Y_OFF_SET, SCREEN_WIDTH, SCREEN_HEIGHT)];//申明一个imageview
//        _imageView.tag = 300 + i;
//        _imageView.image=[UIImage imageNamed:@"dede.jpg"];
//        _imageView.userInteractionEnabled=YES;
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [_scrollView addSubview:_imageView];//需要将imageview添加到scrollview上
        
        
        MRZoomScrollView*_zoomScrollView = [[MRZoomScrollView alloc]init];
        CGRect frame = photo.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = 0;
        _zoomScrollView.frame = frame;
        [_zoomScrollView.imageView setImageWithURL:[NSURL URLWithString:[photoArray objectAtIndex:i]]];
        [photo addSubview:_zoomScrollView];
        
        
    }
    
    
}



- (void)dis{
    
    
    CATransition *transition = [CATransition animation];
    transition.type = @"rippleEffect";
    transition.duration = 0.7;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];

    [self.navigationController popViewControllerAnimated:NO];
    
//    [self dismissViewControllerAnimated:NO completion:nil];
    
}

//int num = 0;
//
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    
//    if (scrollView.tag == 199) {
//        
//        num = scrollView.contentOffset.x/SCREEN_WIDTH;
//        
//    }
//    
//    
//}










//-(void)tapGesAction:(UIGestureRecognizer*)gestureRecognizer//手势执行事件
//{
//    
//    UIScrollView *scro = (UIScrollView *)[self.view viewWithTag:200 + num];
//    
//    float newscale=0.2*1.5;
//    CGRect zoomRect = [self zoomRectForScale:newscale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
//    NSLog(@"zoomRect:%@",NSStringFromCGRect(zoomRect));
//    [scro zoomToRect:zoomRect animated:YES];//重新定义其cgrect的x和y值
//    //    [_scrollView setZoomScale:newscale animated:YES];//以原先中心为点向外扩
//}
//
//-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView//scrollview的delegate事件。需要设置缩放才会执行。
//{
//    
//    UIImageView *imv = (UIImageView *)[self.view viewWithTag:300 + num];
//    
//    return imv;
//    
//}
//
//
//- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {//传入缩放比例和手势的点击的point返回<span style="color:#ff0000;">缩放</span>后的scrollview的大小和X、Y坐标点
//    
//    UIScrollView *scro = (UIScrollView *)[self.view viewWithTag:200 + num];
//    
//    CGRect zoomRect;
//    
//    // the zoom rect is in the content view's coordinates.
//    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
//    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
//   
//    zoomRect.size.height = [scro frame].size.height / scale;
//    
//    zoomRect.size.width  = [scro frame].size.width  / scale;
//    
//    // choose an origin so as to get the right center.
//    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
//    //    zoomRect.origin.x=center.x;
//    //    zoomRect.origin.y=center.y;
//    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
//    
//    return zoomRect;
//    
//}






@end
