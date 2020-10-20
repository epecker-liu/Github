//
//  LCYFetchRepositoriesViewModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYFetchRepositoriesViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *repositoriesList;

- (void)fetchRepositories;

@end

NS_ASSUME_NONNULL_END
