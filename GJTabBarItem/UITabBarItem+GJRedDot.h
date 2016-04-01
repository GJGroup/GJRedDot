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
 *  y:7.5(距tabbar顶部7.5个坐标)
 *  通过offset可以在这基础上偏移
 */
@property (nonatomic, assign) CGPoint redDotOffset;

/**
 *  自定义小红点图标，如果set nil，则恢复小红点
 */
@property (nonatomic, strong) UIView *customView;

@end
