//
//  GJDeallocBlockExecutor.h
//  Pods
//
//  Created by wangyutao on 16/5/18.
//
//

#import <Foundation/Foundation.h>

@interface GJDeallocBlockExecutor : NSObject

- (instancetype)initWithDeallocHandler:(void (^)(void))handler;

@end
