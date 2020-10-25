//
//  LCYSearchRepositoriesOwnerModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesOwnerModel.h"

@implementation LCYSearchRepositoriesOwnerModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"userName" : @"login",
        @"avatarURL" : @"avatar_url",
    };
}


@end
