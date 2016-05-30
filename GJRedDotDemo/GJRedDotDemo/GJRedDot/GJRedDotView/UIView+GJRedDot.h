//
//  UIView+GJRedDot.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/18.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GJRedDot)

/**
 *  是否显示小红点
 */
@property (nonatomic, assign) BOOL showRedDot;

/**
 *  小红点半径
 */
@property (nonatomic, assign) CGFloat redDotRadius;

/**
 *  小红点偏移量
 */
@property (nonatomic, assign) CGPoint redDotOffset;

/**
 *  小红点颜色
 */
@property (nonatomic, strong) UIColor *redDotColor;

/**
 *  红点的边线宽度，默认0
 */
@property (nonatomic, assign) CGFloat redDotBorderWitdh;

/**
 *  小红点边线颜色，默认白色
 */
@property (nonatomic, strong) UIColor *redDotBorderColor;

/**
 *  显示badge, badge优先于小红点
 */
@property (nonatomic, copy) NSString *badgeValue;

@end
