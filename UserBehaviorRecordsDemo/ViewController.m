//
//  ViewController.m
//  UserBehaviorRecordsDemo
//
//  Created by zhangYuShuai on 2018/11/1.
//  Copyright © 2018年 zhangYuShuai. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"控制器一";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"login" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)sender
{
    NSLog(@"我被点击了");
    SecondViewController * secondVC = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
