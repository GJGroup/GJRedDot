//
//  GJRedDotView.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/24.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "GJRedDotView.h"

static const CGFloat GJDefaultRedius = 3;

//create cornerRatius red dot
static UIImage* gj_createCircleImage(UIColor *color,
                                     CGFloat radius,
                                     CGFloat borderWidth,
                                     UIColor *boarderColor) {
    
    CGRect rect = CGRectMake(0, 0, radius * 2, radius * 2);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    if (borderWidth > 0 && boarderColor) {
        rect = CGRectMake(borderWidth/2, borderWidth/2, rect.size.width - borderWidth, rect.size.width - borderWidth);
    }
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    [color setFill];
    [roundedRectanglePath fill];
    
    if (borderWidth > 0 && boarderColor) {
        [boarderColor setStroke];
        roundedRectanglePath.lineWidth = borderWidth;
        [roundedRectanglePath stroke];
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@interface GJRedDotView ()
@property (nonatomic, weak) NSLayoutConstraint *layoutCenterX;
@property (nonatomic, weak) NSLayoutConstraint *layoutCenterY;
@end

@implementation GJRedDotView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _borderColor = [UIColor whiteColor];
        self.radius = GJDefaultRedius;
        self.color = [UIColor redColor];
        self.contentMode = UIViewContentModeCenter;
   
    }
    return self;
}

- (void)setRadius:(CGFloat)radius {
    if (_radius == radius) return;
    _radius = radius;
    self.image = gj_createCircleImage(self.color, self.radius, self.borderWidth, self.borderColor);
    self.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
}

- (void)setColor:(UIColor *)color {
    if (CGColorEqualToColor(color.CGColor, _color.CGColor)) return;
    _color = color;
    self.image = gj_createCircleImage(self.color, self.radius, self.borderWidth, self.borderColor);
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (CGColorEqualToColor(borderColor.CGColor, _borderColor.CGColor)) return;
    _borderColor = borderColor;
    self.image = gj_createCircleImage(self.color, self.radius, self.borderWidth, self.borderColor);
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (_borderWidth == borderWidth) return;
    _borderWidth = borderWidth;
    self.image = gj_createCircleImage(self.color, self.radius, self.borderWidth, self.borderColor);
}

@end