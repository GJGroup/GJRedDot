//
//  GJRedDotInfo.h
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJRedDotInfo : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) void (^refreshBlock)(BOOL);

@end
