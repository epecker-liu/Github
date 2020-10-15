//
//  LCYItemModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYItemModel.h"
#import "LCYUserModel.h"

@implementation LCYItemModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"fullName" : @"full_name",
        @"owner" : @"owner",
    };
}

+ (NSValueTransformer *)ownerJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LCYUserModel.class];
}

@end
