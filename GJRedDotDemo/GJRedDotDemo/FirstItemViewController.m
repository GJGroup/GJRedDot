//
//  FirstItemViewController.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/23.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "FirstItemViewController.h"
#import "GJRedDot.h"

@interface FirstItemViewController () {
    NSInteger _colorIndex;
    CGPoint _offset;
}

@property (nonatomic, weak) IBOutlet UIButton *button;

@end

@implementation FirstItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.tabBarItem.isShowRedDot = YES;
    self.navigationController.tabBarItem.redDotBorderColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}

- (IBAction)showButton:(UIButton *)sender {
    self.navigationController.tabBarItem.isShowRedDot = !self.navigationController.tabBarItem.isShowRedDot;
    NSString *btnTitle = self.navigationController.tabBarItem.isShowRedDot ? @"To Hide" : @"To Show";
    [sender setTitle:btnTitle forState:UIControlStateNormal];
}

- (IBAction)changeIcon:(UIButton *)sender {
    if (self.navigationController.tabBarItem.customView) {
        self.navigationController.tabBarItem.customView = nil;
    }
    else {
        UIImage *image = [UIImage imageNamed:@"customView"];
        UIImageView *customImageView = [[UIImageView alloc]initWithImage:image];
        self.navigationController.tabBarItem.customView = customImageView;
    }
}

- (IBAction)changeRadius:(UISlider *)sender {
    self.navigationController.tabBarItem.redDotRadius = sender.value;
}

- (IBAction)changeOffsetX:(UISlider *)sender {
    _offset.x = sender.value;
    self.navigationController.tabBarItem.redDotOffset = _offset;
}

- (IBAction)changeOffsetY:(UISlider *)sender {
    _offset.y = sender.value;
    self.navigationController.tabBarItem.redDotOffset = _offset;
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
        self.navigationController.tabBarItem.redDotColor = color;
    }
    
    _colorIndex ++;
    if (_colorIndex == 5) {
        _colorIndex = 0;
    }
}

- (IBAction)changeBorderWidth:(UISlider *)sender {
    self.navigationController.tabBarItem.redDotBorderWitdh = sender.value;
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
