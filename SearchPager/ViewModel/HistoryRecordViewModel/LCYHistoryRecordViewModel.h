//
//  LCYHistoryRecordViewModel.h
//  GitHub
//
//  Created by bytedance on 2020/10/22.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCYHistoryRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

//@class LCYHistoryRecordModel;

@interface LCYHistoryRecordViewModel : NSObject

//@property (nonatomic, strong) NSArray *historyRecordArray;
@property (nonatomic, strong) LCYHistoryRecordModel *historyRecordModel;

- (void)getHistoryRecordFromPlist;

@end

NS_ASSUME_NONNULL_END
