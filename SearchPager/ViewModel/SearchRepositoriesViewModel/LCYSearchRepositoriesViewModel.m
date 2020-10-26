//
//  LCYSearchRepositoriesViewModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesViewModel.h"
#import "LCYFetchNetDataService.h"
#import "LCYSearchRepoModel.h"

static NSString *const kSearchAPIString = @"https://api.github.com/search/repositories?q=%@&access_token=b637fbc4c06bf2ff2bc7c9943ccfd17381f5ee4c";


@interface LCYSearchRepositoriesViewModel()

@property (nonatomic, strong) LCYFetchNetDataService *fetchNetDataService;

@end

@implementation LCYSearchRepositoriesViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fetchNetDataService = [[LCYFetchNetDataService alloc] init];
    }
    return self;
}

- (void)fetchRepositoriesInfo:(NSString *)para
{
    __weak typeof(self) weakSelf = self;
    NSString *searchURLString = [NSString stringWithFormat:kSearchAPIString, para];
    [self.fetchNetDataService fetchDataFromURL:searchURLString completion:^ (NSMutableArray * _Nonnull data, NSError * _Nonnull err){
        if (err) {
            NSLog(@"fail");
        } else {
            NSMutableArray *repositoriesInfo = [[NSMutableArray alloc] init];
            LCYSearchRepoModel *searchModel = [MTLJSONAdapter modelOfClass:[LCYSearchRepoModel class] fromJSONDictionary:data error:nil];
            self.totalCount = [searchModel.totalCount intValue];
            for (int i = 0; i < searchModel.items.count; i++){
                [repositoriesInfo addObject:searchModel.items[i]];
            }
            weakSelf.repositoriesInfo = repositoriesInfo;
        }
    }];
}

@end
