//
//  UIViewController+ZQHook.m
//  UserBehaviorRecordsDemo
//
//  Created by zhangYuShuai on 2018/11/1.
//  Copyright © 2018年 zhangYuShuai. All rights reserved.
//

#import "UIViewController+ZQHook.h"
#import <objc/runtime.h>

@implementation UIViewController (ZQHook)

+ (void)hookUIViewController
{
    Method appearMethod = class_getInstanceMethod([self class], @selector(viewDidAppear:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_ViewDidAppear:));
    method_exchangeImplementations(appearMethod, hookMethod);
}
- (void)hook_ViewDidAppear:(BOOL)animated
{
    NSString *appearDetailInfo = [NSString stringWithFormat:@" %@ - %@", NSStringFromClass([self class]), @"didAppear"];
    NSLog(@"%@", appearDetailInfo);
    [self hook_ViewDidAppear:animated];
}


@end
