//
//  LCYSearchViewModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchUserViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *userInfo;
@property (nonatomic, assign) NSUInteger totalCount;

- (void)fetchUsersInfo:(NSString *)para;

@end

NS_ASSUME_NONNULL_END
