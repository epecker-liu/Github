//
//  LCYSearchModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *totalCount;
@property (nonatomic, strong) NSArray *items;

@end

NS_ASSUME_NONNULL_END
