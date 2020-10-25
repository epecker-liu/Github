//
//  LCYSearchRepositoriesModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MTLModel.h"
#import "LCYSearchRepositoriesOwnerModel.h"
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchRepositoriesModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) LCYSearchRepositoriesOwnerModel *owner;
@property (nonatomic, strong) NSString *descriptionRepositories;
@property (nonatomic, strong) NSString *repositioryName;

@end

NS_ASSUME_NONNULL_END
