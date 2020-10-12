//
//  LCYRepModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYRepModel.h"
#import <Mantle.h>

@implementation LCYRepModel

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"fullName": @"full_name",
        @"repOwners": @"owner"
    };
}

+ (NSValueTransformer *)repOwnersJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[LCYOwnerModel class]];
}

@end
