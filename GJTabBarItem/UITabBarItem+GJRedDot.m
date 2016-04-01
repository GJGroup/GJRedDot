//
//  UITabBarItem+GJRedDot.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/3/31.
//

#import "UITabBarItem+GJRedDot.h"
#import <objc/runtime.h>
#import <objc/message.h>

static const CGFloat GJDefaultRedius = 3;
static const CGFloat GJDefaultOffsetX = 10;
static const CGFloat GJDefaultOffsetY = 7.5;

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

@end

@implementation GJTabBarButtonDot

- (void)setRadius:(CGFloat)radius {
    if (_radius == radius) return;
    _radius = radius;
    self.image = gj_createImage([UIColor redColor], CGSizeMake(radius * 2, radius * 2), radius);
    self.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
}
@end

//private clear warning
@interface UIButton ()

@property (nonatomic, strong) UIView * _dotView;
- (void)_showRedDot:(BOOL)show;

@end

//extern
@interface UITabBarItem ()
- (UIButton *)view;
@end

@implementation UITabBarItem (GJRedDot)

- (BOOL)isShowRedDot {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsShowRedDot:(BOOL)isShowRedDot {
    BOOL show = [self isShowRedDot];
    if (show != isShowRedDot) {
        objc_setAssociatedObject(self, @selector(isShowRedDot), @(isShowRedDot), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.view._dotView.hidden = !isShowRedDot;
    }
}

- (CGFloat)redDotRadius {
    NSNumber *radius = objc_getAssociatedObject(self, _cmd);
    if (!radius) {
        radius = @(GJDefaultRedius);
    }
    return [radius doubleValue];
}

- (void)setRedDotRadius:(CGFloat)redDotRadius {
    objc_setAssociatedObject(self, @selector(redDotRadius), @(redDotRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.view._dotView isKindOfClass:[GJTabBarButtonDot class]]) {
        GJTabBarButtonDot *dotView = (GJTabBarButtonDot *)self.view._dotView;
        dotView.radius = redDotRadius;
    }
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
    self.view._dotView.frame = [self _caculateFrameWithOffset:redDotOffset
                                                  originFrame:self.view._dotView.frame];
}

- (CGRect)_caculateFrameWithOffset:(CGPoint)offset
                       originFrame:(CGRect)frame {
    CGRect rect = frame;
    rect.origin.x = rect.origin.x + offset.x;
    rect.origin.y = rect.origin.y + offset.y;
    return rect;
}

- (UIView *)customView {
    UIView *customView = self.view._dotView;
    if ([customView isKindOfClass:[GJTabBarButtonDot class]]) {
        customView = nil;
    }
    return customView;
}

- (void)setCustomView:(UIView *)customView {
    self.view._dotView = customView;
    if ([self.view._dotView isKindOfClass:[GJTabBarButtonDot class]]) {
        GJTabBarButtonDot *dot = (GJTabBarButtonDot *)self.view._dotView;
        dot.radius = self.redDotRadius;
    }else {
        CGRect rect = self.view._dotView.frame;
        rect.origin.x = self.view.bounds.size.width / 2 + GJDefaultOffsetX;
        rect.origin.y = GJDefaultOffsetY;
        self.view._dotView.frame = rect;
    }
    self.view._dotView.frame = [self _caculateFrameWithOffset:[self redDotOffset]
                                                  originFrame:self.view._dotView.frame];
    self.view._dotView.hidden = ![self isShowRedDot];
}

@end


#pragma mark - associated red dot
static const void *kRedDotKey = &kRedDotKey;

static UIView * gj_getDotView(id self, SEL _cmd) {
    UIView *dot = objc_getAssociatedObject(self, &kRedDotKey);
    if (!dot) {
        GJTabBarButtonDot *redDot;
        UIView *selfView = self;
        
        redDot = [[GJTabBarButtonDot alloc]initWithFrame:CGRectMake(selfView.bounds.size.width/2 + GJDefaultOffsetX ,
                                                                    GJDefaultOffsetY,
                                                                    GJDefaultRedius * 2,
                                                                    GJDefaultRedius * 2)];
        redDot.image = gj_createImage([UIColor redColor], redDot.bounds.size, GJDefaultRedius);
        redDot.contentMode = UIViewContentModeCenter;
        redDot.hidden = YES;
        [selfView addSubview:redDot];
        objc_setAssociatedObject(self, &kRedDotKey, redDot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        dot = redDot;
    }
    return dot;
}

static void gj_setDotView(id self, SEL _cmd, UIView *dotView) {
    UIView *dot = objc_getAssociatedObject(self, &kRedDotKey);
    if (dot) {
        [dot removeFromSuperview];
    }
    if (dotView) {
        UIView *selfView = self;
        [selfView addSubview:dotView];
    }
    
    objc_setAssociatedObject(self, &kRedDotKey, dotView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

__attribute__((constructor)) static void GJRedDotPatchEntry(void) {
    
    Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
    class_addMethod(tabBarButtonClass, @selector(_dotView), (IMP)gj_getDotView, "@@:");
    class_addMethod(tabBarButtonClass, @selector(set_dotView:), (IMP)gj_setDotView, "v@:@");


}