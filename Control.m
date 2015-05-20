//
//  Control.m
//  MMDScorProj
//
//  Created by YiDianTime on 14-4-29.
//  Copyright (c) 2014年 张朵. All rights reserved.
//

#import "Control.h"

@implementation Control

+(UIButton *)creatButton:(NSString *)name frame:(CGRect)frame  delegate:(id)delegate selector:(SEL)selector  img:(NSString *)imge{
    
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:delegate action:selector forControlEvents:UIControlEventTouchUpInside];
    
   
    
    button.frame=frame;
    [button setImage:[UIImage imageNamed:imge] forState:UIControlStateNormal];
    button.titleLabel.numberOfLines=0;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setTitle:name forState:UIControlStateNormal];
    return button;
    
}

+(UILabel *)creatLabel:(NSString *)name frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor{
    
    UILabel *label=[[UILabel alloc]initWithFrame:frame];
    label.text=name;
    label.textColor=textColor;
    label.font=font;
    label.numberOfLines=0;

    return label;
}

+(UITextField *)creatTextFiled:(NSString *)placeHolder frame:(CGRect)frame delegate:(id)delegate  /*tag:(NSInteger )tag*/{
    
    UITextField *textFiled=[[UITextField alloc]initWithFrame:frame];
    textFiled.delegate=delegate;
    textFiled.placeholder=placeHolder;
//    textFiled.borderStyle=UITextBorderStyleLine;
   // textFiled.tag=tag;
    return textFiled;
}
+(UIView *)creatView:(CGRect)frame bgColor:(UIColor *)bgColor{
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=bgColor;
    return view;
}
+(UIImageView *)creatImageView:(CGRect)frame imageName:(NSString *)imageName {
    
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame=frame;
    imageView.userInteractionEnabled=YES;
    return imageView;
    
}

+(UIImageView *)createCirleImageView:(CGRect)frame imageName:(NSString *)imageName borderWidth:(float)wigth borderCorlor:(UIColor *)color{

    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame=frame;
    imageView.userInteractionEnabled=YES;
    
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=frame.size.height/2;
    imageView.layer.borderWidth=wigth;
    imageView.layer.borderColor=color.CGColor;
    
    return imageView;

}

+(UIAlertView *)createAlertViewTit:(NSString *)title Message:(NSString *)Meg button:(NSString *)OkStr otherBtn:(id) otherB{

    UIAlertView * Alert=[[UIAlertView alloc]initWithTitle:title message:Meg delegate:self cancelButtonTitle:OkStr otherButtonTitles:otherB, nil];
    return Alert;
}

+ (CGFloat) getDeviceHeight {
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    return rect.size.height;
}
+ (CGFloat) getDeviceWidth {
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    return rect.size.width;
}

+ (BOOL) isIPhone5 {
    
    //(320,568)
    if ([[self class] getDeviceHeight] == 1136/2){
        return YES;
    }
    return NO;
}
+ (BOOL) isIPad {
    
    if ([[self class] getDeviceHeight] == 1024){
        return YES;
    }
    return NO;
}

+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

@end
