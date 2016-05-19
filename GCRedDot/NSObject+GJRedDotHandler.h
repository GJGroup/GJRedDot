//
//  NSObject+GJRedDotHandler.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCRedDotConfig.h"

@interface NSObject (GJRedDotHandler)

- (void)setRedDotKey:(NSString *)key
        refreshBlock:(void (^)(BOOL show))refreshBlock
             handler:(id)handler;


- (void)resetRedDotState:(BOOL)show
                  forKey:(NSString *)key;

@end
