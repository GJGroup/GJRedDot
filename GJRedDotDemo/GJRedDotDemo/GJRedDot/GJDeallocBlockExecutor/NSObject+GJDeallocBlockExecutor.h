//
//  NSObject+GJDeallocBlockExecutor.h
//  Pods
//
//  Created by wangyutao on 16/5/18.
//
//

#import <Foundation/Foundation.h>

@class GJDeallocBlockExecutor;
@interface NSObject (GJDeallocBlockExecutor)

@property (nonatomic, strong) GJDeallocBlockExecutor *gj_exutor;
@property (nonatomic, readonly) NSMutableArray *gj_exutorPool;

- (void)gj_addExutor:(GJDeallocBlockExecutor *)exutor;

- (void)gj_createExecutorWithHandlerBlock:(void (^)(void))block;

@end
