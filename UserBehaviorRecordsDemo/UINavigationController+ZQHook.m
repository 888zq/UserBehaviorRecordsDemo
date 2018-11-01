//
//  UINavigationController+ZQHook.m
//  UserBehaviorRecordsDemo
//
//  Created by zhangYuShuai on 2018/11/1.
//  Copyright © 2018年 zhangYuShuai. All rights reserved.
//

#import "UINavigationController+ZQHook.h"
#import <objc/runtime.h>

@implementation UINavigationController (ZQHook)

+ (void)hookUINavigationController_push
{
    Method pushMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_pushViewController:animated:));
    method_exchangeImplementations(pushMethod, hookMethod);
}
- (void)hook_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSString *popDetailInfo = [NSString stringWithFormat: @"%@ - %@ - %@", NSStringFromClass([self class]), @"push", NSStringFromClass([viewController class])];
    NSLog(@"%@", popDetailInfo);
    [self hook_pushViewController:viewController animated:animated];
}

+ (void)hookUINavigationController_pop
{
    Method popMethod = class_getInstanceMethod([self class], @selector(popViewControllerAnimated:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_popViewControllerAnimated:));
    method_exchangeImplementations(popMethod, hookMethod);
}
- (nullable UIViewController *)hook_popViewControllerAnimated:(BOOL)animated
{
    NSString *popDetailInfo = [NSString stringWithFormat:@"%@ - %@", NSStringFromClass([self class]), @"pop"];
    NSLog(@"%@", popDetailInfo);
    return [self hook_popViewControllerAnimated:animated];
}

@end
