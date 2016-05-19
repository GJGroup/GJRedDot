//
//  GCRedDotManager.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 二亮子. All rights reserved.
//

#import "GCRedDotManager.h"
#import "GCRedDotRegister.h"
#import "RedDot.h"
#import "GCRedDotInfo.h"

@interface GCRedDotManager ()
@property (nonatomic, strong) NSMutableDictionary *redDotDic;
@end

@implementation GCRedDotManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static GCRedDotManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [GCRedDotManager new];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.redDotDic = [NSMutableDictionary dictionary];
        [self regist];
    }
    return self;
}

#pragma mark- regist

- (void)regist {
    NSArray *registArray = [GCRedDotRegister regist];
    [self registWithObject:registArray parent:nil];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)registWithObject:(id)object parent:(id)parent{
    
    if ([object isKindOfClass:[NSArray class]]) {
        for (id subObject in object) {
            [self registWithObject:subObject parent:parent];
        }
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        for (id key in object) {
            
            id model = [self fetchOrCreateModelWithKey:key parent:parent];
            
            id subObject = object[key];
            [self registWithObject:subObject parent:model];
        }
    }
    else if ([object isKindOfClass:[NSString class]]) {
        
        [self fetchOrCreateModelWithKey:object parent:parent];
        
    }
}

- (id)fetchOrCreateModelWithKey:(NSString *)key parent:(id)parent {
    RedDot *model = [RedDot MR_findFirstByAttribute:@"key" withValue:key];
    if (model == nil) {
        model = [RedDot MR_createEntity];
        model.show = @(YES);
        model.key = key;
    }
    
    if (parent && model.parent == nil) {
        model.parent = parent;
    }
    return model;
}

#pragma mark- 

/**
 *  当前节点是否展示，分两种情况：
 *  没有子节点：则以show为准
 *  有子节点：则以子节点为准，子节点有一个是show，就show
 */

- (void)addRedDotItem:(GCRedDotInfo *)item forKey:(NSString *)key {
    [self.redDotDic setObject:item forKey:key];
    //add进去后应该自动刷一下当前key的
    [self refreshRedDotForKey:key];
}

- (void)removeRedDotItemForKey:(NSString *)key {
    [self.redDotDic removeObjectForKey:key];
}

/**
 *  限定了当前节点“无子节”点才可修改show
 */
- (void)resetRedDotState:(BOOL)show forKey:(NSString *)key {
    RedDot *model = [RedDot MR_findFirstByAttribute:@"key" withValue:key];
    if (!model) return;
    if (model.subDots.allObjects.count > 0) return; //有子节点不可手动改，以子节点为准
    model.show = @(show);
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self refreshRedDotTreeForKey:key];
}

//改变某key后，从key这个节点刷新相关的，只能set最底层，所以往上遍历
- (void)refreshRedDotTreeForKey:(NSString *)key {
    
    RedDot *model = [self refreshRedDotForKey:key];
    
    model = model.parent;
    if (model) {
        [self refreshRedDotTreeForKey:model.key];
    }
}

/**
 *  @return 当前刷新的RedDot model对象
 */
- (RedDot *)refreshRedDotForKey:(NSString *)key {
    GCRedDotInfo *info = [self.redDotDic objectForKey:key];
    if (!info) return nil;
    
    RedDot *model = [RedDot MR_findFirstByAttribute:@"key" withValue:key];
    if (!model) return nil;
    
    BOOL show = [self checkShowWithModel:model];
    !info.refreshBlock ?: info.refreshBlock(show);
    return model;
}


//检查当前节点是否show，有子节点的以子节点为准，没有子节点的，以show为准
- (BOOL)checkShowWithModel:(RedDot *)model {
    if (model.subDots.allObjects.count > 0) {
        for (RedDot *redDot in model.subDots.allObjects) {
            BOOL show = [self checkShowWithModel:redDot];
            if (show) {
                return YES;
            }
        }
    }
    else {
        return model.show.boolValue;
    }
    return NO;
}
@end
