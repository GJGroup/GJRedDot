//
//  GJRedDotModelProtocol.h
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GJRedDotModelProtocol <NSObject>

/**
 *  just key
 */
@property (nonatomic, copy) NSString *key;

/**
 *  show or hide the dot, only used by leaf node, if model have subDots it's unused.
 */
@property (nonatomic, strong) NSNumber *show;

/**
 *  leaf nodes of current node
 */
@property (nonatomic, strong) NSMutableArray<id<GJRedDotModelProtocol>> *subDots;

/**
 *  parent node of current node
 */
@property (nonatomic, strong) id<GJRedDotModelProtocol> parent;

@end
