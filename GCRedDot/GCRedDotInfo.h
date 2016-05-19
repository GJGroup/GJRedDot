//
//  GCRedDotInfo.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/18.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCRedDotInfo : NSObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) void (^refreshBlock)(BOOL);

@end
