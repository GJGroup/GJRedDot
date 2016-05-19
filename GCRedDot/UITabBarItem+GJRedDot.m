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

#pragma mark - GJTabBarButtonDot
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


#pragma mark - UITabBarItem Category

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

+ (void)load {
    Method old = class_getInstanceMethod(self, @selector(setBadgeValue:));
    Method new = class_getInstanceMethod(self, @selector(gj_setBadgeValue:));
    method_exchangeImplementations(old, new);
}

- (void)gj_setBadgeValue:(NSString *)badgeValue {
    [self gj_setBadgeValue:badgeValue];
    [self _refreshHiddenState];
}

- (void)_updateRedDot {
    if (self.customView && !self.customView.superview) {
        [self.nextResponder addSubview:self.customView];
    }
    if (!self.redDotView.superview) {
        [self.nextResponder addSubview:self.redDotView];
    }
    
    [self _refreshHiddenState];
    [self _refreshDotViewPosition];
}

- (void)_refreshHiddenState {
    self.redDotView.hidden = !(!self.customView && self.isShowRedDot && !self.badgeValue);
    if (self.customView) {
        self.customView.hidden = !(self.isShowRedDot && !self.badgeValue);
    }
}

- (void)_refreshDotViewPosition {
    if (self.customView) {
        self.customView.frame = [self _caculateFrameWithBounds:self.customView.bounds];
    }
    self.redDotView.frame = [self _caculateFrameWithBounds:self.redDotView.bounds];
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
        [self _refreshHiddenState];
    }
}

//radius
- (CGFloat)redDotRadius {
    return self.redDotView.radius;
}

- (void)setRedDotRadius:(CGFloat)redDotRadius {
    self.redDotView.radius = redDotRadius;
    [self _refreshDotViewPosition];
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
    [self _refreshDotViewPosition];
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
        if (self.nextResponder) {
            [self.nextResponder addSubview:customView];
        }
    }
   
    objc_setAssociatedObject(self, @selector(customView), customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [self _refreshHiddenState];
    [self _refreshDotViewPosition];
}

- (CGRect)_caculateFrameWithBounds:(CGRect)bounds {
    CGRect buttonRect = self.view.frame;
    CGRect dotRect = bounds;
    dotRect.origin.x = buttonRect.origin.x + (buttonRect.size.width / 2) + GJDefaultOffsetX + self.redDotOffset.x;
    dotRect.origin.y = buttonRect.origin.y + (buttonRect.size.height / 2) + GJDefaultOffsetY + self.redDotOffset.y - bounds.size.height / 2;
    return dotRect;
}

@end

#pragma mark- UITabBar Category
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
