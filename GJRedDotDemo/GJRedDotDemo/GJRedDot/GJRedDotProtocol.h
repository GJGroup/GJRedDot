//
//  GJRedDotProtocol.h
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GJRedDotModelProtocol;

@protocol GJRedDotProtocol <NSObject>

/**
 *  get cache model when use custom model
 *
 *  @param key : red dot key
 *
 *  @return model
 */
- (id<GJRedDotModelProtocol>)getCacheModelWithKey:(NSString *)key;

/**
 *  save model or whatever cache with key
 *
 *  @param key red dot key
 */
- (void)saveModelWithKey:(NSString *)key;

@end