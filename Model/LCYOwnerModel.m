//
//  LCYOwnerModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYOwnerModel.h"

@implementation LCYOwnerModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"imageUrl": @"avatar_url"
    };
}

@end
