//
//  LCYSearchRepositoriesModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesModel.h"
#import "LCYSearchRepositoriesOwnerModel.h"

@implementation LCYSearchRepositoriesModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"owner" : @"owner",
        @"repositioryName" : @"name",
        @"descriptionRepositories" : @"description",
    };
}

+ (NSValueTransformer *)ownerJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:LCYSearchRepositoriesOwnerModel.class];
}

@end
