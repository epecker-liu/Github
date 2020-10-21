//
//  LCYSearchCellTableViewCell.h
//  GitHub
//
//  Created by bytedance on 2020/10/21.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCYSearchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchCellTableViewCell : UITableViewCell

- (void)updateWithModel:(LCYSearchModel *)model;

@end

NS_ASSUME_NONNULL_END
