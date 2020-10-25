//
//  LCYHistoryRecordViewModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/22.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYHistoryRecordViewModel.h"
#import <NSUserDefaults+RACSupport.h>
#import "LCYHistoryRecordModel.h"

@interface LCYHistoryRecordViewModel()


@end

@implementation LCYHistoryRecordViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.historyRecordModel = [[LCYHistoryRecordModel alloc] init];
    }
    return self;
}

- (void)getHistoryRecordFromPlist
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.historyRecordModel.historyRecordArray = [defaults arrayForKey:@"historyRecord"];
}

@end
