//
//  LCYSearchRepositoriesViewModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchRepositoriesViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *repositoriesInfo;
@property (nonatomic, assign) NSUInteger totalCount;

- (void)fetchRepositoriesInfo:(NSString *)para;

@end

NS_ASSUME_NONNULL_END
