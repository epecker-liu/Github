//
//  LCYRepModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/12.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "MTLModel.h"
#import "LCYOwnerModel.h"
#import <Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYRepModel : MTLModel


@property(nonatomic, strong) LCYOwnerModel *repOwners;
@property(nonatomic, copy) NSString *fullName;

@end

NS_ASSUME_NONNULL_END
