//
//  UITabBarItem+GJRedDot.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/3/31.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (GJRedDot)

/**
 *  是否显示小红点，默认为NO，当有badgeValue的时候，即使YES也是不显示的
 */
@property (nonatomic, assign) BOOL isShowRedDot;

/**
 *  小红点半径，控制大小，对自定义图标无效
 */
@property (nonatomic, assign) CGFloat redDotRadius;

/**
 *  小红点位置偏移，(0,0)默认情况下是以tabBarButton中心为基准进行偏移:
 *  x:默认中心偏右10个坐标，以红点原点x坐标为基准，
 *  也就是说红点frame.origin.x距离tabBarButton中心点的横向坐标距离默认是10
 *  y:默认中心偏上15个坐标，以红点原点中心点的y坐标为基准，
 *  也就是说红点frame.center.y距离tabBarButton中心点的纵向坐标距离默认是15
 *  通过offset可以在这基础上偏移
 *  这么做的目的是当小红点高度变化的时候，不会向下方单方向延伸，而是向上下同时延伸，当长度变化的时候类似badgeVallue一样向右单方向延伸
 */
@property (nonatomic, assign) CGPoint redDotOffset;

/**
 *  好吧，小红点颜色当然是红色的…起名真难……
 *  默认是redColor，也可以自己定义，对自定义图标无效
 */
@property (nonatomic, strong) UIColor *redDotColor;

/**
 *  自定义小红点图标，如果set nil，则恢复小红点
 */
@property (nonatomic, strong) UIView *customView;

@end
