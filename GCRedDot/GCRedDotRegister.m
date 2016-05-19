//
//  GCRedDotRegister.m
//  GoldenCreditease
//
//  Created by wangyutao on 16/5/17.
//  Copyright © 2016年 GJGroup. All rights reserved.
//

#import "GCRedDotRegister.h"
#import "GCRedDotConfig.h"

@implementation GCRedDotRegister

+ (NSArray *)regist {
    NSArray *regist =
    @[
      @{GCRedDotTabCommunityKey:@[GCRedDotEduKey,
                                  GCRedDotHouseKey,
                                  GCRedDotPensionKey]
        }
      ];
    return regist;
}

@end
