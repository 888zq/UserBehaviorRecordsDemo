//
//  UIApplication+HLCHook.m
//  UserBehaviorRecordsDemo
//
//  Created by zhangYuShuai on 2018/11/1.
//  Copyright © 2018年 zhangYuShuai. All rights reserved.
//

#import "UIApplication+HLCHook.h"
#import <objc/runtime.h>

@implementation UIApplication (HLCHook)

+ (void)hookUIApplication
{
    //利用Objective-C的动态特性，可以实现在运行时偷换selector对应的方法，达到给方法hook的目的
    /*
     用 method_exchangeImplementations 方法来交换2个方法中的IMP
     用 class_replaceMethod 方法来修改类
     用 method_setImplementation 方法来直接设置某个方法的IMP
     */
    /*
     Target-Action
     
     对于一个给定的事件，UIControl会调用sendAction:to:forEvent:来将行为消息转发到UIApplication对象，再由UIApplication对象调用其sendAction:to:fromSender:forEvent:方法来将消息分发到指定的target上，而如果我们没有指定target，则会将事件分发到响应链上第一个想处理消息的对象上。
       而如果子类想监控或修改这种行为的话，则可以重写这个方法。
     */
    Method controlMethod = class_getInstanceMethod([UIApplication class], @selector(sendAction:to:from:forEvent:));
    Method hookMethod = class_getInstanceMethod([self class], @selector(hook_sendAction:to:from:forEvent:));
    method_exchangeImplementations(controlMethod, hookMethod);
}

- (BOOL)hook_sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event
{
    NSString * actionDetailInfo = [NSString stringWithFormat:@"%@ - %@ - %@",NSStringFromClass([target class]),NSStringFromClass([sender class]),NSStringFromSelector(action)];
    NSLog(@"%@",actionDetailInfo);
    return [self hook_sendAction:action to:target from:sender forEvent:event];
}

@end
