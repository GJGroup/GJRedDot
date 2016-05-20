//
//  GJRedDot.h
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJRedDotManager.h"
#import "GJRedDotProtocol.h"

@interface GJRedDot : NSObject

+ (void)registWithProfile:(NSArray *)profile;

+ (void)registWithProfile:(NSArray *)profile
                modelType:(GJRedDotModelType)modelType
           protocolObject:(id<GJRedDotProtocol>)object;


@end
