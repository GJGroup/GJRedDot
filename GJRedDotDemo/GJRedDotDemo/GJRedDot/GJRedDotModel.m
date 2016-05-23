//
//  GJRedDotModel.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/20.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "GJRedDotModel.h"

@implementation GJRedDotModel

- (NSMutableArray<id<GJRedDotModelProtocol>> *)subDots {
    if (!_subDots) {
        _subDots = [NSMutableArray arrayWithCapacity:0];
    }
    return _subDots;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"key:%@ show:%@ parentKey:%@ subCount:%@",self.key,self.show,self.parent.key,@(self.subDots.count)];
}
@end
