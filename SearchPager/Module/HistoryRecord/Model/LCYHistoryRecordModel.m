//
//  LCYHistoryRecordModel.m
//  GitHub
//
//  Created by bytedance on 2020/10/22.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "LCYHistoryRecordModel.h"

@implementation LCYHistoryRecordModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.historyRecordArray = [[NSArray alloc] init];
    }
    return self;
}

@end
