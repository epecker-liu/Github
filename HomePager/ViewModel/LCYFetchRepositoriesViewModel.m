//
//  LCYFetchRepositoriesViewModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYFetchRepositoriesViewModel.h"
#import "LCYFetchNetDataService.h"
#import "LCYItemModel.h"

static NSString *const kLCYRepoDataURL = @"https://api.github.com/users/epecker-liu/repos?access_token=b637fbc4c06bf2ff2bc7c9943ccfd17381f5ee4c";

@interface LCYFetchRepositoriesViewModel()

@property (nonatomic, strong) LCYFetchNetDataService *fetchNetDataService;

@end

@implementation LCYFetchRepositoriesViewModel

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
    [self.fetchNetDataService fetchDataFromURL:kLCYRepoDataURL completion:^(NSMutableArray * _Nonnull data ,NSError * _Nonnull err){
        if (err) {
            NSLog(@"fail");
        } else {
            NSMutableArray *repositoriesList = [[NSMutableArray alloc] init];
            for(int i = 0; i < [data count]; i++) {
                LCYItemModel *githubProjectName = [MTLJSONAdapter modelOfClass:[LCYItemModel class] fromJSONDictionary:data[i] error:nil];
                [repositoriesList addObject:githubProjectName];
            }
            NSLog(@"-----%@", repositoriesList);
            self.repositoriesList = repositoriesList;
        }
//        [self.repositoriesTableView.mj_header endRefreshing];
//        [self.repositoriesTableView.mj_footer endRefreshing];
    }];
}


@end
