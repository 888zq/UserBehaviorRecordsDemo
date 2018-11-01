//
//  UINavigationController+ZQHook.h
//  UserBehaviorRecordsDemo
//
//  Created by zhangYuShuai on 2018/11/1.
//  Copyright © 2018年 zhangYuShuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ZQHook)

+ (void)hookUINavigationController_push;
+ (void)hookUINavigationController_pop;

@end
