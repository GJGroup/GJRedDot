//
//  UITabBarItem+GJRedDot.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/3/31.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (GJRedDot)

/**
 *  是否显示小红点
 */
@property (nonatomic, assign) BOOL isShowRedDot;

/**
 *  小红点半径，控制大小
 */
@property (nonatomic, assign) CGFloat redDotRadius;

/**
 *  小红点位置偏移，(0,0)默认情况下是:
 *  x:中心偏右10个坐标
 *  y:中心偏上15个坐标
 *  通过offset可以在这基础上偏移
 */
@property (nonatomic, assign) CGPoint redDotOffset;

/**
 *  好吧，小红点颜色当然是红色的…起名真难……
 *  默认是redColor，也可以自己定义
 */
@property (nonatomic, strong) UIColor *redDotColor;

/**
 *  自定义小红点图标，如果set nil，则恢复小红点
 */
@property (nonatomic, strong) UIView *customView;

@end
