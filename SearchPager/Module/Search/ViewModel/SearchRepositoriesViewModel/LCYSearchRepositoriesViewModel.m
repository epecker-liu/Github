//
//  LCYSearchRepositoriesViewModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/25.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchRepositoriesViewModel.h"
#import "LCYSearchRepoModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LCYFetchNetDataService.h"
#import "LCYConstValue.h"



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
    @weakify(self);
    NSString *searchURLString = [NSString stringWithFormat:kSearchRepositoriesAPIString, para];
    [self.fetchNetDataService fetchDataFromURL:searchURLString completion:^ (NSMutableArray * _Nonnull data, NSError * _Nonnull err){
        @strongify(self);
        if (err) {
            NSLog(@"fail");
        } else {
            NSMutableArray *repositoriesInfo = [[NSMutableArray alloc] init];
            LCYSearchRepoModel *searchModel = [MTLJSONAdapter modelOfClass:[LCYSearchRepoModel class] fromJSONDictionary:data error:nil];
            for (int i = 0; i < searchModel.items.count; i++){
                [repositoriesInfo addObject:searchModel.items[i]];
            }
            self.repositoriesInfo = repositoriesInfo;
        }
    }];
}

@end
