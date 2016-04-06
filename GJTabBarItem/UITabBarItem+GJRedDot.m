//
//  UITabBarItem+GJRedDot.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/3/31.
//

#import "UITabBarItem+GJRedDot.h"
#import <objc/runtime.h>

static const CGFloat GJDefaultRedius = 3;
static const CGFloat GJDefaultOffsetX = 10;
static const CGFloat GJDefaultOffsetY = -15;

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

@interface GJTabBarButtonDot : UIImageView

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) UIColor *color;

@end

@implementation GJTabBarButtonDot

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.radius = GJDefaultRedius;
        self.color = [UIColor redColor];
        self.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)setRadius:(CGFloat)radius {
    if (_radius == radius) return;
    _radius = radius;
    self.image = gj_createImage(self.color, CGSizeMake(radius * 2, radius * 2), radius);
    self.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
}

- (void)setColor:(UIColor *)color {
    if (CGColorEqualToColor(color.CGColor, _color.CGColor)) return;
    _color = color;
    self.image = gj_createImage(_color, CGSizeMake(self.radius * 2, self.radius * 2), self.radius);
}

@end

@interface UITabBarItem ()

@property (nonatomic, readonly) GJTabBarButtonDot *redDotView;

@property (nonatomic, readonly) UIView *currentDotView;

/**
 *  system method
 */
- (UIButton *)view;

- (UIView *)nextResponder;

@end

@implementation UITabBarItem (GJRedDot)

- (void)_updateRedDot {
    if (self.customView && !self.customView.superview) {
        [self.nextResponder addSubview:self.customView];
    }
    if (!self.redDotView.superview) {
        [self.nextResponder addSubview:self.redDotView];
    }
    self.redDotView.hidden = self.customView;
    self.currentDotView.hidden = !self.isShowRedDot;
    self.redDotView.center = [self _caculateCenterWithOffset:self.redDotOffset];
    self.customView.center = [self _caculateCenterWithOffset:self.redDotOffset];
}

- (UIView *)currentDotView {
    if (self.customView) {
        return self.customView;
    }
    return self.redDotView;
}

//dot view
- (GJTabBarButtonDot *)redDotView {
    GJTabBarButtonDot *dotView = objc_getAssociatedObject(self, _cmd);
    if (!dotView) {
        dotView = [[GJTabBarButtonDot alloc] initWithFrame:CGRectMake(0, GJDefaultOffsetY, GJDefaultRedius * 2, GJDefaultRedius * 2)];
        dotView.hidden = YES;
        objc_setAssociatedObject(self, _cmd, dotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dotView;
}

//show
- (BOOL)isShowRedDot {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsShowRedDot:(BOOL)isShowRedDot {
    BOOL show = [self isShowRedDot];
    if (show != isShowRedDot) {
        objc_setAssociatedObject(self, @selector(isShowRedDot), @(isShowRedDot), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.currentDotView.hidden = !isShowRedDot;
    }
}

//radius
- (CGFloat)redDotRadius {
    return self.redDotView.radius;
}

- (void)setRedDotRadius:(CGFloat)redDotRadius {
    self.redDotView.radius = redDotRadius;
}

//offset
- (CGPoint)redDotOffset {
    NSValue *offset = objc_getAssociatedObject(self, _cmd);
    if (!offset) {
        return CGPointZero;
    }
    return [offset CGPointValue];
}

- (void)setRedDotOffset:(CGPoint)redDotOffset {
    objc_setAssociatedObject(self, @selector(redDotOffset),[NSValue valueWithCGPoint:redDotOffset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.redDotView.center = [self _caculateCenterWithOffset:redDotOffset];
    self.customView.center = [self _caculateCenterWithOffset:redDotOffset];
}

//color
- (UIColor *)redDotColor {
    return self.redDotView.color;
}

- (void)setRedDotColor:(UIColor *)redDotColor {
    self.redDotView.color = redDotColor;
}

//custom view
- (UIView *)customView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCustomView:(UIView *)customView {
    if (self.customView == customView) return;
    if (self.customView) {
        [self.customView removeFromSuperview];
    }
    
    if (customView) {
        self.redDotView.hidden = YES;
        if (self.nextResponder) {
            [self.nextResponder addSubview:customView];
        }
    }
   
    objc_setAssociatedObject(self, @selector(customView), customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    self.currentDotView.center = [self _caculateCenterWithOffset:self.redDotOffset];
    self.currentDotView.hidden = ![self isShowRedDot];
}

- (CGPoint)_caculateCenterWithOffset:(CGPoint)offset {
    CGRect rect = self.view.frame;
    CGPoint itemCenter = CGPointMake(rect.origin.x + (rect.size.width / 2),
                                     rect.origin.y + (rect.size.height / 2));
    return CGPointMake(GJDefaultOffsetX + offset.x + itemCenter.x, GJDefaultOffsetY + offset.y + itemCenter.y);
}

@end

@interface UITabBar (GJRedDot)

@end

@implementation UITabBar (GJRedDot)

+ (void)load {
    Method old = class_getInstanceMethod(self, @selector(setItems:animated:));
    Method new = class_getInstanceMethod(self, @selector(gj_setItems:animated:));
    method_exchangeImplementations(old, new);
}

- (void)gj_setItems:(nullable NSArray<UITabBarItem *> *)items animated:(BOOL)animated {
    for (UITabBarItem *item in self.items) {
        if (![items containsObject:item]) {
            //remove red point
            [item.redDotView removeFromSuperview];
            [item.customView removeFromSuperview];
        }
    }
    [self gj_setItems:items animated:animated];
    
    for (UITabBarItem *item in items) {
        [item _updateRedDot];
    }
}

@end
