//
//  GCRedDotManager.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 二亮子. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GCRedDotInfo;

@interface GCRedDotManager : NSObject

+ (instancetype)sharedManager;

- (void)addRedDotItem:(GCRedDotInfo *)item forKey:(NSString *)key;

- (void)removeRedDotItemForKey:(NSString *)key;

- (void)resetRedDotState:(BOOL)show forKey:(NSString *)key;
@end
