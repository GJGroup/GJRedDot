//
//  UIView+GJRedDot.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/18.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import "UIView+GJRedDot.h"
#import <objc/runtime.h>
#import "GJRedDotView.h"

@implementation UIView (GJRedDot)

- (BOOL)showRedDot {
    NSNumber *show = objc_getAssociatedObject(self, _cmd);
    return show.boolValue;
}

- (void)setShowRedDot:(BOOL)showRedDot {
    objc_setAssociatedObject(self, @selector(showRedDot), @(showRedDot), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIImageView *redDot = [self gj_redDotView];
    redDot.hidden = !showRedDot;
}

- (UIImageView *)gj_redDotView {
    UIImageView *redDot = objc_getAssociatedObject(self, _cmd);
    if (!redDot) {
        redDot = [[GJRedDotView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        [self addSubview:redDot];
        objc_setAssociatedObject(self, _cmd, redDot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        redDot.translatesAutoresizingMaskIntoConstraints = NO;

        NSLayoutConstraint *layoutX = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:redDot
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:-25];
        NSLayoutConstraint *layoutY = [NSLayoutConstraint constraintWithItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:redDot
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1
                                                                    constant:28];
        NSLayoutConstraint *layoutH = [NSLayoutConstraint constraintWithItem:redDot
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:1
                                                                    constant:6];
        NSLayoutConstraint *layoutW = [NSLayoutConstraint constraintWithItem:redDot
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:1
                                                                    constant:6];
        [self addConstraint:layoutX];
        [self addConstraint:layoutY];
        [self addConstraint:layoutH];
        [self addConstraint:layoutW];

    }
    return redDot;
}

@end
