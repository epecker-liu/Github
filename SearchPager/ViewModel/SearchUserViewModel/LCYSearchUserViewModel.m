//
//  LCYSearchViewModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchUserViewModel.h"
#import "LCYFetchNetDataService.h"
#import "LCYSearchModel.h"

static NSString *const kSearchAPIString = @"https://api.github.com/search/users?q=%@&access_token=b637fbc4c06bf2ff2bc7c9943ccfd17381f5ee4c";

@interface LCYSearchUserViewModel()

@property (nonatomic, strong) LCYFetchNetDataService *fetchNetDataService;

@end

@implementation LCYSearchUserViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fetchNetDataService = [[LCYFetchNetDataService alloc] init];
    }
    return self;
}

- (void)fetchUsersInfo:(NSString *)para
{
    __weak typeof(self) weakSelf = self;
    NSString *searchURLString = [NSString stringWithFormat:kSearchAPIString, para];
    NSLog(@"search url is %@", searchURLString);
    [self.fetchNetDataService fetchDataFromURL:searchURLString completion:^ (NSMutableArray * _Nonnull data, NSError * _Nonnull err){
        if (err) {
            NSLog(@"fail");
        } else {
            NSMutableArray *userInfo = [[NSMutableArray alloc] init];
            LCYSearchModel *searchModel = [MTLJSONAdapter modelOfClass:[LCYSearchModel class] fromJSONDictionary:data error:nil];
            self.totalCount = [searchModel.totalCount intValue];
            for (int i = 0; i < searchModel.items.count; i++){
                [userInfo addObject:searchModel.items[i]];
            }
            weakSelf.userInfo = userInfo;
        }
    }];
}

@end