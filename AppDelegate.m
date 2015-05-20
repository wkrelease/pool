//
//  AppDelegate.m
//  POOL
//
//  Created by king on 15-2-9.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LoginViewController.h"



#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#define UMENG_APPKEY @"5472def7fd98c59068001736"


#import "EaseMob.h"

#import <SMS_SDK/SMS_SDK.h>

@implementation AppDelegate


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    [SMS_SDK registerApp:@"48986ad6e2c5" withSecret:@"fb99e00979212cc45dae4ff407a77230"];
    
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleExpand];

    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;//导航栏颜色变白色

    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
#pragma mark test
//    [def setObject:@"1" forKey:USER_NAME];
    
    if ([def objectForKey:USER_NAME]) {
        
        RootViewController *root = [[RootViewController alloc]init];
        UINavigationController *navi=  [[UINavigationController alloc]initWithRootViewController:root];
        self.window.rootViewController = navi;
        
    }else{
        
        LoginViewController *login = [[LoginViewController alloc]init];
        UINavigationController *logNav = [[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = logNav;
        
    }
    
    
    [self.window makeKeyAndVisible];
    
    
    
    
    
    
//#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
//    NSString *apnsCertName = nil;
//#if DEBUG
//    apnsCertName = @"yidiantime";
//#else
//    apnsCertName = @"yidiantime";
//#endif
//    [[EaseMob sharedInstance] registerSDKWithAppKey:@"yidiantime#bailixi" apnsCertName:apnsCertName];
//    
//#if DEBUG
//    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
//#endif
//    [[[EaseMob sharedInstance] chatManager] setAutoFetchBuddyList:YES];
//    
//    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
//    //demo中此监听方法在MainViewController中
//    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    
    
//#if !TARGET_IPHONE_SIMULATOR
//    //    UIApplication *application = [UIApplication sharedApplication];
//    //
//    //    iOS8 注册APNS
//    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
//        [application registerForRemoteNotifications];
//        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
//        [application registerUserNotificationSettings:settings];
//    }else{
//        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
//        UIRemoteNotificationTypeSound |
//        UIRemoteNotificationTypeAlert;
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
//    }
//    
//#endif
    
    
//    if ([def objectForKey:@"uid"]) {
//        
//        NSString *MDNAME = [[def objectForKey:@"name"]MD5Hash];
//        NSString *MDPASS = [[def objectForKey:@"password"]MD5Hash];
//        
//        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:MDNAME password:MDPASS completion:^(NSDictionary *loginInfo, EMError *error) {
//            
//            
//        } onQueue:nil];
//        
//    }
    
    

    
 /*
    
    
#warning SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"yidiantime";
#else
    apnsCertName = @"yidiantime";
#endif
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"yidiantime#bailixi" apnsCertName:apnsCertName];
    
#if DEBUG
    [[EaseMob sharedInstance] enableUncaughtExceptionHandler];
#endif
    [[[EaseMob sharedInstance] chatManager] setAutoFetchBuddyList:YES];
    
    //以下一行代码的方法里实现了自动登录，异步登录，需要监听[didLoginWithInfo: error:]
    //demo中此监听方法在MainViewController中
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
#if !TARGET_IPHONE_SIMULATOR
    //    UIApplication *application = [UIApplication sharedApplication];
    //
    //    iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }else{
        UIRemoteNotificationType notificationTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeSound |
        UIRemoteNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:notificationTypes];
    }
    
#endif
    
    if ([def objectForKey:@"uid"]) {
        
        NSString *MDNAME = [[def objectForKey:@"name"]MD5Hash];
        NSString *MDPASS = [[def objectForKey:@"password"]MD5Hash];
        
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:MDNAME password:MDPASS completion:^(NSDictionary *loginInfo, EMError *error) {
            
            
        } onQueue:nil];
        
    }
    

    
    
    */
    
    
    
    
#pragma mark 友盟
    
    
    
    [UMSocialData setAppKey:UMENG_APPKEY];
    
    [UMSocialWechatHandler setWXAppId:@"wx11010f821017277f" appSecret:@"f11e97c78b570f89966e5fe54a8ec907" url:@"http://www.baidu.com"];
    
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com"];
    

    
    [[EaseMob sharedInstance] registerSDKWithAppKey:@"douser#istore" apnsCertName:@"istore_dev"];
    
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    

    
    return YES;
}


#pragma mark 推送


////系统方法
//-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    //SDK方法调用
//    [[EaseMob sharedInstance] application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//}
//
////系统方法
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    //SDK方法调用
//    [[EaseMob sharedInstance] application:application didFailToRegisterForRemoteNotificationsWithError:error];
//
//}
//
////系统方法
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //SDK方法调用
//    
//    
//    [[EaseMob sharedInstance] application:application didReceiveRemoteNotification:userInfo];
//
//}
//
////系统方法
//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
//{
//    //SDK方法调用
//    [[EaseMob sharedInstance] application:application didReceiveLocalNotification:notification];
//
//}








							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    
    
//    [[EaseMob sharedInstance] applicationWillResignActive:application];

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   
    
//    [[EaseMob sharedInstance] applicationDidEnterBackground:application];

    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    
//    [[EaseMob sharedInstance] applicationWillEnterForeground:application];

    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  
    
//    [[EaseMob sharedInstance] applicationDidBecomeActive:application];

    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
   
//    [[EaseMob sharedInstance] applicationWillTerminate:application];

    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





@end
