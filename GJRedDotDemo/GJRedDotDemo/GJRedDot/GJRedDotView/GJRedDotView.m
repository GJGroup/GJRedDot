//
//  GJRedDotView.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/24.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "GJRedDotView.h"

BOOL hasSetGJDefault;

static CGFloat __GJDefaultRedius = 3;
static CGFloat GJDefaultRedius = 3;
static UIColor *GJDefaultColor;

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

static BOOL _initFinished;
static NSHashTable *_needSetDefaultViews;

@implementation GJRedDotView

+ (NSHashTable *)needSetDefaultViews {
    if (!_needSetDefaultViews) {
        _needSetDefaultViews = [NSHashTable weakObjectsHashTable];
    }
    return _needSetDefaultViews;
}

//this metho only be called once
+ (void)initFinished {
    _initFinished = YES;
    BOOL needSetRedius = GJDefaultRedius != __GJDefaultRedius;
    BOOL needSetColor  = GJDefaultColor;
    if (!needSetColor && !needSetRedius) {
        [[self needSetDefaultViews] removeAllObjects];
        return;
    }
    for (GJRedDotView *view in [self needSetDefaultViews]) {
        
        if (needSetRedius) [view setRadius:GJDefaultRedius];
        
        if (needSetColor) [view setColor:GJDefaultColor];
    }
    
    [[self needSetDefaultViews] removeAllObjects];
}

+ (void)setDefaultRadius:(CGFloat)radius {
    GJDefaultRedius = radius;
}

+ (void)setDefaultColor:(UIColor *)color {
    GJDefaultColor = color;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _borderColor = [UIColor whiteColor];
        self.radius = GJDefaultRedius;
        self.color = GJDefaultColor ? GJDefaultColor :[UIColor redColor];
        self.offset = CGPointZero;
        self.contentMode = UIViewContentModeCenter;
        if (!_initFinished) {
            [[self.class needSetDefaultViews] addObject:self];
        }
    }
    return self;
}

- (void)setOffset:(CGPoint)offset {
    if (CGPointEqualToPoint(offset, _offset)) return;
    _offset = offset;
    [self _refreshFrame];
}

- (void)setRadius:(CGFloat)radius {
    if (_radius == radius) return;
    _radius = radius;
    [self _refreshView];
}

- (void)setColor:(UIColor *)color {
    if (CGColorEqualToColor(color.CGColor, _color.CGColor)) return;
    _color = color;
    [self _refreImage];
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (CGColorEqualToColor(borderColor.CGColor, _borderColor.CGColor)) return;
    _borderColor = borderColor;
    [self _refreImage];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (_borderWidth == borderWidth) return;
    _borderWidth = borderWidth;
    [self _refreImage];
}

- (void)_refreImage {
    self.image = gj_createCircleImage(self.color, self.radius, self.borderWidth, self.borderColor);
}

- (void)_refreshFrame {
    self.bounds = CGRectMake(0, 0, self.radius * 2, self.radius * 2);
    !self.refreshBlock ?: self.refreshBlock(self);
}

- (void)_refreshView {
    [self _refreImage];
    [self _refreshFrame];
}


@end

@interface GJBadgeView ()

@property (nonatomic, strong) UILabel *badgeLabel;

@end

@implementation GJBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [gj_createCircleImage([UIColor redColor], 8, 0, nil) resizableImageWithCapInsets:UIEdgeInsetsMake(0, 8, 0, 8)];
        [self addSubview:self.badgeLabel];
        [self _badgeLabelLayout];
        self.contentMode = UIViewContentModeScaleToFill;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    if ([_badgeValue isEqualToString:badgeValue]) return;
    _badgeValue = [badgeValue copy];
    
    self.badgeLabel.text = _badgeValue;
}

- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [UILabel new];
        _badgeLabel.font = [UIFont systemFontOfSize:12];
        _badgeLabel.textColor = [UIColor whiteColor];
        _badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

- (void)_badgeLabelLayout {
    NSLayoutConstraint *layoutX = [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0];
    NSLayoutConstraint *layoutY = [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0];
    NSLayoutConstraint *layoutLeft = [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:self
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1
                                                                   constant:3];
    NSLayoutConstraint *layoutRight = [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1
                                                                    constant:3];
    NSLayoutConstraint *layoutWidth = [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                                                      toItem:nil
                                                                   attribute:0
                                                                  multiplier:1
                                                                    constant:80];
    [self addConstraint:layoutX];
    [self addConstraint:layoutY];
    [self addConstraint:layoutLeft];
    [self addConstraint:layoutRight];
    [self addConstraint:layoutWidth];
    
}

@end