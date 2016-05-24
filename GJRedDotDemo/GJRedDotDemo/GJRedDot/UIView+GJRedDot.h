//
//  UIView+GJRedDot.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/18.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GJRedDot)

@property (nonatomic, assign) BOOL showRedDot;

//影响宽高位置
@property (nonatomic, assign) CGFloat redDotRadius;

//位置
@property (nonatomic, assign) CGPoint redDotOffset;

//只是颜色
@property (nonatomic, strong) UIColor *redDotColor;

//
@property (nonatomic, strong) UIView *customView;

@end
