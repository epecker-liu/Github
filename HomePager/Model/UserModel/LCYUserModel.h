//
//  LCYFullNameModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYUserModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *imageUrl;

@end

NS_ASSUME_NONNULL_END
