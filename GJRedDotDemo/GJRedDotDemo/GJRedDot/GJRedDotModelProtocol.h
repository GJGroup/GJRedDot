//
//  GJRedDotModelProtocol.h
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GJRedDotModelProtocol <NSObject>

@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) NSNumber *show;
@property (nonatomic, strong) NSMutableArray<id<GJRedDotModelProtocol>> *subDots;
@property (nonatomic, strong) id<GJRedDotModelProtocol> parent;

@end
