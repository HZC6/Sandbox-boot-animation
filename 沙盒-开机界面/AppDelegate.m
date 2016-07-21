//
//  AppDelegate.m
//  沙盒-开机界面
//
//  Created by mac1 on 16/7/19.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "AppDelegate.h"
#import "StartViewController.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1. 初始化_window对象
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置背景颜色
    _window.backgroundColor = [UIColor whiteColor];
    //设置主窗口并显示
    [_window makeKeyAndVisible];

    
    //2.引入沙盒，来控制启动动画
    //1) 获取当前的版本号
    double currentVersion = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]doubleValue];
    
    //2) 通过“沙盒”中获取上一版本号
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //3) 版本号解析
    double lastVersion = [[userDefaults objectForKey:@"version"] doubleValue];
 
    
    //4) 判断：如果当前的版本号与上一版本号相同，就无需引导页
    if (currentVersion > lastVersion) {
        
        //5) 启动引导页
        _window.rootViewController = [[StartViewController alloc] init];
        
        //6) 将新的版本号写入沙盒中
        [userDefaults setObject:@(currentVersion) forKey:@"version"];
        
    } else {
        
        //7) 如果不是，就直接跳转到指定页面
        _window.rootViewController = [[ViewController alloc] init];
        
    }
    
    return YES;
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
