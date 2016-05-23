//
//  GJDeallocBlockExecutor.m
//  Pods
//
//  Created by wangyutao on 16/5/18.
//
//

#import "GJDeallocBlockExecutor.h"

@interface GJDeallocBlockExecutor ()
@property (nonatomic, copy) void (^deallocHandler)(void);
@end

@implementation GJDeallocBlockExecutor

- (instancetype)initWithDeallocHandler:(void (^)(void))handler {
    self = [super init];
    if (self) {
        self.deallocHandler = handler;
    }
    return self;
}

- (void)dealloc {
    !self.deallocHandler ?: self.deallocHandler();
    self.deallocHandler = nil;
}

@end
