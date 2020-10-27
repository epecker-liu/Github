//
//  LCYSearchRepoModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import "LCYSearchRepositoriesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchRepoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *totalCount;
@property (nonatomic, strong) NSArray<LCYSearchRepositoriesModel *> *items;
@end

NS_ASSUME_NONNULL_END
