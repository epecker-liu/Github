//
//  LCYFullNameModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYUserModel.h"

@implementation LCYUserModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"imageUrl" : @"avatar_url",
    };
}

@end
