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

@interface SecondViewController () {

}

@property (nonatomic, weak) IBOutlet UIButton *gjGroupButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weakSelf = self;

    [self setRedDotKey:GJGroupKey refreshBlock:^(BOOL show) {
        weakSelf.gjGroupButton.showRedDot = show;
    } handler:self];

}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    self.gjGroupButton.badgeValue = sender.text.length ? sender.text : nil;
}

- (IBAction)offsetChangedX:(UISlider *)slider {
    CGPoint offset = self.gjGroupButton.redDotOffset;
    offset.x = slider.value;
    self.gjGroupButton.redDotOffset = offset;
}

- (IBAction)offsetChangedY:(UISlider *)slider {
    CGPoint offset = self.gjGroupButton.redDotOffset;
    offset.y = slider.value;
    self.gjGroupButton.redDotOffset = offset;}

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
