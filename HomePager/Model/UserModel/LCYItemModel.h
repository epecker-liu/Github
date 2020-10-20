//
//  LCYItemModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "LCYUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCYItemModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) LCYUserModel *owner;

@end

NS_ASSUME_NONNULL_END
