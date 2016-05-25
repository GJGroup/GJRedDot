//
//  SecondViewController.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/23.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "SecondViewController.h"
#import "GJRedDot.h"
#import "GJRedDotRegister.h"

@interface SecondViewController ()

@property (nonatomic, weak) IBOutlet UIButton *gjGroupButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    [self setRedDotKey:GJTabBar2 refreshBlock:^(BOOL show) {
        weakSelf.navigationController.tabBarItem.isShowRedDot = show;
    } handler:self];
    
    [self setRedDotKey:GJGroupKey refreshBlock:^(BOOL show) {
        weakSelf.gjGroupButton.showRedDot = show;
    } handler:self];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.gjGroupButton.redDotRadius = 10;
    self.gjGroupButton.redDotOffset = CGPointMake(10, 10);
    self.gjGroupButton.redDotColor = [UIColor blueColor];
    self.gjGroupButton.redDotBorderWitdh = 2;
    self.gjGroupButton.redDotBorderColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
