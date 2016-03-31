//
//  UITabBarItem+GJRedDot.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/3/31.
//

#import "UITabBarItem+GJRedDot.h"
#import <objc/runtime.h>
#import <objc/message.h>

//clear warning
@interface UIButton ()
- (void)_showRedDot:(BOOL)show;
@end

//extern
@interface UITabBarItem ()
- (UIView *)view;
@end

@implementation UITabBarItem (GJRedDot)

- (BOOL)isShowRedDot {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsShowRedDot:(BOOL)isShowRedDot {
    BOOL show = [self isShowRedDot];
    if (show != isShowRedDot) {
        objc_setAssociatedObject(self, @selector(isShowRedDot), @(isShowRedDot), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        void (*msgSend)(id, SEL, BOOL) = (__typeof__(msgSend))objc_msgSend;
        msgSend(self.view, @selector(_showRedDot:), isShowRedDot);
    }
}

@end

static const void *kRedDotKey = &kRedDotKey;

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


static void gj_showRedDot(id self, SEL _cmd, bool show) {
    UIImageView *dot = objc_getAssociatedObject(self, &kRedDotKey);
    if (!dot) {
        UIView *selfView = self;
        dot = [[UIImageView alloc]initWithFrame:CGRectMake(selfView.bounds.size.width/2 + 10 , 7.5, 5, 5)];
        dot.image = gj_createImage([UIColor redColor], dot.bounds.size, dot.bounds.size.width / 2);
        [selfView addSubview:dot];
        objc_setAssociatedObject(self, &kRedDotKey, dot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    dot.hidden = !show;
}
__attribute__((constructor)) static void GJRedDotPatchEntry(void) {
    
    Class tabBarButtonClass = NSClassFromString(@"UITabBarButton");
    class_addMethod(tabBarButtonClass, @selector(_showRedDot:), (IMP)gj_showRedDot, "v@:B");

}