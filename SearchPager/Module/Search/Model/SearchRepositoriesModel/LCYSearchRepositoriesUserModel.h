//
//  LCYSearchRepositoriesOwnerModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchRepositoriesUserModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *avatarURL;

@end

NS_ASSUME_NONNULL_END
