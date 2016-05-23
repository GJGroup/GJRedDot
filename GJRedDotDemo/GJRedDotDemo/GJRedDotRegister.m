//
//  GJRedDotRegister.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/23.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "GJRedDotRegister.h"

NSString *const GJGroupKey = @"AllGays";

NSString *const GJSunnyxxKey = @"SunnyxxIsGay";
NSString *const GJUncleBirdKey = @"UncleBird";
NSString *const GJSardKey = @"SarkIsGay";

@implementation GJRedDotRegister

+ (NSArray *)registProfiles {
    return @[
             @{GJGroupKey:@[
                       GJSunnyxxKey,
                       GJUncleBirdKey,
                       GJSardKey
                       ]
                 }
             ];
}

@end
