//
//  AppDelegate.m
//  UserBehaviorRecordsDemo
//
//  Created by zhangYuShuai on 2018/11/1.
//  Copyright © 2018年 zhangYuShuai. All rights reserved.
//

#import "AppDelegate.h"
#import "UIApplication+HLCHook.h"
#import "UIViewController+ZQHook.h"
#import "UINavigationController+ZQHook.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController * navVC = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
    self.window.rootViewController = navVC;
    
    [UIApplication hookUIApplication];
    [UIViewController hookUIViewController];
    [UINavigationController hookUINavigationController_pop];
    [UINavigationController hookUINavigationController_push];
    //当真机连接Mac调试的时候把这些注释掉，否则log只会输入到文件中，而不能从xcode的监视器中看到。
    // 如果是真机就保存到Document目录下的dr.log文件中
//    UIDevice *device = [UIDevice currentDevice];
//    if (![[device model]isEqualToString:@"iPad Simulator"]) {
//        // 开始保存日志文件
//        [self redirectNSlogToDocumentFolder];
//    }
  
    return YES;
}

#pragma mark -- 将监视器日志保存到文件中
- (void)redirectNSlogToDocumentFolder
{
    /*
     * 在应用程序的Info.plist文件中添加UIFileSharingEnabled键，并将键值设置为YES。将您希望共享的文件放在应用程序的 Documents目录。一旦设备插入到用户计算机，iTunes9.1就会在选中设备的Apps标签中显示一个File Sharing区域。此后，用户就可以向该目录添加文件或者将文件移动到桌面计算机中。如果应用程序支持文件共享，当文件添加到Documents目录后，应用程序应该能够识别并做出适当响应。例如说，应用程序可以将新文件的内容显示界面上。请不要向用户展现目录的文件列表并询问他们希望对文件执行什么操作。
     */
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"dr.log"];//注意不是NSData!
    
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    //先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+", stdout);
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+", stderr);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
