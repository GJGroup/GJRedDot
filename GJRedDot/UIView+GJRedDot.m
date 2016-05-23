//
//  UIView+GJRedDot.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/18.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import "UIView+GJRedDot.h"
#import <objc/runtime.h>

//create cornerRatius red dot
static UIImage* gj_createImage(UIColor *color, CGSize size, CGFloat roundSize) {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (roundSize > 0) {
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: roundSize];
        [color setFill];
        [roundedRectanglePath fill];
    } else {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

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
        redDot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
        redDot.image = gj_createImage([UIColor redColor], CGSizeMake(6, 6), 3);
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
