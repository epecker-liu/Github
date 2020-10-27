//
//  LCYHistoryRecordCell.h
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYHistoryRecordCell : UITableViewCell

@property (nonatomic, strong) NSArray *historyRecordArray;

- (void)updateWithModel:(NSString *)historyRecordLabel;

@end

NS_ASSUME_NONNULL_END
