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
#import "LCYConstValue.h"

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
    NSString *searchURLString = [NSString stringWithFormat:kSearchUserAPIString, para];
    [self.fetchNetDataService fetchDataFromURL:searchURLString completion:^ (NSMutableArray * _Nonnull data, NSError * _Nonnull err){
        if (err) {
            NSLog(@"fail");
        } else {
            NSMutableArray *userInfo = [[NSMutableArray alloc] init];
            LCYSearchModel *searchModel = [MTLJSONAdapter modelOfClass:[LCYSearchModel class] fromJSONDictionary:data error:nil];
            for (int i = 0; i < searchModel.items.count; i++){
                [userInfo addObject:searchModel.items[i]];
            }
            weakSelf.userInfo = userInfo;
        }
    }];
}

@end
