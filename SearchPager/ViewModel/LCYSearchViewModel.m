//
//  LCYSearchViewModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYSearchViewModel.h"
#import "LCYFetchNetDataService.h"
#import "LCYSearchModel.h"

static NSString *const kSearchAPIString = @"https://api.github.com/search/users?q=%@&access_token=b637fbc4c06bf2ff2bc7c9943ccfd17381f5ee4c";

@interface LCYSearchViewModel()

@property (nonatomic, strong) LCYFetchNetDataService *fetchNetDataService;

@end

@implementation LCYSearchViewModel

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
    NSString *searchURLString = [NSString stringWithFormat:kSearchAPIString, para];
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
            self.userInfo = userInfo;
        }
    }];
}

@end
