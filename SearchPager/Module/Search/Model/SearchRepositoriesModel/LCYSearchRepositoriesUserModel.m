//
//  LCYSearchRepositoriesOwnerModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesUserModel.h"

@implementation LCYSearchRepositoriesUserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"userName" : @"login",
        @"avatarURL" : @"avatar_url",
    };
}


@end
