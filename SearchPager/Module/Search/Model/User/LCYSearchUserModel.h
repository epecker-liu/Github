//
//  LCYSearchUserModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/19.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchUserModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *avatarURL;

@end

NS_ASSUME_NONNULL_END
