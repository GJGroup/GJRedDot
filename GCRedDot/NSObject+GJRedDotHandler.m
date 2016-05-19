//
//  NSObject+GJRedDotHandler.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import "NSObject+GJRedDotHandler.h"
#import "RedDot.h"
#import "GCRedDotInfo.h"
#import "GCRedDotManager.h"
#import "NSObject+GJDeallocBlockExecutor.h"

@implementation NSObject (GJRedDotHandler)

- (void)setRedDotKey:(NSString *)key refreshBlock:(void (^)(BOOL))refreshBlock handler:(id)handler {
    [handler setRedDotKey:key refreshBlock:refreshBlock];
}

- (void)setRedDotKey:(NSString *)key refreshBlock:(void (^)(BOOL))refreshBlock {
  
    if (key.length == 0 || refreshBlock == nil) return;
    
    GCRedDotInfo *info = [GCRedDotInfo new];
    info.key = key;
    info.refreshBlock = refreshBlock;
    
    [[GCRedDotManager sharedManager] addRedDotItem:info forKey:key];
    [self gj_createExecutorWithHandlerBlock:^{
        [[GCRedDotManager sharedManager] removeRedDotItemForKey:key];
    }];
    
}

- (void)resetRedDotState:(BOOL)show forKey:(NSString *)key {
    [[GCRedDotManager sharedManager] resetRedDotState:show forKey:key];
}


@end
