//
//  LCYSearchRepositoriesModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MTLModel.h"
#import "LCYSearchRepositoriesUserModel.h"
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchRepositoriesModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) LCYSearchRepositoriesUserModel *owner;
@property (nonatomic, copy) NSString *descriptionRepositories;
@property (nonatomic, copy) NSString *repositioryName;

@end

NS_ASSUME_NONNULL_END
