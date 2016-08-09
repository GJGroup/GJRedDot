//
//  GJRedDot.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "GJRedDot.h"
#import "GJRedDotView.h"

@implementation GJRedDot

//default show
+ (void)registWithProfile:(NSArray *)profile {
    [self registWithProfile:profile defaultShow:YES];
}

//can set show or hide
+ (void)registWithProfile:(NSArray *)profile defaultShow:(BOOL)show {
    NSAssert(profile.count, @"GJRedDot: You can't regist an empty profiles");
    [[GJRedDotManager sharedManager] registWithProfile:profile defaultShow:show];
}

+ (void)registWithProfile:(NSArray *)profile
                modelType:(GJRedDotModelType)modelType
           protocolObject:(id<GJRedDotProtocol>)object {
    NSAssert(profile.count, @"GJRedDot: You can't regist an empty profiles");
    if ((modelType == GJRedDotModelCustom && !object) ||
        modelType == GJRedDotModelUserDefault) {
        [self registWithProfile:profile];
        return;
    }
    [[GJRedDotManager sharedManager] registWithProfile:profile
                                             modelType:modelType
                                        protocolObject:object];
}

+ (void)registNodeWithKey:(NSString *)key
                parentKey:(NSString *)parentKey
              defaultShow:(BOOL)show{
    
    [[GJRedDotManager sharedManager] registNodeWithKey:key
                                             parentKey:parentKey
                                           defaultShow:show];
}

+ (void)resetAllNodesBecomeShown{
    [[GJRedDotManager sharedManager] resetAllShown];
}

+ (void)resetAllNodesBecomeHidden{
    [[GJRedDotManager sharedManager] resetAllHidden];
}


#pragma mark- default setter

+ (void)setDefaultRadius:(CGFloat)radius {
    [GJRedDotView setDefaultRadius:radius];
}

+ (void)setDefaultColor:(UIColor *)color {
    [GJRedDotView setDefaultColor:color];
}

@end
