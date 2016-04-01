//
//  FirstViewController.m
//  GJTabBarItem
//
//  Created by wangyutao on 16/3/31.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "FirstViewController.h"
#import "UITabBarItem+GJRedDot.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (IBAction)showButton:(UIButton *)sender {
    self.tabBarItem.isShowRedDot = !self.tabBarItem.isShowRedDot;
    NSString *btnTitle = self.tabBarItem.isShowRedDot ? @"To Hide" : @"To Show";
    [sender setTitle:btnTitle forState:UIControlStateNormal];
}

- (IBAction)changeIcon:(UIButton *)sender {
    if (self.tabBarItem.customView) {
        self.tabBarItem.customView = nil;
    }
    else {
        UIImage *image = [UIImage imageNamed:@"icon"];
        UIImageView *customImageView = [[UIImageView alloc]initWithImage:image];
        customImageView.frame = CGRectMake(0, 0, 10, 10);
        self.tabBarItem.customView = customImageView;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
