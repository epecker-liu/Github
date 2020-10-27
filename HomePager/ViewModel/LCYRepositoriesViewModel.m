//
//  LCYFetchRepositoriesViewModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYRepositoriesViewModel.h"
#import "LCYFetchNetDataService.h"
#import "LCYItemModel.h"
#import "LCYConstValue.h"

@interface LCYRepositoriesViewModel()

@property (nonatomic, strong) LCYFetchNetDataService *fetchNetDataService;

@end

@implementation LCYRepositoriesViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fetchNetDataService = [[LCYFetchNetDataService alloc] init];
    }
    return self;
}

- (void)fetchRepositories
{
    __weak typeof(self) weakSelf = self;
    [self.fetchNetDataService fetchDataFromURL:kLCYRepoDataURL completion:^(NSMutableArray * _Nonnull data ,NSError * _Nonnull err){
        if (err) {
            NSLog(@"fail");
        } else {
            NSMutableArray *repositoriesList = [[NSMutableArray alloc] init];
            for (int i = 0; i < [data count]; i++) {
                LCYItemModel *githubProjectName = [MTLJSONAdapter modelOfClass:[LCYItemModel class] fromJSONDictionary:data[i] error:nil];
                [repositoriesList addObject:githubProjectName];
            }
            weakSelf.repositoriesList = repositoriesList;
        }
    }];
}


@end
