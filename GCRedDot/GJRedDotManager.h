//
//  GJRedDotManager.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 二亮子. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GJRedDotInfo;

typedef NS_ENUM(NSUInteger, GJRedDotModelType) {
    GJRedDotModelUserDefault,
    GJRedDotModelCustom,
};

@interface GJRedDotManager : NSObject

+ (instancetype)sharedManager;

- (void)registWithProfile:(NSArray *)profile;

- (void)addRedDotItem:(GJRedDotInfo *)item forKey:(NSString *)key;

- (void)removeRedDotItemForKey:(NSString *)key;

- (void)resetRedDotState:(BOOL)show forKey:(NSString *)key;

@end
