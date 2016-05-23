//
//  SecondDetailViewController.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/23.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "SecondDetailViewController.h"
#import "GJRedDotRegister.h"
#import "GJRedDot.h"

@interface SecondDetailViewController ()

@property (nonatomic, weak) IBOutlet UIButton *sunnyxxGayButton;
@property (nonatomic, weak) IBOutlet UIButton *birdButton;
@property (nonatomic, weak) IBOutlet UIButton *sarkGayButton;


@end

@implementation SecondDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    [self setRedDotKey:GJSunnyxxKey refreshBlock:^(BOOL show) {
        weakSelf.sunnyxxGayButton.showRedDot = show;
    } handler:self];
    [self setRedDotKey:GJUncleBirdKey refreshBlock:^(BOOL show) {
        weakSelf.birdButton.showRedDot = show;
    } handler:self];
    [self setRedDotKey:GJSardKey refreshBlock:^(BOOL show) {
        weakSelf.sarkGayButton.showRedDot = show;
    } handler:self];
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
