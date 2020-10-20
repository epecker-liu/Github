//
//  LCYSearchUserModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchUserModel.h"

@implementation LCYSearchUserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"userName" : @"login",
        @"avatarURL" : @"avatar_url",
    };
}

@end
