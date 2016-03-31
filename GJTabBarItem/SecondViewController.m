//
//  SecondViewController.m
//  GJTabBarItem
//
//  Created by wangyutao on 16/3/31.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "SecondViewController.h"
#import "UITabBarItem+GJRedDot.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.tabBarItem.isShowRedDot = !self.tabBarItem.isShowRedDot;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
