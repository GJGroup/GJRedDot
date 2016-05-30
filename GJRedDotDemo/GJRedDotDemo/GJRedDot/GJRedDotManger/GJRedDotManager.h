//
//  GJRedDotManager.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 二亮子. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GJRedDotInfo;
@protocol GJRedDotProtocol;

typedef NS_ENUM(NSUInteger, GJRedDotModelType) {
    GJRedDotModelUserDefault,
    GJRedDotModelCustom,
};

@interface GJRedDotManager : NSObject

+ (instancetype)sharedManager;

/**
 *  regist.
 */
- (void)registWithProfile:(NSArray *)profile;

/**
 *  custom regist.
 */
- (void)registWithProfile:(NSArray *)profile
                modelType:(GJRedDotModelType)modelType
           protocolObject:(id<GJRedDotProtocol>)object;

/**
 *  regist dynamically one by one 
 */
- (void)registNodeWithKey:(NSString *)key
                parentKey:(NSString *)parentKey;

/**
 *  add item to manager, it contains red dot action and key.
 */
- (void)addRedDotItem:(GJRedDotInfo *)item forKey:(NSString *)key;

/**
 *  remove item from manager, when red dot view released.
 */
- (void)removeRedDotItemForKey:(NSString *)key;

/**
 *  reset red dot state.
 */
- (void)resetRedDotState:(BOOL)show forKey:(NSString *)key;

@end
