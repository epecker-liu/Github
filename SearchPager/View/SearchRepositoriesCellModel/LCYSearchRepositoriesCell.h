//
//  LCYSearchRepositoriesCellCollectionViewCell.h
//  GitHub
//
//  Created by bytedance on 2020/10/23.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCYSearchRepositoriesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCYSearchRepositoriesCell : UICollectionViewCell

- (void)updateWithModel:(LCYSearchRepositoriesModel *)model;

@end

NS_ASSUME_NONNULL_END
