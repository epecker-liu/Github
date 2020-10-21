//
//  LCYSearchModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchModel.h"
#import "LCYSearchUserModel.h"

@implementation LCYSearchModel


+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"totalCount" : @"total_count",
        @"items" : @"items",
    };
}

+ (NSValueTransformer *)itemsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:LCYSearchUserModel.class];
}

+ (NSValueTransformer *)totalCountJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^ id(id value, BOOL *success, NSError *__autoreleasing *error){
        return [NSString stringWithFormat:@"%@",value];
    }];
}

@end
