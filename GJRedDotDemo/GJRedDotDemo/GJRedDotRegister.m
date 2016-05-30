//
//  GJRedDotRegister.m
//  GJRedDotDemo
//
//  Created by wangyutao on 16/5/23.
//  Copyright © 2016年 wangyutao. All rights reserved.
//

#import "GJRedDotRegister.h"

NSString *const GJTabBar2 = @"GJTabBar2";

NSString *const GJGroupKey = @"GJAllGays";

NSString *const GJSunnyxxKey = @"GJSunnyxxIsGay";
NSString *const GJUncleBirdKey = @"GJUncleBird";
NSString *const GJSarkKey = @"GJSarkIsGay";

@implementation GJRedDotRegister

+ (NSArray *)registProfiles {
    return @[
             
             @{GJTabBar2:@{GJGroupKey:@[
                                   GJSunnyxxKey,
                                   GJUncleBirdKey,
                                   //GJSarkKey
                                   ]
                           }
               }
             ];
}

@end
