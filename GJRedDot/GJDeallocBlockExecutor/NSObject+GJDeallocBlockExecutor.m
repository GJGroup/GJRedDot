//
//  NSObject+GJDeallocBlockExecutor.m
//  Pods
//
//  Created by wangyutao on 16/5/18.
//
//

#import "NSObject+GJDeallocBlockExecutor.h"
#import <objc/runtime.h>
#import "GJDeallocBlockExecutor.h"

@implementation NSObject (GJDeallocBlockExecutor)

- (void)setGj_exutor:(GJDeallocBlockExecutor *)gj_exutor {
    objc_setAssociatedObject(self, @selector(gj_exutor), gj_exutor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (GJDeallocBlockExecutor *)gj_exutor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)gj_addExutor:(GJDeallocBlockExecutor *)exutor {
    if (!exutor) return;
    [self.gj_exutorPool addObject:exutor];
}

- (NSMutableArray *)gj_exutorPool {
    NSMutableArray *pool = objc_getAssociatedObject(self, _cmd);
    if (!pool) {
        pool = [NSMutableArray array];
        [self setGj_exutorPool:pool];;
    }
    return pool;
}

- (void)setGj_exutorPool:(NSMutableArray *)gj_exutorPool {
    objc_setAssociatedObject(self, @selector(gj_exutorPool), gj_exutorPool, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)gj_createExecutorWithHandlerBlock:(void (^)(void))block {
    GJDeallocBlockExecutor *executor = [[GJDeallocBlockExecutor alloc] initWithDeallocHandler:block];
    [self.gj_exutorPool addObject:executor];
}

@end
