//
//  GJRedDot.h
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJRedDotManager.h"
#import "GJRedDotProtocol.h"
#import "UIView+GJRedDot.h"
#import "UITabBarItem+GJRedDot.h"
#import "NSObject+GJRedDotHandler.h"

@interface GJRedDot : NSObject

/**
 *  regist your red dot relationship tree from profile,(use NSUserDefault to save data)
 */
+ (void)registWithProfile:(NSArray *)profile;

/**
 *  regist your red dot relationship tree from profile,
 *  u can use custom model to save red dot data. If choose that, u must implement GJRedDotProtocol
 *  and your model must implement GJRedDotModelProtocol.
 */
+ (void)registWithProfile:(NSArray *)profile
                modelType:(GJRedDotModelType)modelType
           protocolObject:(id<GJRedDotProtocol>)object;

/**
 *  regist dynamically one by one
 */
+ (void)registNodeWithKey:(NSString *)key
                parentKey:(NSString *)parentKey;

/**
 *  set default radius of red dot.
 */
+ (void)setDefaultRadius:(CGFloat)radius;

/**
 *  set default color of red dot.
 */
+ (void)setDefaultColor:(UIColor *)color;


@end
