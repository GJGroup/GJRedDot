//
//  GJRedDotModel.h
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJRedDotModelProtocol.h"

@interface GJRedDotModel : NSObject <GJRedDotModelProtocol>
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSNumber *show;
@property (nonatomic, strong) NSArray<id<GJRedDotModelProtocol>> *subDots;
@property (nonatomic, strong) id<GJRedDotModelProtocol> parent;
@end
