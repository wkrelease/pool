//
//  Control.h
//  MMDScorProj
//
//  Created by YiDianTime on 14-4-29.
//  Copyright (c) 2014年 张朵. All rights reserved.
//
#define kScreenHeight [Control getDeviceHeight]
#define kScreenWidth [Control getDeviceWidth]
#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>

@interface Control : NSObject
//适配设备
+(CGFloat)getDeviceHeight;
+(CGFloat)getDeviceWidth;
+(BOOL)isIPhone5;
+ (BOOL) isIPad;


//创建按钮
+(UIButton *)creatButton:(NSString *)name frame:(CGRect)frame  delegate:(id)delegate selector:(SEL)selector img:(NSString *)imge ;

//创建标签
+(UILabel *)creatLabel:(NSString *)name frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor;
//创建输入框
+(UITextField *)creatTextFiled:(NSString *)placeHolder frame:(CGRect)frame delegate:(id)delegate  /*tag:(NSInteger )tag*/;

//创建视图
+(UIView *)creatView:(CGRect)frame bgColor:(UIColor *)bgColor ;

//创建图片视图
+(UIImageView *)creatImageView:(CGRect)frame imageName:(NSString *)imageName ;

//创建圆形图片（设置边框）
+(UIImageView *)createCirleImageView:(CGRect)frame imageName:(NSString *)imageName  borderWidth:(float)wigth borderCorlor:(UIColor *)color;

//创建提示框
+(UIAlertView *)createAlertViewTit:(NSString *)title Message:(NSString *)Meg button:(NSString *)OkStr otherBtn:(id) otherB;

//是不是手机号码
+(BOOL) isValidateMobile:(NSString *)mobile;

//是不是邮箱
+(BOOL)isValidateEmail:(NSString *)email;
@end
