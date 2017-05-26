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

- (IBAction)clickChangeColor:(id)sender {
    NSInteger index = arc4random() % 4;
    UIColor *color = [UIColor redColor];
    switch (index) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor grayColor];
            break;
        case 2:
            color = [UIColor greenColor];
            break;
        case 3:
            color = [UIColor blueColor];
            break;
        default:
            break;
    }
    
    self.gjGroupButton.badgeColor = color;
}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    self.gjGroupButton.badgeValue = sender.text.length ? sender.text : nil;
}

- (IBAction)offsetChangedX:(UISlider *)slider {
    CGPoint offset = self.gjGroupButton.badgeOffset;
    offset.x = slider.value;
    self.gjGroupButton.badgeOffset = offset;
}

- (IBAction)offsetChangedY:(UISlider *)slider {
    CGPoint offset = self.gjGroupButton.badgeOffset;
    offset.y = slider.value;
    self.gjGroupButton.badgeOffset = offset;
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
