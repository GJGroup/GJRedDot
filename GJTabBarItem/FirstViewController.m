//
//  FirstViewController.m
//  GJTabBarItem
//
//  Created by wangyutao on 16/3/31.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "FirstViewController.h"
#import "UITabBarItem+GJRedDot.h"

@interface FirstViewController () {
    NSInteger _colorIndex;
    CGPoint _offset;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.isShowRedDot = YES;
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

- (IBAction)changeRadius:(UISlider *)sender {
    self.tabBarItem.redDotRadius = sender.value;
}

- (IBAction)changeOffsetX:(UISlider *)sender {
    _offset.x = sender.value;
    self.tabBarItem.redDotOffset = _offset;
}

- (IBAction)changeOffsetY:(UISlider *)sender {
    _offset.y = sender.value;
    self.tabBarItem.redDotOffset = _offset;
}

- (IBAction)changeColor:(id)sender {
    UIColor *color = nil;
    switch (_colorIndex) {
        case 0:
            color = [UIColor blueColor];
            break;
        case 1:
            color = [UIColor yellowColor];
            break;
        case 2:
            color = [UIColor blackColor];
            break;
        case 3:
            color = [UIColor greenColor];
            break;
        case 4:
            color = [UIColor redColor];
            break;
        default:
            break;
    }
    
    if (color) {
        self.tabBarItem.redDotColor = color;
    }
    
    _colorIndex ++;
    if (_colorIndex == 5) {
        _colorIndex = 0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
