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

static const CGFloat GJDefaultOffsetX = 12;
static const CGFloat GJDefaultOffsetY = -15;

#pragma mark- GJRedDotView interface extension
@interface GJRedDotView ()
@property (nonatomic, weak) NSLayoutConstraint *layoutCenterX;
@property (nonatomic, weak) NSLayoutConstraint *layoutCenterY;
@end


@interface UIView ()
@property (nonatomic, strong) GJRedDotView *redDotView;
@end

@implementation UIView (GJRedDot)

- (BOOL)showRedDot {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setShowRedDot:(BOOL)showRedDot {
    if (self.showRedDot != showRedDot) {
        objc_setAssociatedObject(self, @selector(showRedDot), @(showRedDot), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.redDotView.hidden = !showRedDot;
    }
}

- (GJRedDotView *)redDotView {
    GJRedDotView *dotView = objc_getAssociatedObject(self, _cmd);
    if (!dotView) {
        dotView = [[GJRedDotView alloc] init];
        dotView.hidden = YES;
        objc_setAssociatedObject(self, _cmd, dotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:dotView];
        [self _layoutDotView:dotView];
    }
    return dotView;
}

- (CGPoint)redDotOffset {
    NSValue *offset = objc_getAssociatedObject(self, _cmd);
    if (!offset) {
        return CGPointZero;
    }
    return [offset CGPointValue];
}

- (void)setRedDotOffset:(CGPoint)redDotOffset {
    objc_setAssociatedObject(self, @selector(redDotOffset),[NSValue valueWithCGPoint:redDotOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self _refreshLayout];
}

- (CGFloat)redDotRadius {
    return self.redDotView.radius;
}

- (void)setRedDotRadius:(CGFloat)redDotRadius {
    self.redDotView.radius = redDotRadius;
    [self _refreshLayout];
}

//color
- (UIColor *)redDotColor {
    return self.redDotView.color;
}

- (void)setRedDotColor:(UIColor *)redDotColor {
    self.redDotView.color = redDotColor;
}

//border
- (UIColor *)redDotBorderColor {
    return self.redDotView.borderColor;
}

- (void)setRedDotBorderColor:(UIColor *)redDotBorderColor {
    self.redDotView.borderColor = redDotBorderColor;
}

- (CGFloat)redDotBorderWitdh {
    return self.redDotView.borderWidth;
}

- (void)setRedDotBorderWitdh:(CGFloat)redDotBorderWitdh {
    self.redDotView.borderWidth = redDotBorderWitdh;
}

- (void)_layoutDotView:(GJRedDotView *)dotView {
    
    dotView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat x = GJDefaultOffsetX + self.redDotOffset.x + dotView.radius;
    CGFloat y = GJDefaultOffsetY - self.redDotOffset.y;
    NSLayoutConstraint *layoutX = [NSLayoutConstraint constraintWithItem:dotView
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:x];
    NSLayoutConstraint *layoutY = [NSLayoutConstraint constraintWithItem:dotView
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:y];
    dotView.layoutCenterX = layoutX;
    dotView.layoutCenterY = layoutY;
    [self addConstraint:layoutX];
    [self addConstraint:layoutY];

}

- (void)_refreshLayout {
    CGFloat x = GJDefaultOffsetX + self.redDotOffset.x + self.redDotView.radius;
    CGFloat y = GJDefaultOffsetY - self.redDotOffset.y;
    self.redDotView.layoutCenterX.constant = x;
    self.redDotView.layoutCenterY.constant = y;
}

@end
