//
//  GJRedDotManager.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 二亮子. All rights reserved.
//

#import "GJRedDotManager.h"
#import "GJRedDotModel.h"
#import "GJRedDotInfo.h"
#import "GJRedDotProtocol.h"

#define __GJUserDefaults [NSUserDefaults standardUserDefaults]

@interface GJRedDotManager ()
/**
 *  save refresh block
 */
@property (nonatomic, strong) NSMutableDictionary *redDotDic;
/**
 *  model for regist
 */
@property (nonatomic, strong) NSMutableDictionary *redDotModelDic;
@property (nonatomic, assign) GJRedDotModelType modelType;
@property (nonatomic, strong) id<GJRedDotProtocol> modelExecutor;
@end

@implementation GJRedDotManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static GJRedDotManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [GJRedDotManager new];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.redDotDic = [NSMutableDictionary dictionary];
        self.redDotModelDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark- regist

- (void)registWithProfile:(NSArray *)profile defaultShow:(BOOL)show {
    BOOL save;
    [self registWithObject:profile parent:nil defaultShow:show save:&save];
    if (save) [__GJUserDefaults synchronize];
}

- (void)registWithProfile:(NSArray *)profile
                modelType:(GJRedDotModelType)modelType
           protocolObject:(id<GJRedDotProtocol>)object {
    self.modelType = modelType;
    self.modelExecutor = object;
    [self registWithProfile:profile defaultShow:YES];
}

- (void)registNodeWithKey:(NSString *)key
                parentKey:(NSString *)parentKey
              defaultShow:(BOOL)show{
    
    if (!key || key.length == 0) return;
    id<GJRedDotModelProtocol> model = self.redDotModelDic[key];
    if (model) return;
    
    id<GJRedDotModelProtocol> parent = self.redDotModelDic[parentKey];
    BOOL save;
    [self fetchOrCreateModelWithKey:key parent:parent defaultShow:show save:&save isLeaf:YES];
    if (save) [__GJUserDefaults synchronize];
    
    [self refreshRedDotTreeForKey:key];
}

- (void)registWithObject:(id)object
                  parent:(id<GJRedDotModelProtocol>)parent
             defaultShow:(BOOL)show
                    save:(BOOL *)save {
    
    if ([object isKindOfClass:[NSArray class]]) {
        for (id subObject in object) {
            [self registWithObject:subObject parent:parent defaultShow:show save:save];
        }
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        for (id key in object) {
            
            id model = [self fetchOrCreateModelWithKey:key parent:parent defaultShow:show save:save isLeaf:NO];
            
            id subObject = object[key];
            [self registWithObject:subObject parent:model defaultShow:show save:save];
        }
    }
    else if ([object isKindOfClass:[NSString class]]) { //object is key
        
        [self fetchOrCreateModelWithKey:object parent:parent defaultShow:show save:save isLeaf:YES];
    }
}

//regist, fetch by protocol, create by default way
- (id<GJRedDotModelProtocol>)fetchOrCreateModelWithKey:(NSString *)key
                                                parent:(id<GJRedDotModelProtocol>)parent
                                           defaultShow:(BOOL)show
                                                  save:(BOOL *)save
                                                isLeaf:(BOOL)isLeaf {
    //custom fetch by protocol
    if (self.modelType == GJRedDotModelCustom) {
        NSAssert([self _checkRedDotProtocolByObject:self.modelExecutor], @"you must implement GJRedDotProtocol");
        id<GJRedDotModelProtocol> model = [self.modelExecutor getCacheModelWithKey:key];
        NSAssert(model, @"you must return a model from 'getCacheModelWithKey:' method");
        NSAssert([self _checkRedDotModelProtocolByObject:model], @"You must implement GJRedDotModelProtocol!");
        if (parent && model.parent == nil) {
            model.parent = parent;
            [parent.subDots addObject:model];
        }
        [self.redDotModelDic setObject:model forKey:key];
        return model;
    }
 
    //default, create a model and init with UserDefault
    NSString *showStr = [__GJUserDefaults stringForKey:key];
    GJRedDotModel *model = [GJRedDotModel new];
    model.key = key;
    if (!isLeaf) {
        //do nothing, because 'show' is depending on 'subDots'
    }
    else if (showStr.length == 0 || (![showStr isEqualToString:@"show"] && ![showStr isEqualToString:@"hide"])) {
        model.show = @(show);
        [__GJUserDefaults setObject:show ? @"show" : @"hide" forKey:key];
        if (!(*save)) *save = YES;
    }
    else {
        model.show = @([showStr isEqualToString:@"show"]);
    }
    
    if (parent && model.parent == nil) {
        model.parent = parent;
        [parent.subDots addObject:model];
    }
    [self.redDotModelDic setObject:model forKey:key];
    return model;
}

#pragma mark -

- (void)resetAllShown {
    [self resetShown:YES];
}

- (void)resetAllHidden {
    [self resetShown:NO];
}

- (void)resetShown:(BOOL)shown {

    //set all leaf node's 'show'
    [self.redDotModelDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        id<GJRedDotModelProtocol> model = obj;
        if (model.subDots.count == 0) {
            model.show = @(shown);
            NSString *showString = shown ? @"show" : @"hide";
            [__GJUserDefaults setObject:showString forKey:key];
        }
    }];
    [__GJUserDefaults synchronize];
    
    //refresh all UI by refreshBlock
    [self.redDotModelDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        GJRedDotInfo *info = [self.redDotDic objectForKey:key];
        if (info) {
            BOOL show = [self checkShowWithModel:obj];
            !info.refreshBlock ?: info.refreshBlock(show);
        }
    }];
    
}

/**
 *  当前节点是否展示，分两种情况：
 *  没有子节点：则以show为准
 *  有子节点：则以子节点为准，子节点有一个是show，就show
 */
- (void)addRedDotItem:(GJRedDotInfo *)item forKey:(NSString *)key {
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
    id<GJRedDotModelProtocol> model = self.redDotModelDic[key];
    if (!model) return;
    if (model.subDots.count > 0) return; //有子节点不可手动改，以子节点为准
    model.show = @(show);
    
    if (self.modelType == GJRedDotModelCustom) {
        [self.modelExecutor saveModelWithKey:key];
    }
    else if (self.modelType == GJRedDotModelUserDefault) {
        NSString *showString = show ? @"show" : @"hide";
        [__GJUserDefaults setObject:showString forKey:key];
        [__GJUserDefaults synchronize];
    }
    
    [self refreshRedDotTreeForKey:key];
}

/**
 *  改变某key后，从key这个节点刷新相关的，因为限定了只能set最底层，所以往上遍历
 */
- (void)refreshRedDotTreeForKey:(NSString *)key {
    
    id<GJRedDotModelProtocol> model = [self refreshRedDotForKey:key];
    
    model = model.parent;
    if (model) {
        [self refreshRedDotTreeForKey:model.key];
    }
}

/**
 *  @return 当前刷新的RedDot model对象
 */
- (id<GJRedDotModelProtocol>)refreshRedDotForKey:(NSString *)key {
    id<GJRedDotModelProtocol> model = self.redDotModelDic[key];
    if (!model) return nil;

    GJRedDotInfo *info = [self.redDotDic objectForKey:key];
    
    BOOL show = [self checkShowWithModel:model];
    !info.refreshBlock ?: info.refreshBlock(show);
    return model;
}


/**
 *  检查当前节点是否show，有子节点的以子节点为准，没有子节点的，以show为准
 *
 *  @param model 当前节点model
 *
 *  @return show or hide
 */
- (BOOL)checkShowWithModel:(id<GJRedDotModelProtocol>)model {
    if (model.subDots.count > 0) {
        for (id<GJRedDotModelProtocol> redDot in model.subDots) {
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

#pragma mark -

- (BOOL)_checkRedDotProtocolByObject:(id<GJRedDotProtocol>)object {
    if (object &&
        [object respondsToSelector:@selector(getCacheModelWithKey:)] &&
        [object respondsToSelector:@selector(saveModelWithKey:)]) {
        return YES;
    }
    return NO;
}

- (BOOL)_checkRedDotModelProtocolByObject:(id<GJRedDotModelProtocol>)object {
    if ([object respondsToSelector:@selector(show)] &&
        [object respondsToSelector:@selector(setShow:)] &&
        [object respondsToSelector:@selector(key)] &&
        [object respondsToSelector:@selector(setKey:)] &&
        [object respondsToSelector:@selector(subDots)] &&
        [object respondsToSelector:@selector(setSubDots:)] &&
        [object respondsToSelector:@selector(parent)] &&
        [object respondsToSelector:@selector(setParent:)]
        ) {
        return YES;
    }
    return NO;
}

@end
