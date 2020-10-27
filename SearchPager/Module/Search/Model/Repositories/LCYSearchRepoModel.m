//
//  LCYSearchRepoModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepoModel.h"
#import "LCYSearchRepositoriesModel.h"

@implementation LCYSearchRepoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"totalCount" : @"total_count",
        @"items" : @"items",
    };
}

+ (NSValueTransformer *)itemsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:LCYSearchRepositoriesModel.class];
}

+ (NSValueTransformer *)totalCountJSONTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^ id(id value, BOOL *success, NSError *__autoreleasing *error){
        return [NSString stringWithFormat:@"%@",value];
    }];
}


@end
