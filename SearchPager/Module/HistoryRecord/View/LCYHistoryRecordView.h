//
//  LCYHistoryRecordView.h
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCYHistoryRecordView : UIView

- (void)updateSearchString:(NSString *)searchString;

@property (nonatomic, copy) NSString *searchString;

@end

NS_ASSUME_NONNULL_END
