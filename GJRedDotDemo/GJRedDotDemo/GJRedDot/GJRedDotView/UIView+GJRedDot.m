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

#pragma mark- GJRedDotView interface extension
@interface GJRedDotView ()
@property (nonatomic, weak) NSLayoutConstraint *layoutCenterX;
@property (nonatomic, weak) NSLayoutConstraint *layoutCenterY;
@end


@interface UIView ()
@property (nonatomic, strong) GJRedDotView *redDotView;
@property (nonatomic, strong) GJBadgeView *badgeView;
@end

@implementation UIView (GJRedDot)

- (BOOL)showRedDot {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setShowRedDot:(BOOL)showRedDot {
    if (self.showRedDot != showRedDot) {
        objc_setAssociatedObject(self, @selector(showRedDot), @(showRedDot), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self _refreshHiddenState];
    }
}

- (GJRedDotView *)redDotView {
    GJRedDotView *dotView = objc_getAssociatedObject(self, _cmd);
    if (!dotView) {
        dotView = [[GJRedDotView alloc] init];
        dotView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        dotView.refreshBlock = ^(GJRedDotView *view) {
            [weakSelf refreshRedDotView:view];
        };
        objc_setAssociatedObject(self, _cmd, dotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:dotView];
        [self _layoutDotView:dotView];
    }
    return dotView;
}

- (GJBadgeView *)badgeView {
    GJBadgeView *badgeView = objc_getAssociatedObject(self, _cmd);
    if (!badgeView) {
        badgeView = [[GJBadgeView alloc] init];
        badgeView.hidden = YES;
  
        objc_setAssociatedObject(self, _cmd, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self addSubview:badgeView];
        [self _layoutBadgeView:badgeView];
    }
    return badgeView;
}

//offset
- (CGPoint)redDotOffset {
    return self.redDotView.offset;
}

- (void)setRedDotOffset:(CGPoint)redDotOffset {
    self.redDotView.offset = redDotOffset;
}

//radius
- (CGFloat)redDotRadius {
    return self.redDotView.radius;
}

- (void)setRedDotRadius:(CGFloat)redDotRadius {
    self.redDotView.radius = redDotRadius;
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

//badge
- (NSString *)badgeValue {
    return self.badgeView.badgeValue;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if ([self.badgeView.badgeValue isEqualToString:badgeValue]) return;
    self.badgeView.badgeValue = badgeValue;
    self.badgeView.hidden = !badgeValue;
    [self _refreshHiddenState];
}

//pravite
- (void)_refreshHiddenState {
    self.redDotView.hidden = (!self.showRedDot || self.badgeValue);
}

- (void)_layoutDotView:(GJRedDotView *)dotView {
    
    dotView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat x = - dotView.radius + self.redDotOffset.x;
    CGFloat y = dotView.radius + self.redDotOffset.y;
    NSLayoutConstraint *layoutX = [NSLayoutConstraint constraintWithItem:dotView
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1
                                                                constant:x];
    NSLayoutConstraint *layoutY = [NSLayoutConstraint constraintWithItem:dotView
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:y];
    dotView.layoutCenterX = layoutX;
    dotView.layoutCenterY = layoutY;
    [self addConstraint:layoutX];
    [self addConstraint:layoutY];

}

- (void)_refreshLayout {
    CGFloat x = - self.redDotView.radius + self.redDotOffset.x;
    CGFloat y = self.redDotView.radius + self.redDotOffset.y;
    self.redDotView.layoutCenterX.constant = x;
    self.redDotView.layoutCenterY.constant = y;
}

- (void)refreshRedDotView:(GJRedDotView *)view {
    [self _refreshLayout];
}

- (void)_layoutBadgeView:(GJBadgeView *)bageview {
    bageview.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *layoutX = [NSLayoutConstraint constraintWithItem:bageview
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1
                                                                constant:-8];
    NSLayoutConstraint *layoutY = [NSLayoutConstraint constraintWithItem:bageview
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:8];
    [self addConstraint:layoutX];
    [self addConstraint:layoutY];
}

@end
