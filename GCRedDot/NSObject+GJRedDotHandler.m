//
//  NSObject+GJRedDotHandler.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import "NSObject+GJRedDotHandler.h"
#import "GJRedDotInfo.h"
#import "GJRedDotManager.h"
#import "NSObject+GJDeallocBlockExecutor.h"

@implementation NSObject (GJRedDotHandler)

- (void)setRedDotKey:(NSString *)key refreshBlock:(void (^)(BOOL))refreshBlock handler:(id)handler {
    [handler setRedDotKey:key refreshBlock:refreshBlock];
}

- (void)setRedDotKey:(NSString *)key refreshBlock:(void (^)(BOOL))refreshBlock {
  
    if (key.length == 0 || refreshBlock == nil) return;
    
    GJRedDotInfo *info = [GJRedDotInfo new];
    info.key = key;
    info.refreshBlock = refreshBlock;
    
    [[GJRedDotManager sharedManager] addRedDotItem:info forKey:key];
    [self gj_createExecutorWithHandlerBlock:^{
        [[GJRedDotManager sharedManager] removeRedDotItemForKey:key];
    }];
    
}

- (void)resetRedDotState:(BOOL)show forKey:(NSString *)key {
    [[GJRedDotManager sharedManager] resetRedDotState:show forKey:key];
}


@end
