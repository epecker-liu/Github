//
//  LCYRepCellTableViewCell.h
//  GitHub
//
//  Created by bytedance on 2020/10/13.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LCYUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface LCYRepCell : UITableViewCell

- (void)updateWithModel:(LCYUserModel *)model;

@end

NS_ASSUME_NONNULL_END
