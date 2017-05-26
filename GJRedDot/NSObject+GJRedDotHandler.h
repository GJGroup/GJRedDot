//
//  NSObject+GJRedDotHandler.h
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GJRedDotHandler)

/**
 *  set red dot refresh action by refreshBlock with red dot key,
 *  the caller must be redDot handler,the block will release when caller released.
 *  you must us weak self to break retain circle!
 *
 *  @param key          red dot key
 *  @param refreshBlock refresh action block
 */
- (void)setRedDotKey:(NSString *)key
        refreshBlock:(void (^)(BOOL show))refreshBlock;

/**
 *  set red dot refresh action by refreshBlock with red dot key,
 *  different from above method, you can specify a handler to manage the action block.
 *  you must us weak self to break retain circle!
 *
 *  @param key          red dot key
 *  @param refreshBlock refresh action block
 *  @param handler      red dot view handler
 */
- (void)setRedDotKey:(NSString *)key
        refreshBlock:(void (^)(BOOL show))refreshBlock
             handler:(id)handler;

/**
 *  you can use this method to reset red dot state (show or hide).
 *
 *  @param show show or hide
 *  @param key  red dot key
 */
- (void)resetRedDotState:(BOOL)show
                  forKey:(NSString *)key;

/**
 * refresh red dot form current key.
 */
- (void)refreshRedDotTreeForKey:(NSString *)key;

@end
