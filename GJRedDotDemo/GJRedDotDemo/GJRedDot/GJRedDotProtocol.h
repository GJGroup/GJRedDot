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

- (id<GJRedDotModelProtocol>)getCacheModelWithKey:(NSString *)key;

- (void)saveModelWithKey:(NSString *)key;

@end